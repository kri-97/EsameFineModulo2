
USE  ToysGroup_NapaKristian;

/* Creazione View per Calcolare SalesAmount per ogni prodotto all'interno di un ordine*/
CREATE VIEW vw_salesAmount AS(
    SELECT  `salesNumber`
            ,`salesLineNumber`
            , p.`idProduct`
            ,`orderQuantity`
            , `listPrice`
            , (`listPrice` * `orderQuantity`) AS salesAmount
    FROM product p
        JOIN salesdetails sd ON p.`idProduct` = sd.`idProduct`
    ORDER BY `salesNumber`,`salesLineNumber`
);

/*1. Verificare che i campi definiti come PK siano univoci. */

-- Osservazione 1: raggruppando la colonna definita come PK
--              se si ha un count > 1 allora la colonna non è univoca
--              pertanto, la prima query deve restituire 0 righe
-- Osservazione 2: la funzione COUNT esclude i null 
--              quindi il numero dei record deve essere uguale 
--              al numero dei valori della colonna definita come PK
--              pertanto, nella seconda query il risultato deve essere 1 (TRUE)

-- controllo sulla tabella category
SELECT `idCategory`, COUNT(*) 
FROM category 
GROUP BY `idCategory` 
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`idCategory`) as "isPrimaryKey?"
FROM category;

-- controllo sulla tabella city
SELECT `idCity`, COUNT(*) 
FROM city 
GROUP BY `idCity` 
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`idCity`) "isPrimaryKey?"
FROM city;

-- controllo sulla tabella client
SELECT `idClient`, COUNT(*) 
FROM client 
GROUP BY `idClient` 
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`idClient`) "isPrimaryKey?"
FROM client;

-- controllo sulla tabella product
SELECT `idProduct`, COUNT(*) 
FROM product 
GROUP BY `idProduct` 
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`idProduct`) "isPrimaryKey?"
FROM product;

-- controllo sulla tabella region
SELECT `idRegion`, COUNT(*) 
FROM region 
GROUP BY `idRegion` 
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`idRegion`) "isPrimaryKey?"
FROM region;

-- controllo sulla tabella sales
SELECT `salesNumber`, COUNT(*) 
FROM sales 
GROUP BY `salesNumber`
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(`salesNumber`) "isPrimaryKey?"
FROM sales;

-- controllo sulla tabella salesdetails
SELECT `salesNumber`, `salesLineNumber`, COUNT(*) 
FROM salesdetails 
GROUP BY `salesNumber`, `salesLineNumber`
HAVING COUNT(*) > 1;

SELECT COUNT(*) = COUNT(DISTINCT `salesNumber`,`salesLineNumber`) "isPrimaryKey?"
FROM salesdetails;


/*2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.*/

SELECT p.`productName`
    , fatturatoPerAnno.annoDiRiferimento
    , fatturatoPerAnno.totaleFatturato
FROM(
        SELECT sd.`idProduct` as idProdotto
            , YEAR(s.`orderDate`) as annoDiRiferimento
            , SUM (vw.`salesAmount`) as totaleFatturato
        FROM sales s
            JOIN salesdetails sd ON s.`salesNumber` = sd.`salesNumber`
            JOIN vw_salesamount vw ON vw.`salesNumber` = sd.`salesNumber` AND vw.`salesLineNumber` = sd.`salesLineNumber`
        GROUP BY sd.`idProduct`,YEAR(s.`orderDate`)
        ORDER BY sd.`idProduct`,YEAR(s.`orderDate`)) as fatturatoPerAnno
    JOIN product p ON fatturatoPerAnno.idProdotto = p.`idProduct`;

-- Approfondimento della query precedente perchè alcuni prodotti hanno fatturato solo un anno
CREATE VIEW vw_fatturato_Per_Anno AS(
SELECT sd.`idProduct` as idProdotto
    , YEAR(s.`orderDate`) as annoDiRiferimento
    , SUM (vw.`salesAmount`) as totaleFatturato
FROM sales s
    JOIN salesdetails sd ON s.`salesNumber` = sd.`salesNumber`
    JOIN vw_salesamount vw ON vw.`salesNumber` = sd.`salesNumber` AND vw.`salesLineNumber` = sd.`salesLineNumber`
GROUP BY sd.`idProduct`,YEAR(s.`orderDate`)
ORDER BY sd.`idProduct`,YEAR(s.`orderDate`));

-- 2.1. Di questi prodotti, quali tra loro sono stati venduti solo in un anno?

SELECT vw.idProdotto as prod
FROM vw_fatturato_per_anno vw
GROUP BY vw.idProdotto
HAVING COUNT(*) = 1;

CREATE VIEW vw_prodottiVenduti_In_Un_Anno_Solo AS(
SELECT vw.idProdotto as prod
FROM vw_fatturato_per_anno vw
GROUP BY vw.idProdotto
HAVING COUNT(*) = 1); 

-- 2.2 In quale anno hanno venduto quest'ultimi prodotti?

SELECT `idProdotto`, `annoDiRiferimento`,`totaleFatturato`
FROM vw_fatturato_per_anno vw1
    JOIN vw_prodottivenduti_in_un_anno_solo vw2 ON vw1.`idProdotto` = vw2.prod;


/*3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.*/

SELECT r.`regionName`
    , YEAR(s.`orderDate`) as annoDiRiferimento 
    , SUM(vw.`salesAmount`) as fatturato
FROM sales s
    JOIN vw_salesamount vw ON s.`salesNumber` = vw.`salesNumber`
    JOIN city c ON c.`idCity` = s.`idCity`
    JOIN region r ON c.`idRegion` = r.`idRegion`
GROUP BY r.`idRegion`, YEAR(s.`orderDate`)
ORDER BY annoDiRiferimento, fatturato DESC;

/*4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? */

SELECT c.`categoryName`, COUNT(sd.`orderQuantity`) as numeroDiOrdini
FROM salesdetails sd
    JOIN product p ON p.`idProduct` = sd.`idProduct`
    JOIN category c ON c.`idCategory` = p.`idCategory`
GROUP BY c.`idCategory`
ORDER BY numeroDiOrdini DESC
LIMIT 1; --togliere il limit per visualizzare anche il numero di ordini delle altre categorie


/*5. Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.*/ 

SELECT *
FROM product p
    LEFT JOIN salesdetails s ON p.`idProduct` = s.`idProduct`
WHERE s.`idProduct` IS NULL;

SELECT *
FROM product p 
WHERE p.`idProduct` NOT IN (SELECT DISTINCT `idProduct`
                            FROM salesdetails );


/*6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).*/

SELECT p.`productName` as Prodotto
    , MAX(s.`orderDate`) as ultimaData
FROM sales s 
    JOIN salesdetails sl ON s.`salesNumber` = sl.`salesNumber`
    JOIN product p ON p.`idProduct` = sl.`idProduct`
GROUP BY p.`idProduct`
ORDER BY ultimaData;


-- Query Extra per trovare insights interessanti

/* Quali sono le 10 città ha avuto più ordini? */

SELECT c.`cityName`, COUNT(s.`salesNumber`) as numeroOrdini
FROM city c
    JOIN sales s ON c.`idCity` = s.`idCity`
GROUP BY c.`idCity`
ORDER BY numeroOrdini DESC
LIMIT 10;

/* Esistono città in cui non ci sono stati ordini?*/
SELECT COUNT(*) AS result
FROM city c
WHERE c.`idCity` NOT IN(SELECT DISTINCT `idCity` FROM sales);


/* Per ogni città trovare il prodotto più venduto*/

CREATE VIEW vw_cittaProdottoVendite AS(
SELECT c.`idCity` as idCity
    , p.`idProduct` as idProduct
    , SUM(`orderQuantity`) as numeroDiVendite
FROM city c
    JOIN sales s ON c.`idCity` = s.`idCity`
    JOIN salesdetails sd ON s.`salesNumber` = sd.`salesNumber`
    JOIN product p ON p.`idProduct` = sd.`idProduct`
GROUP BY c.`idCity`, p.`idProduct`
ORDER BY idCity, numeroDiVendite DESC);

SELECT c.`idCity`, c.`cityName`, p.`idProduct`, p.`productName`
    ,subquery2.numeroMax as quantitaVendute
FROM(SELECT citta as city, cpv2.`idProduct` as product, subquery.numeroMaxDiVendite as numeroMax
    FROM
        (SELECT cpv.idCity as citta, MAX(cpv.numeroDiVendite) as numeroMaxDiVendite
        FROM  vw_cittaProdottoVendite cpv
        GROUP BY cpv.idCity) subquery
        JOIN vw_cittaProdottoVendite cpv2 ON cpv2.idCity = subquery.citta
            AND cpv2.numeroDiVendite = subquery.numeroMaxDiVendite) as subquery2
    JOIN city c ON c.`idCity` = subquery2.city
    JOIN product p ON p.`idProduct` = subquery2.product;




/* Qual è il prodotto più venduto in Australia? */
SELECT p.`productName`, SUM(sd.`orderQuantity`) as numeroDiVendite
FROM product p
    JOIN salesdetails sd ON p.`idProduct` = sd.`idProduct`
    JOIN sales s ON s.`salesNumber` = sd.`salesNumber`
    JOIN city c ON c.`idCity` = s.`idCity`
    JOIN region r ON c.`idRegion` = r.`idRegion`
WHERE r.`regionName` = "Australia"
GROUP BY p.`idProduct`
ORDER BY numeroDiVendite DESC
LIMIT 1;


/* Qual è la categoria che ha portato più vendite in Australia? */
SELECT cat.`categoryName`, SUM(sd.`orderQuantity`) as numeroDiVendite
FROM salesdetails sd
    JOIN product p ON p.`idProduct` = sd.`idProduct`
    JOIN category cat ON cat.`idCategory` = p.`idCategory`
    JOIN sales s ON s.`salesNumber` = sd.`salesNumber`
    JOIN city c ON c.`idCity` = s.`idCity`
    JOIN region r ON c.`idRegion` = r.`idRegion`
WHERE r.`regionName` = "Australia"
GROUP BY cat.`idCategory`
ORDER BY numeroDiVendite DESC;


/* Qual è il cliente che ha effettuato più ordini? */
SELECT c.`idClient`, COUNT(DISTINCT s.`salesNumber`) as numeroOrdini
FROM client c
    JOIN sales s ON c.`idClient` = s.`idClient`
GROUP BY c.`idClient`
ORDER BY numeroOrdini DESC;


/* Esistono clienti che non hanno effettuato ordini?*/
SELECT *
FROM client c
WHERE c.`idClient` NOT IN (SELECT DISTINCT `idClient` FROM sales);


/* Ottenere il numero di ordini effettuati distinguendo i clienti per sesso*/
SELECT c.gender, COUNT(s.`salesNumber`)
FROM client c
    JOIN sales s ON c.`idClient` = s.`idClient`
GROUP BY c.gender;

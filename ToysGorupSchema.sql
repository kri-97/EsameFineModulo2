-- Active: 1731198039901@@127.0.0.1@3306@ToysGroup_NapaKristian

/* CREATE and USE database */
CREATE DATABASE ToysGroup_NapaKristian;
USE ToysGroup_NapaKristian;


/* CREATE TABLES - Entità Forti */
CREATE TABLE client (
    idClient INT AUTO_INCREMENT PRIMARY KEY
    ,firstName VARCHAR(40) NOT NULL
    ,lastName VARCHAR(40) NOT NULL
    ,gender CHAR(1) NOT NULL
    ,birthdate DATE NOT NULL
    ,telNumber VARCHAR(25) NOT NULL
)

CREATE TABLE region (
    idRegion INT AUTO_INCREMENT PRIMARY KEY
    ,regionName VARCHAR(40) NOT NULL
)

CREATE TABLE category (
    idCategory INT AUTO_INCREMENT PRIMARY KEY
    ,categoryName VARCHAR(40) NOT NULL
)

/* CREATE TABLES - Entità Deboli */

CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY
    ,productName VARCHAR(40) NOT NULL
    ,productionCost decimal(10,2) NOT NULL
    ,listPrice decimal(10,2) NOT NULL
    ,idCategory INT NOT NULL
    ,FOREIGN KEY (idCategory) REFERENCES category(idCategory)
)

CREATE TABLE city (
    idCity INT AUTO_INCREMENT PRIMARY KEY
    ,idRegion INT NOT NULL
    ,cityName VARCHAR(40) NOT NULL
    ,FOREIGN KEY (idRegion) REFERENCES region(idRegion)
)


CREATE TABLE sales (
    salesNumber INT AUTO_INCREMENT PRIMARY KEY
    ,idCity INT NOT NULL
    ,idClient INT NOT NULL
    ,address VARCHAR(100) NOT NULL
    ,orderDate DATE NOT NULL
    ,FOREIGN KEY (idCity) REFERENCES city(idCity)
    ,FOREIGN KEY (idClient) REFERENCES client(idClient)
    ,UNIQUE (idClient,orderDate)
)



CREATE TABLE salesdetails (
    salesNumber INT NOT NULL
    ,salesLineNumber INT NOT NULL
    ,orderQuantity INT NOT NULL
    ,idProduct INT NOT NULL
    ,PRIMARY KEY(salesNumber,SalesLineNumber)
    ,FOREIGN KEY (idProduct) REFERENCES product(idProduct)
    ,FOREIGN KEY (salesNumber) REFERENCES sales(salesNumber)
)


/* INSERT INTO TABLES - Popolamento Tabelle */

INSERT INTO category (categoryName) VALUES ('Elettronica'),('Abbigliamento'),('Cucina'),('Arredamento'),('Giardinaggio');
INSERT INTO client (firstName, lastName, gender, birthDate, telNumber) 
VALUES
('Mario', 'Rossi', 'M', '1980-03-15', '1234567890'),
('Luca', 'Bianchi', 'M', '1992-07-22', '0987654321'),
('Giulia', 'Verdi', 'F', '1985-11-11', '3456789012'),
('Francesca', 'Gialli', 'F', '1990-01-01', '3216549870'),
('Alessandro', 'Neri', 'M', '1988-02-20', '2345678901'),
('Simona', 'Blu', 'F', '1995-06-12', '4567891230'),
('Carlo', 'Marrone', 'M', '1982-04-18', '5678904321'),
('Elena', 'Rossi', 'F', '1989-12-05', '6789012345'),
('Marco', 'Verdi', 'M', '1994-09-10', '7890123456'),
('Lucia', 'Bianchi', 'F', '1983-08-25', '8901234567'),
('Stefano', 'Gialli', 'M', '1990-02-15', '9012345678'),
('Paola', 'Neri', 'F', '1979-05-30', '1231231234'),
('Antonio', 'Blu', 'M', '1987-10-10', '2342342345'),
('Claudia', 'Rossi', 'F', '1991-03-17', '3453453456'),
('Giorgio', 'Bianchi', 'M', '1986-07-04', '4564564567'),
('Francesco', 'Gialli', 'M', '1993-11-23', '5675675678'),
('Sara', 'Neri', 'F', '1990-09-14', '6786786789'),
('Giovanni', 'Blu', 'M', '1981-06-06', '7897897890'),
('Chiara', 'Rossi', 'F', '1996-04-21', '8908908901'),
('Paolo', 'Verdi', 'M', '1984-12-13', '9019019012'),
('Maria', 'Bianchi', 'F', '1992-10-30', '0123456789'),
('Fabio', 'Gialli', 'M', '1985-05-09', '1234567891'),
('Laura', 'Neri', 'F', '1988-01-17', '2345678902'),
('Simone', 'Blu', 'M', '1993-02-02', '3456789013'),
('Michele', 'Rossi', 'M', '1991-12-01', '4567891234'),
('Stefania', 'Bianchi', 'F', '1990-07-25', '5678904322'),
('Andrea', 'Gialli', 'M', '1997-03-08', '6789012346'),
('Roberta', 'Neri', 'F', '1982-11-22', '7890123457'),
('Francesca', 'Blu', 'F', '1984-09-09', '8901234568'),
('Giuseppe', 'Rossi', 'M', '1980-06-15', '9012345679'),
('Martina', 'Bianchi', 'F', '1995-10-20', '0123456780');

INSERT INTO region (regionName) VALUES('Italia'),('Francia'),('Giappone'),('Stati Uniti'),('Germania'),('Canada'),('Australia');

INSERT INTO city (cityName, idRegion) VALUES
-- Italia (idRegion = 1)
('Roma', 1), ('Milano', 1), ('Napoli', 1), ('Torino', 1), ('Firenze', 1),
('Bologna', 1), ('Venezia', 1), ('Genova', 1), ('Verona', 1),('Palermo', 1),
-- Stati Uniti (idRegion = 2)
('New York', 2), ('Los Angeles', 2), ('Chicago', 2), ('Houston', 2), ('Phoenix', 2),
('Philadelphia', 2), ('San Antonio', 2), ('San Diego', 2), ('Dallas', 2), ('San Jose', 2),
-- Francia (idRegion = 3)
('Parigi', 3), ('Marsiglia', 3), ('Lione', 3), ('Tolosa', 3), ('Nizza', 3),
('Bordeaux', 3), ('Lille', 3), ('Strasburgo', 3), ('Nantes', 3), ('Montpellier', 3),
-- Spagna (idRegion = 4)
('Madrid', 4), ('Barcellona', 4), ('Valencia', 4), ('Siviglia', 4), ('Zaragoza', 4),
('Malaga', 4), ('Murcia', 4), ('Palma di Maiorca', 4), ('Bilbao', 4), ('Alicante', 4),
-- Germania (idRegion = 5)
('Berlino', 5), ('Amburgo', 5), ('Monaco di Baviera', 5), ('Francoforte', 5), ('Colonia', 5),
('Stoccarda', 5), ('Düsseldorf', 5), ('Dresda', 5), ('Leipzig', 5), ('Bremen', 5),
-- Canada (idRegion = 6)
('Toronto', 6), ('Vancouver', 6), ('Montreal', 6), ('Calgary', 6), ('Ottawa', 6),
('Edmonton', 6), ('Winnipeg', 6), ('Quebec City', 6), ('Hamilton', 6), ('Kitchener', 6),
-- Australia (idRegion = 7)
('Sydney', 7), ('Melbourne', 7), ('Brisbane', 7), ('Perth', 7), ('Adelaide', 7),
('Hobart', 7), ('Canberra', 7), ('Darwin', 7), ('Gold Coast', 7), ('Newcastle', 7);

-- Inserimento dei prodotti nella tabella "product"

-- Elettronica
INSERT INTO product (productName, productionCost, listPrice, idCategory) VALUES
('Smartphone', 200.00, 299.00, 1),
('Laptop', 500.00, 599.00, 1),
('Smartwatch', 100.00, 179.00, 1),
('Televisore', 300.00, 450.00, 1),
('Cuffie Bluetooth', 50.00, 89.00, 1),
('Powerbank', 25.00, 34.00, 1),
('Speaker Wireless', 75.00, 139.00, 1),
('Tablet', 150.00, 209.00, 1),
('Telecamera di sicurezza', 120.00, 220.00, 1),
('Fotocamera digitale', 200.00, 399.00, 1);


-- Abbigliamento
INSERT INTO product (productName, productionCost, listPrice, idCategory) VALUES
('Giacca in pelle', 150.00, 199.00, 2),
('T-shirt uomo', 20.00, 29.00, 2),
('Jeans', 40.00, 60.00, 2),
('Scarpe da ginnastica', 60.00, 89.00, 2),
('Camicia elegante', 50.00, 60.00, 2),
('Cappotto in lana', 120.00, 179.00, 2),
('Felpa con cappuccio', 30.00, 55.00, 2),
('Pantaloni cargo', 45.00, 60.00, 2),
('Abito da uomo', 100.00, 159.00, 2),
('Giubbotto invernale', 80.00, 120.00, 2);

-- Cucina
INSERT INTO product (productName, productionCost, listPrice, idCategory) VALUES
('Frullatore', 40.00, 55.00, 3),
('Bollitore elettrico', 30.00, 45.00, 3),
('Robot da cucina', 150.00, 195.00, 3),
('Tostapane', 25.00, 34.00, 3),
('Macchina da caffè', 60.00, 78.00, 3),
('Griglia elettrica', 35.00, 45.00, 3),
('Mixer a mano', 20.00, 30.00, 3),
('Forno a microonde', 100.00, 123.00, 3),
('Caffettiera', 15.00, 24.00, 3),
('Frigorifero', 300.00, 410.00, 3);

-- Arredamento
INSERT INTO product (productName, productionCost, listPrice, idCategory) VALUES
('Divano in pelle', 300.00, 389.00, 4),
('Poltrona reclinabile', 150.00, 187.00, 4),
('Tavolo da pranzo', 250.00, 290.00, 4),
('Sedia ergonomica', 70.00, 90.00, 4),
('Libreria in legno', 200.00, 270.00, 4),
('Scrivania moderna', 180.00, 235.00, 4),
('Comodino in legno', 80.00, 110.00, 4),
('Armadio a 2 ante', 220.00, 300.00, 4),
('Luce da terra', 60.00, 88.00, 4),
('Lampada da tavolo', 40.00, 54.00, 4);

-- Giardinaggio
INSERT INTO product (productName, productionCost, listPrice, idCategory) VALUES
('Tosaerba elettrico', 220.00, 240.00, 5),
('Potatore telescopico', 150.00, 200.00, 5),
('Raspa da giardino', 80.00, 110.00, 5),
('Trivella da giardino', 250.00, 290.00, 5),
('Spruzzatore', 30.00, 49.00, 5),
('Motosega', 200.00, 249.00, 5),
('Zappa da giardino', 40.00, 57.00, 5),
('Cesoia', 60.00, 72.00, 5),
('Carrello da giardino', 90.00, 119.00, 5),
('Secchio da giardino', 20.00, 29.00, 5);



-- Popolamento della tabella sales

-- Italia (idCity 1-10)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(1, 1, 'Via Roma 1, Milano', '2019-01-15'),
(2, 2, 'Corso Garibaldi 5, Roma', '2019-02-01'),
(3, 3, 'Viale della Liberazione 10, Napoli', '2019-03-10'),
(4, 4, 'Piazza del Duomo 15, Firenze', '2019-04-20'),
(5, 5, 'Via Dante Alighieri 23, Torino', '2019-05-05'),
(6, 6, 'Lungomare Caracciolo 100, Genova', '2019-06-10'),
(7, 7, 'Via delle Milizie 35, Bologna', '2019-07-15'),
(8, 8, 'Piazzale Loreto 25, Milano', '2019-08-01'),
(9, 9, 'Via Verdi 50, Venezia', '2019-09-05'),
(10, 10, 'Corso Umberto 1, Palermo', '2019-10-10');

-- America (idCity 11-20)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(11, 11, '1234 Elm Street, New York, NY', '2019-01-20'),
(12, 12, '5678 Maple Ave, Los Angeles, CA', '2019-02-10'),
(13, 13, '9102 Oak Drive, Chicago, IL', '2019-03-05'),
(14, 14, '1122 Pine Street, Houston, TX', '2019-04-15'),
(15, 15, '3145 Birch Road, Miami, FL', '2019-05-10'),
(16, 16, '4210 Cedar Lane, Dallas, TX', '2019-06-20'),
(17, 17, '7890 Birchwood Ave, San Francisco, CA', '2019-07-01'),
(18, 18, '3456 Oakwood Dr, Boston, MA', '2019-08-15'),
(19, 19, '6572 Willow Rd, Atlanta, GA', '2019-09-10'),
(20, 20, '2345 Redwood Blvd, Phoenix, AZ', '2019-10-20');

-- Francia (idCity 21-30)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(21, 21, '10 Rue de Rivoli, Paris', '2019-01-25'),
(22, 1, '22 Boulevard Saint-Germain, Paris', '2019-02-15'),
(23, 2, '14 Avenue des Champs-Élysées, Paris', '2019-03-01'),
(24, 3, '25 Rue de la Paix, Paris', '2019-04-10'),
(25, 4, '3 Quai de la Tournelle, Paris', '2019-05-01'),
(26, 5, '56 Rue de la Croix-Rouge, Lyon', '2019-06-05'),
(27, 6, '78 Rue du Faubourg Saint-Antoine, Paris', '2019-07-10'),
(28, 7, '99 Avenue Montaigne, Paris', '2019-08-20'),
(29, 8, '67 Rue Saint-Denis, Paris', '2019-09-05'),
(30, 9, '32 Rue de Charonne, Paris', '2019-10-01');

-- Spagna (idCity 31-40)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(31, 10, 'Calle Gran Vía 10, Madrid', '2019-01-30'),
(32, 11, 'Avenida Diagonal 25, Barcelona', '2019-02-20'),
(33, 12, 'Carrer de Pau Claris 12, Barcelona', '2019-03-15'),
(34, 13, 'Calle de Serrano 34, Madrid', '2019-04-05'),
(35, 14, 'Carrer de Balmes 50, Barcelona', '2019-05-15'),
(36, 15, 'Avenida de la Paz 45, Valencia', '2019-06-25'),
(37, 16, 'Calle de Toledo 11, Madrid', '2019-07-30'),
(38, 17, 'Plaza Mayor 2, Madrid', '2019-08-10'),
(39, 18, 'Carrer de Pau Claris 22, Barcelona', '2019-09-25'),
(40, 19, 'Calle de las Huertas 15, Madrid', '2019-10-05');

-- Germania (idCity 41-50)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(41, 20, 'Münchener Str. 20, Berlin', '2019-02-05'),
(42, 21, 'Kaiserstraße 33, Frankfurt', '2019-03-25'),
(43, 1, 'Hauptstraße 5, Hamburg', '2019-04-10'),
(44, 2, 'Bismarckstraße 8, Cologne', '2019-05-01'),
(45, 3, 'Friedrichstr. 22, Berlin', '2019-06-15'),
(46, 4, 'Am Gendarmenmarkt 14, Berlin', '2019-07-05'),
(47, 5, 'Schönhauser Allee 45, Berlin', '2019-08-15'),
(48, 6, 'Berliner Str. 19, Frankfurt', '2019-09-01'),
(49, 7, 'Münsterstraße 13, Hamburg', '2019-09-20'),
(50, 8, 'Siegfriedstraße 17, Munich', '2019-10-25');

-- Canada (idCity 51-60)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(51, 9, '100 King Street, Toronto', '2019-02-10'),
(52, 10, '200 Bay Street, Toronto', '2019-03-05'),
(53, 11, '123 Main Street, Montreal', '2019-04-20'),
(54, 12, '25 Queen Street, Vancouver', '2019-05-25'),
(55, 13, '77 Yonge Street, Toronto', '2019-06-10'),
(56, 14, '15 King Street, Ottawa', '2019-07-15'),
(57, 15, '150 Front Street, Toronto', '2019-08-05'),
(58, 16, '75 Albert Street, Montreal', '2019-09-05'),
(59, 17, '30 Dundas Street, Hamilton', '2019-09-20'),
(60, 18, '8 Wellington Street, Ottawa', '2019-10-10');

-- Australia (idCity 61-70)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(61, 19, 'George Street 10, Sydney', '2019-01-18'),
(62, 20, 'Bourke Street 22, Melbourne', '2019-02-25'),
(63, 21, 'Elizabeth Street 45, Sydney', '2019-03-10'),
(64, 1, 'Collins Street 15, Melbourne', '2019-04-01'),
(65, 9, 'King Street 5, Brisbane', '2019-05-01'),
(66, 3, 'Market Street 18, Perth', '2019-06-01'),
(67, 4, 'Flinders Street 20, Adelaide', '2019-07-01'),
(68, 5, 'Clarendon Street 35, Melbourne', '2019-08-10'),
(69, 20, 'Smith Street 10, Sydney', '2019-09-01'),
(70, 7, 'Wellington Street 8, Sydney', '2019-10-15');

-- Popolamento della tabella sales con 15 nuovi record

-- Italia (idCity 1-10)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(1, 7, 'Via Roma 123, Milano', '2020-01-12'),
(3, 11, 'Viale Giuseppe Mazzini 8, Napoli', '2020-03-22'),
(9, 15, 'Piazza San Marco 5, Venezia', '2020-05-05'),
(6, 3, 'Via di San Giovanni 10, Genova', '2020-06-15'),
(2, 18, 'Corso Garibaldi 55, Roma', '2020-08-10');

-- America (idCity 11-20)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(16, 20, '4210 Cedar Lane, Dallas, TX', '2020-02-15'),
(13, 9, '9102 Oak Drive, Chicago, IL', '2020-04-05'),
(19, 13, '6572 Willow Rd, Atlanta, GA', '2020-07-07'),
(18, 8, '3456 Oakwood Dr, Boston, MA', '2020-09-15'),
(14, 21, '1122 Pine Street, Houston, TX', '2020-11-01');

-- Francia (idCity 21-30)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(24, 5, '25 Rue de la Paix, Paris', '2020-02-22'),
(30, 19, '32 Rue de Charonne, Paris', '2020-04-10');

-- Spagna (idCity 31-40)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(35, 2, 'Avenida de la Paz 45, Valencia', '2020-03-18'),
(37, 10, 'Calle de Toledo 11, Madrid', '2020-05-25');

-- Germania (idCity 41-50)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(46, 6, 'Am Gendarmenmarkt 14, Berlin', '2020-06-01'),
(50, 4, 'Siegfriedstraße 17, Munich', '2020-08-20');

-- Popolamento della tabella sales con altri record randomici

-- Italia (idCity 1-10)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(1, 4, 'Via Dante Alighieri 75, Milano', '2020-01-05'),
(3, 17, 'Piazza del Plebiscito 4, Napoli', '2020-02-12'),
(6, 19, 'Lungomare Caracciolo 88, Genova', '2020-04-01'),
(2, 11, 'Corso Garibaldi 101, Roma', '2020-06-25'),
(10, 9, 'Via Verdi 60, Palermo', '2020-09-13');

-- America (idCity 11-20)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(11, 5, '1234 Elm Street, New York, NY', '2020-02-05'),
(12, 20, '5678 Maple Ave, Los Angeles, CA', '2020-03-18'),
(14, 3, '1122 Pine Street, Houston, TX', '2020-06-10'),
(16, 8, '4210 Cedar Lane, Dallas, TX', '2020-08-07'),
(19, 14, '6572 Willow Rd, Atlanta, GA', '2020-10-15');

-- Francia (idCity 21-30)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(21, 15, '10 Rue de Rivoli, Paris', '2020-01-20'),
(23, 6, '14 Avenue des Champs-Élysées, Paris', '2020-03-25'),
(25, 2, '56 Rue de la Croix-Rouge, Lyon', '2020-06-05'),
(29, 18, '67 Rue Saint-Denis, Paris', '2020-08-12'),
(30, 21, '32 Rue de Charonne, Paris', '2020-10-22');

-- Spagna (idCity 31-40)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(31, 13, 'Calle Gran Vía 100, Madrid', '2020-01-18'),
(34, 10, 'Calle de Serrano 22, Madrid', '2020-04-02'),
(38, 1, 'Plaza Mayor 7, Madrid', '2020-06-15'),
(39, 7, 'Carrer de Pau Claris 18, Barcelona', '2020-08-25'),
(40, 5, 'Calle de las Huertas 5, Madrid', '2020-10-02');

-- Germania (idCity 41-50)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(41, 12, 'Münchener Str. 10, Berlin', '2020-01-25'),
(43, 4, 'Hauptstraße 16, Hamburg', '2020-02-22'),
(45, 9, 'Friedrichstr. 40, Berlin', '2020-04-13'),
(47, 16, 'Schönhauser Allee 55, Berlin', '2020-06-28'),
(50, 8, 'Siegfriedstraße 8, Munich', '2020-09-10');

-- Canada (idCity 51-60)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(51, 14, '100 King Street, Toronto', '2020-01-15'),
(52, 17, '200 Bay Street, Toronto', '2020-02-07'),
(53, 10, '123 Main Street, Montreal', '2020-03-05'),
(55, 18, '77 Yonge Street, Toronto', '2020-05-22'),
(59, 13, '30 Dundas Street, Hamilton', '2020-08-19');

-- Australia (idCity 61-70)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(61, 3, 'George Street 7, Sydney', '2020-01-29'),
(63, 2, 'Elizabeth Street 44, Sydney', '2020-02-10'),
(65, 20, 'King Street 3, Brisbane', '2020-04-02'),
(67, 6, 'Flinders Street 23, Adelaide', '2020-05-15'),
(70, 9, 'Wellington Street 25, Sydney', '2020-07-10');

-- Popolamento della tabella sales con 29 nuovi record randomici

-- Italia (idCity 1-10)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(1, 5, 'Via Dante Alighieri 32, Milano', '2020-03-15'),
(2, 9, 'Corso Garibaldi 50, Roma', '2020-04-10'),
(4, 12, 'Piazza del Duomo 45, Firenze', '2020-05-05'),
(6, 3, 'Lungomare Caracciolo 115, Genova', '2020-06-25'),
(9, 16, 'Via delle Grazie 22, Venezia', '2020-08-10');

-- America (idCity 11-20)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(11, 15, '1234 Elm Street, New York, NY', '2020-01-18'),
(13, 18, '9102 Oak Drive, Chicago, IL', '2020-02-12'),
(14, 20, '1122 Pine Street, Houston, TX', '2020-03-20'),
(16, 14, '4210 Cedar Lane, Dallas, TX', '2020-04-22'),
(19, 13, '6572 Willow Rd, Atlanta, GA', '2020-06-08');

-- Francia (idCity 21-30)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(21, 8, '10 Rue de Rivoli, Paris', '2020-02-03'),
(22, 4, '22 Boulevard Saint-Germain, Paris', '2020-03-16'),
(24, 11, '25 Rue de la Paix, Paris', '2020-05-18'),
(26, 19, '56 Rue de la Croix-Rouge, Lyon', '2020-06-29'),
(28, 6, '99 Avenue Montaigne, Paris', '2020-08-13');

-- Spagna (idCity 31-40)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(31, 17, 'Calle Gran Vía 30, Madrid', '2020-01-23'),
(33, 7, 'Carrer de Pau Claris 14, Barcelona', '2020-02-28'),
(34, 2, 'Calle de Serrano 50, Madrid', '2020-04-18'),
(36, 10, 'Avenida de la Paz 34, Valencia', '2020-05-08'),
(39, 5, 'Plaza Mayor 10, Madrid', '2020-07-12');

-- Germania (idCity 41-50)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(42, 1, 'Kaiserstraße 33, Frankfurt', '2020-03-02'),
(44, 18, 'Bismarckstraße 45, Cologne', '2020-04-10'),
(46, 14, 'Am Gendarmenmarkt 12, Berlin', '2020-05-22'),
(48, 11, 'Schönhauser Allee 45, Berlin', '2020-07-04'),
(50, 16, 'Siegfriedstraße 20, Munich', '2020-08-15');

-- Canada (idCity 51-60)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(52, 7, '200 Bay Street, Toronto', '2020-01-28'),
(53, 5, '123 Main Street, Montreal', '2020-02-18'),
(54, 13, '25 Queen Street, Vancouver', '2020-04-12'),
(56, 20, '15 King Street, Ottawa', '2020-06-03'),
(59, 9, '77 Yonge Street, Toronto', '2020-07-25');

-- Australia (idCity 61-70)
INSERT INTO sales (idCity, idClient, address, orderDate) VALUES
(61, 4, 'George Street 18, Sydney', '2020-01-30'),
(64, 12, 'Collins Street 10, Melbourne', '2020-02-25'),
(65, 3, 'King Street 12, Brisbane', '2020-04-15'),
(67, 15, 'Flinders Street 29, Adelaide', '2020-05-06'),
(69, 8, 'Smith Street 22, Sydney', '2020-07-17');

-- Popolamento della tabella salesdetails con 29 nuovi record randomici

INSERT INTO salesdetails (salesNumber, salesLineNumber, orderQuantity, idProduct) VALUES
(1, 1, 5, 7),
(1, 2, 3, 2),
(2, 1, 4, 10),
(2, 2, 7, 4),
(3, 1, 9, 5),
(3, 2, 2, 6),
(4, 1, 10, 8),
(4, 2, 3, 4),
(4, 3, 1, 11),
(5, 1, 6, 3),
(6, 1, 8, 9),
(6, 2, 2, 5),
(7, 1, 1, 14),
(7, 2, 4, 12),
(7, 3, 3, 11),
(8, 1, 5, 18),
(9, 1, 9, 17),
(9, 2, 6, 19),
(10, 1, 7, 16),
(11, 1, 8, 2),
(12, 1, 10, 8),
(12, 2, 5, 3),
(13, 1, 3, 13),
(14, 1, 9, 20),
(14, 2, 7, 21),
(15, 1, 6, 22),
(15, 2, 1, 25),
(16, 1, 2, 6),
(17, 1, 4, 30),
(18, 1, 8, 35),
(19, 1, 3, 25),
(19, 2, 7, 20),
(20, 1, 1, 18),
(21, 1, 5, 14),
(22, 1, 4, 9),
(22, 2, 2, 17),
(23, 1, 9, 21),
(24, 1, 2, 16),
(25, 1, 6, 5),
(26, 1, 7, 7),
(27, 1, 4, 8),
(28, 1, 10, 5),
(29, 1, 1, 11),
(30, 1, 4, 15),
(30, 2, 3, 23),
(30, 3, 2, 42),
(30, 4, 5, 9),
(30, 5, 1, 6),
(30, 6, 4, 8),
(31, 1, 3, 5),
(31, 2, 4, 11),
(31, 3, 2, 34),
(31, 4, 5, 21),
(31, 5, 1, 17),
(31, 6, 3, 7),
(32, 1, 4, 27),
(32, 2, 3, 12),
(32, 3, 2, 45),
(32, 4, 5, 3),
(32, 5, 1, 29),
(32, 6, 4, 19),
(33, 1, 2, 39),
(33, 2, 5, 33),
(33, 3, 4, 28),
(33, 4, 3, 30),
(33, 5, 2, 14),
(33, 6, 1, 11),
(34, 1, 4, 13),
(34, 2, 3, 25),
(34, 3, 1, 18),
(34, 4, 2, 9),
(34, 5, 5, 17),
(34, 6, 4, 16),
(35, 1, 5, 29),
(35, 2, 3, 26),
(35, 3, 4, 41),
(35, 4, 1, 23),
(35, 5, 2, 48),
(35, 6, 5, 19),
(36, 1, 2, 40),
(36, 2, 4, 7),
(36, 3, 5, 22),
(36, 4, 3, 35),
(36, 5, 1, 28),
(36, 6, 2, 46),
(37, 1, 3, 12),
(37, 2, 1, 39),
(37, 3, 4, 9),
(37, 4, 5, 21),
(37, 5, 2, 33),
(37, 6, 3, 17),
(38, 1, 5, 24),
(38, 2, 2, 16),
(38, 3, 3, 7),
(38, 4, 4, 31),
(38, 5, 1, 27),
(38, 6, 5, 10),
(39, 1, 4, 30),
(39, 2, 3, 23),
(39, 3, 5, 34),
(39, 4, 2, 13),
(39, 5, 1, 41),
(39, 6, 4, 6),
(40, 1, 4, 8),
(40, 2, 2, 45),
(40, 3, 3, 16),
(40, 4, 5, 32),
(40, 5, 1, 22),
(40, 6, 4, 19),
(41, 1, 4, 7),
(41, 2, 3, 23),
(41, 3, 5, 34),
(42, 1, 2, 12),
(42, 2, 3, 18),
(42, 3, 5, 26),
(42, 4, 4, 35),
(43, 1, 3, 11),
(43, 2, 4, 22),
(43, 3, 5, 33),
(43, 4, 2, 45),
(43, 5, 1, 13),
(43, 6, 3, 9),
(43, 7, 4, 19),
(44, 1, 3, 5),
(44, 2, 4, 9),
(44, 3, 2, 14),
(44, 4, 1, 21),
(44, 5, 5, 33),
(44, 6, 4, 12),
(44, 7, 3, 18),
(44, 8, 2, 25),
(44, 9, 5, 27),
(44, 10, 3, 41),
(45, 1, 5, 32),
(45, 2, 2, 45),
(45, 3, 3, 19),
(45, 4, 1, 13),
(46, 1, 4, 27),
(46, 2, 2, 13),
(46, 3, 5, 35),
(46, 4, 3, 14),
(46, 5, 4, 30),
(46, 6, 1, 38),
(46, 7, 3, 24),
(47, 1, 4, 21),
(47, 2, 2, 44),
(47, 3, 5, 17),
(48, 1, 3, 12),
(48, 2, 4, 29),
(48, 3, 2, 25),
(48, 4, 1, 40),
(49, 1, 5, 8),
(49, 2, 4, 12),
(49, 3, 3, 15),
(49, 4, 2, 18),
(49, 5, 1, 19),
(49, 6, 4, 9),
(49, 7, 3, 22),
(50, 1, 4, 11),
(50, 2, 3, 33),
(50, 3, 5, 18),
(50, 4, 2, 19),
(50, 5, 4, 30),
(50, 6, 1, 7),
(50, 7, 3, 28),
(50, 8, 2, 24),
(50, 9, 5, 36),
(50, 10, 4, 8),
(60, 1, 4, 22),
(61, 1, 3, 11),
(61, 2, 5, 17),
(62, 1, 2, 29),
(63, 1, 4, 19),
(63, 2, 1, 35),
(64, 1, 3, 9),
(65, 1, 4, 5),
(65, 2, 2, 28),
(66, 1, 5, 30),
(67, 1, 2, 41),
(67, 2, 3, 8),
(68, 1, 3, 23),
(69, 1, 1, 37),
(69, 2, 4, 12),
(70, 1, 4, 16),
(71, 1, 5, 14),
(71, 2, 2, 27),
(72, 1, 3, 33),
(73, 1, 5, 9),
(73, 2, 2, 34),
(74, 1, 4, 10),
(75, 1, 3, 16),
(75, 2, 5, 21),
(76, 1, 2, 20),
(77, 1, 1, 25),
(77, 2, 4, 30),
(78, 1, 3, 42),
(79, 1, 5, 8),
(79, 2, 4, 27),
(80, 1, 5, 7),
(80, 2, 4, 12),
(80, 3, 3, 29),
(80, 4, 1, 41),
(80, 5, 2, 33),
(80, 6, 3, 14),
(80, 7, 4, 10),
(80, 8, 5, 17),
(80, 9, 2, 19),
(81, 1, 3, 25),
(81, 2, 5, 8),
(81, 3, 1, 41),
(81, 4, 4, 12),
(81, 5, 2, 7),
(82, 1, 4, 16),
(83, 1, 2, 10),
(83, 2, 3, 14),
(83, 3, 4, 18),
(83, 4, 5, 25),
(83, 5, 1, 22),
(83, 6, 4, 6),
(83, 7, 3, 7),
(83, 8, 2, 30),
(83, 9, 5, 19),
(84, 1, 3, 20),
(84, 2, 5, 18),
(84, 3, 2, 4),
(84, 4, 4, 11),
(84, 5, 1, 15),
(85, 1, 5, 23),
(86, 1, 2, 21),
(86, 2, 3, 12),
(86, 3, 5, 6),
(86, 4, 4, 17),
(86, 5, 1, 13),
(86, 6, 3, 16),
(86, 7, 4, 5),
(86, 8, 2, 8),
(86, 9, 5, 19),
(87, 1, 4, 11),
(87, 2, 1, 33),
(87, 3, 5, 10),
(87, 4, 3, 29),
(87, 5, 2, 15),
(88, 1, 2, 26),
(89, 1, 5, 3),
(89, 2, 2, 14),
(89, 3, 4, 24),
(89, 4, 3, 7),
(89, 5, 1, 16),
(89, 6, 5, 9),
(89, 7, 2, 33),
(89, 8, 4, 17),
(89, 9, 3, 22),
(90, 1, 2, 20),
(90, 2, 5, 8),
(90, 3, 3, 13),
(90, 4, 1, 28),
(90, 5, 4, 6),
(91, 1, 4, 27),
(92, 1, 3, 32),
(92, 2, 5, 15),
(92, 3, 4, 21),
(92, 4, 1, 18),
(92, 5, 2, 6),
(92, 6, 4, 5),
(92, 7, 2, 12),
(92, 8, 3, 33),
(92, 9, 1, 19),
(93, 1, 4, 7),
(93, 2, 3, 11),
(93, 3, 5, 16),
(93, 4, 1, 30),
(93, 5, 2, 27),
(94, 1, 3, 8),
(95, 1, 3, 13),
(95, 2, 5, 24),
(95, 3, 2, 7),
(95, 4, 4, 19),
(95, 5, 1, 17),
(95, 6, 5, 29),
(95, 7, 3, 15),
(95, 8, 4, 20),
(95, 9, 1, 22),
(96, 1, 4, 9),
(96, 2, 3, 11),
(96, 3, 2, 28),
(96, 4, 5, 6),
(96, 5, 1, 35),
(97, 1, 2, 19),
(98, 1, 3, 6),
(98, 2, 5, 8),
(98, 3, 4, 18),
(98, 4, 1, 22),
(98, 5, 2, 12),
(98, 6, 3, 25),
(98, 7, 4, 30),
(98, 8, 5, 16),
(98, 9, 1, 24),
(99, 1, 2, 31),
(99, 2, 4, 29),
(99, 3, 3, 21),
(99, 4, 1, 14),
(99, 5, 5, 7),
(100, 1, 4, 13),
(101, 1, 3, 7),
(101, 2, 5, 8),
(101, 3, 4, 14),
(101, 4, 1, 6),
(101, 5, 2, 20),
(101, 6, 5, 27),
(101, 7, 3, 18),
(101, 8, 4, 19),
(101, 9, 1, 9),
(102, 1, 4, 17),
(102, 2, 3, 11),
(102, 3, 2, 12),
(102, 4, 1, 24),
(102, 5, 5, 22),
(103, 1, 3, 28),
(104, 1, 2, 19),
(104, 2, 5, 7),
(104, 3, 4, 6),
(104, 4, 3, 18),
(104, 5, 1, 20),
(104, 6, 5, 16),
(104, 7, 2, 11),
(104, 8, 4, 29),
(104, 9, 1, 10),
(105, 1, 3, 26),
(105, 2, 4, 21),
(105, 3, 1, 12),
(105, 4, 5, 28),
(105, 5, 2, 17),
(106, 1, 4, 5),
(107, 1, 3, 16),
(107, 2, 2, 7),
(107, 3, 4, 12),
(107, 4, 1, 8),
(107, 5, 5, 9),
(107, 6, 3, 18),
(107, 7, 4, 20),
(107, 8, 5, 14),
(107, 9, 2, 22),
(108, 1, 1, 31),
(108, 2, 3, 26),
(108, 3, 4, 11),
(108, 4, 5, 14),
(108, 5, 2, 17),
(109, 1, 4, 21),
(110, 1, 2, 25),
(110, 2, 4, 9),
(110, 3, 3, 28),
(110, 4, 5, 10),
(110, 5, 1, 13),
(110, 6, 5, 12),
(110, 7, 3, 7),
(110, 8, 4, 16),
(110, 9, 2, 18),
(111, 1, 3, 4),
(111, 2, 2, 15),
(111, 3, 5, 21),
(111, 4, 1, 27),
(111, 5, 4, 9),
(112, 1, 4, 19),
(113, 1, 2, 14),
(113, 2, 4, 11),
(113, 3, 5, 17),
(113, 4, 3, 22),
(113, 5, 1, 25),
(113, 6, 5, 9),
(113, 7, 2, 12),
(113, 8, 4, 18),
(113, 9, 1, 30),
(114, 1, 3, 8),
(114, 2, 5, 16),
(114, 3, 2, 14),
(114, 4, 4, 13),
(114, 5, 1, 23),
(115, 1, 2, 19),
(116, 1, 3, 21),
(116, 2, 2, 27),
(116, 3, 4, 12),
(116, 4, 5, 18),
(116, 5, 1, 30),
(116, 6, 3, 22),
(116, 7, 4, 17),
(116, 8, 2, 14),
(116, 9, 5, 25),
(117, 1, 1, 10),
(117, 2, 4, 21),
(117, 3, 3, 19),
(117, 4, 5, 7),
(117, 5, 2, 30),
(118, 1, 4, 16),
(119, 1, 5, 11),
(119, 2, 2, 23),
(119, 3, 3, 8),
(119, 4, 4, 18),
(119, 5, 1, 14),
(119, 6, 5, 25),
(119, 7, 2, 10),
(119, 8, 4, 12),
(120, 1, 3, 14),
(120, 2, 2, 7),
(120, 3, 4, 16),
(120, 4, 1, 22),
(120, 5, 5, 19),
(120, 6, 3, 9),
(121, 1, 2, 18),
(121, 2, 4, 12),
(121, 3, 1, 8),
(122, 1, 3, 25),
(122, 2, 4, 11),
(122, 3, 2, 20),
(122, 4, 5, 10),
(122, 5, 1, 29),
(123, 1, 5, 6),
(123, 2, 2, 17),
(123, 3, 4, 14),
(123, 4, 3, 19),
(123, 5, 1, 9),
(123, 6, 4, 18),
(123, 7, 2, 13),
(124, 1, 3, 22),
(124, 2, 5, 11),
(124, 3, 2, 27),
(124, 4, 4, 15),
(124, 5, 1, 16),
(124, 6, 5, 12),
(124, 7, 3, 20),
(124, 8, 2, 10),
(125, 1, 4, 23),
(125, 2, 2, 14),
(125, 3, 5, 6),
(126, 1, 1, 8),
(126, 2, 3, 10),
(126, 3, 5, 16),
(126, 4, 2, 22),
(127, 1, 2, 12),
(128, 1, 4, 7),
(128, 2, 3, 25),
(128, 3, 2, 9),
(128, 4, 5, 14),
(128, 5, 1, 19),
(128, 6, 5, 11),
(128, 7, 3, 17),
(128, 8, 2, 22),
(128, 9, 4, 16),
(129, 1, 3, 8),
(129, 2, 4, 18),
(129, 3, 1, 23),
(129, 4, 5, 27),
(129, 5, 2, 14),
(130, 1, 3, 17),
(130, 2, 4, 16),
(130, 3, 5, 10),
(130, 4, 2, 18),
(130, 5, 1, 12),
(130, 6, 3, 19),
(131, 1, 2, 23),
(131, 2, 4, 15),
(131, 3, 1, 9),
(131, 4, 5, 8),
(131, 5, 3, 17),
(131, 6, 2, 6),
(131, 7, 4, 22),
(132, 1, 4, 19),
(132, 2, 2, 12),
(132, 3, 5, 18),
(132, 4, 1, 14),
(132, 5, 3, 27),
(132, 6, 4, 23),
(132, 7, 2, 9),
(132, 8, 5, 7),
(133, 1, 3, 26),
(133, 2, 2, 7),
(133, 3, 5, 16),
(133, 4, 4, 17),
(133, 5, 1, 14),
(133, 6, 3, 25),
(134, 1, 2, 21),
(134, 2, 4, 28),
(134, 3, 3, 9),
(134, 4, 1, 12),
(135, 1, 4, 10),
(136, 1, 3, 18),
(136, 2, 2, 11),
(136, 3, 5, 14),
(136, 4, 1, 12),
(136, 5, 4, 20),
(136, 6, 5, 6),
(136, 7, 3, 8),
(136, 8, 2, 17),
(136, 9, 4, 22),
(137, 1, 2, 19),
(137, 2, 4, 13),
(137, 3, 3, 7),
(137, 4, 5, 18),
(137, 5, 1, 26),
(138, 1, 3, 15),
(138, 2, 2, 20),
(138, 3, 5, 19),
(138, 4, 1, 8),
(138, 5, 4, 17),
(138, 6, 5, 22),
(138, 7, 3, 25),
(139, 1, 4, 21),
(139, 2, 3, 12),
(139, 3, 2, 9),
(139, 4, 5, 18),
(139, 5, 1, 7),
(140, 1, 4, 14),
(141, 1, 2, 23),
(141, 2, 5, 17),
(141, 3, 1, 8),
(141, 4, 4, 11),
(141, 5, 3, 16),
(141, 6, 5, 19),
(142, 1, 3, 10),
(142, 2, 2, 25),
(142, 3, 4, 19),
(142, 4, 1, 22),
(142, 5, 3, 8),
(142, 6, 5, 9),
(142, 7, 4, 7),
(142, 8, 2, 26),
(143, 1, 5, 21),
(143, 2, 2, 18),
(143, 3, 3, 9),
(143, 4, 1, 12),
(143, 5, 4, 14),
(143, 6, 5, 17),
(143, 7, 2, 22),
(144, 1, 5, 8),
(144, 2, 3, 17),
(144, 3, 2, 15),
(144, 4, 1, 22),
(144, 5, 4, 9),
(144, 6, 3, 11),
(144, 7, 5, 6),
(144, 8, 2, 19),
(144, 9, 1, 14),
(145, 1, 3, 24),
(145, 2, 5, 16),
(145, 3, 4, 10),
(145, 4, 2, 18),
(146, 1, 1, 19),
(146, 2, 2, 14),
(146, 3, 5, 8),
(146, 4, 4, 22),
(146, 5, 3, 12),
(146, 6, 1, 27),
(146, 7, 4, 6),
(147, 1, 4, 16),
(147, 2, 2, 11),
(147, 3, 3, 9),
(148, 1, 4, 5),
(148, 2, 3, 8),
(148, 3, 5, 10),
(148, 4, 2, 13),
(148, 5, 1, 15),
(148, 6, 4, 22),
(149, 1, 3, 20),
(150, 1, 2, 18),
(150, 2, 4, 9),
(150, 3, 3, 22),
(150, 4, 1, 12),
(150, 5, 5, 8),
(150, 6, 2, 11),
(150, 7, 4, 25),
(150, 8, 3, 16),
(151, 1, 3, 15),
(151, 2, 1, 12),
(151, 3, 5, 8),
(151, 4, 4, 18),
(151, 5, 3, 10),
(151, 6, 2, 14),
(152, 1, 3, 17),
(152, 2, 5, 19),
(152, 3, 2, 25),
(152, 4, 1, 14),
(152, 5, 4, 12),
(152, 6, 3, 16),
(152, 7, 5, 13),
(152, 8, 2, 21),
(152, 9, 4, 7),
(153, 1, 2, 23),
(153, 2, 4, 15),
(153, 3, 1, 8),
(154, 1, 4, 17),
(154, 2, 3, 21),
(154, 3, 2, 14),
(154, 4, 5, 19),
(154, 5, 1, 9),
(155, 1, 4, 10),
(155, 2, 3, 20),
(156, 1, 3, 5),
(156, 2, 4, 9),
(156, 3, 2, 18),
(156, 4, 1, 22);

INSERT INTO salesdetails (salesNumber, salesLineNumber, orderQuantity, idProduct) VALUES
(51, 1, 2, 23),
(51, 2, 4, 15),
(51, 3, 1, 9),
(51, 4, 5, 8),
(51, 5, 3, 40),
(51, 6, 2, 6),
(51, 7, 4, 22),
(52, 1, 4, 9),
(52, 2, 2, 12),
(52, 3, 5, 18),
(52, 4, 1, 14),
(52, 5, 3, 27),
(52, 6, 4, 23),
(52, 7, 2, 9),
(52, 8, 5, 7),
(53, 1, 3, 26),
(53, 2, 2, 7),
(54, 2, 4, 28),
(54, 3, 3, 9),
(54, 4, 1, 10),
(55, 1, 4, 10),
(56, 1, 3, 18),
(57, 1, 2, 19),
(57, 2, 4, 13),
(57, 3, 3, 7),
(57, 4, 5, 18),
(57, 5, 1, 26),
(58, 1, 3, 15),
(58, 2, 2, 20),
(59, 3, 2, 9),
(59, 4, 5, 17),
(59, 5, 1, 7);
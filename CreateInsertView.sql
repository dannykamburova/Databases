SET SCHEMA FN24_0MI0700131;

CREATE TABLE FLATDEALS (
    dealno CHAR(8) NOT NULL PRIMARY KEY,
    date DATE,
    flatno CHAR(10) REFERENCES FLATS(flatno),
    agencypersonalno CHAR(8) NOT NULL REFERENCES AGENCY(personalno),
    clientsno CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum)
);

CREATE TABLE SALES(
    dealno CHAR(8) NOT NULL PRIMARY KEY,
    date DATE,
    flatsnum CHAR(10) REFERENCES FLATS(flatno),
    agencypersonalno CHAR(8) NOT NULL REFERENCES AGENCY(personalno),
    clientsno CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum)
);

CREATE TABLE HOUSESDEALS (
    dealno CHAR(8) NOT NULL PRIMARY KEY,
    date DATE,
    houseno CHAR(10) REFERENCES HOUSES(houseno),
    agencypersonalno CHAR(8) NOT NULL REFERENCES AGENCY(personalno),
    clientsno CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum)
);

CREATE TABLE PARCELDEAL(
    dealno CHAR(8) NOT NULL PRIMARY KEY,
    date DATE,
    parcelnum CHAR(10) REFERENCES PARCELS(parcelno),
    agencypersonalno CHAR(8) NOT NULL REFERENCES AGENCY(personalno),
    clientsno CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum)
);


CREATE TABLE AGENCY(
    personalno CHAR(8) NOT NULL PRIMARY KEY,
    agencyname VARCHAR(50) NOT NULL,
    website VARCHAR(30),
    phonenum CHAR(10) NOT NULL
);

CREATE TABLE CLIENTS(
    clientnum CHAR(10) NOT NULL PRIMARY KEY,
    clientname VARCHAR(60) NOT NULL,
    budget DECIMAL(10,2) NOT NULL CHECK (budget >= 0),
    email VARCHAR(100),
    clientphone CHAR(10) NOT NULL,
    CHECK (email LIKE '%_@_%._%')
);


CREATE TABLE OFFICE(
    officename VARCHAR(30) NOT NULL PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(15) NOT NULL,
    agencypersonalno CHAR(8) NOT NULL REFERENCES AGENCY(personalno)
);

CREATE TABLE FLATS(
    flatno CHAR(10) NOT NULL PRIMARY KEY,
    description VARCHAR(150) NOT NULL,
    city VARCHAR(15),
    neighbourhood VARCHAR(20),
    rooms INTEGER CHECK (rooms IN (1,2,3,4,5)),
    floors INTEGER CHECK (floors IN (1, 2, 3, 4, 5, 6, 7, 8, 9,10)),
    nameoffice VARCHAR(30) NOT NULL REFERENCES OFFICE(officename)
);

CREATE TABLE HOUSES (
    houseno CHAR(10) NOT NULL PRIMARY KEY,
    description VARCHAR(150) NOT NULL,
    city VARCHAR(15),
    neighbourhood VARCHAR(20),
    rooms INTEGER CHECK (rooms IN (1,2,3,4,5,6,7,8,9,10)),
    floors INTEGER CHECK (floors IN (1, 2, 3, 4, 5)),
    nameoffice VARCHAR(30) NOT NULL REFERENCES OFFICE(officename)
);

 CREATE TABLE PARCELS(
    parcelno CHAR(10) NOT NULL PRIMARY KEY,
    description VARCHAR(150) NOT NULL,
    city VARCHAR(15),
    neighbourhood VARCHAR(20),
    regulation INT CHECK (regulation IN (0,1)),
    nameofoffice VARCHAR(30) NOT NULL REFERENCES OFFICE(officename)
);


CREATE TABLE TOURFLATS(
    date DATE,
    hour TIME CHECK (hour >= '00:00:00' AND hour <= '23:59:59'),
    flatsno CHAR(10) NOT NULL REFERENCES FLATS(flatno),
    clientsnum CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum),
    PRIMARY KEY(flatsno, clientsnum)
);

CREATE TABLE TOURPARCEL(
    date DATE,
    hour TIME CHECK (hour >= '00:00:00' AND hour <= '23:59:59'),
    parcelno CHAR(10) NOT NULL REFERENCES PARCELS(parcelno),
    clientsnum CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum),
    PRIMARY KEY(parcelno, clientsnum)
);

CREATE TABLE TOURHOUSES (
    date DATE,
    hour TIME CHECK (hour >= '00:00:00' AND hour <= '23:59:59'),
    houseno CHAR(10) NOT NULL REFERENCES HOUSES(houseno),
    clientsnum CHAR(10) NOT NULL REFERENCES CLIENTS(clientnum),
    PRIMARY KEY(houseno, clientsnum)
);

INSERT INTO AGENCY(AGENCYNAME, WEBSITE, PHONENUM, PERSONALNO) VALUES
('SkylineOne', 'skylineone.com', '0879123456', '00000001'),
('VistaPoint', 'vistapoint.com', '0879123457', '00000003'),
('RiverdaleOffice', 'riverdaleoffice.com', '0879123458', '00000004'),
('StellarEstates', 'stellar-estates.com', '0879123459', '00000005'),
('AetherProperties', 'aetherproperties.com', '0879123460', '00000006'),
('NovaRealty', 'novarealty.com', '0879123461', '00000007'),
('SummitProperties', 'summitproperties.com', '0879123462', '00000008'),
('EagleRealty', 'eaglerealty.com', '0879123463', '00000011'),
('NextGenRealty', 'nextgenrealty.com', '0879123464', '00000012'),
('ZenithProperty', 'zenithproperty.com', '0879123465', '00000014'),
('ExploreProperties', 'exploreproperties.com', '0879123466', '00000016'),
('UrbanRootsOffice', 'urbanrootsoffice.com', '0879123467', '00000017'),
('AllianceEstate', 'allianceestate.com', '0879123468', '00000018'),
('PacificEstate', 'pacificestate.com', '0879123469', '00000019'),
('HorizonOne', 'horizonone.com', '0879123470', '00000020'),
('HomeStarOffice', 'homestaroffice.com', '0879123471', '00000021'),
('SunshineOffice', 'sunshineoffice.com', '0879123472', '00000022'),
('EcoHomesOffice', 'ecohomesoffice.com', '0879123473', '00000023'),
('UrbanLivingOffice', 'urbanlivingoffice.com', '0879123474', '00000024'),
('NewHorizonsOffice', 'newhorizonsoffice.com', '0879123475', '00000025'),
('EagleRealty2', 'eaglerealty2.com', '0879123476', '00000002'),
('AllianceEstate2', 'allianceestate2.com', '0879123477', '00000013'),
('PacificEstate2', 'pacificestate2.com', '0879123478', '00000010');

INSERT INTO AGENCY(AGENCYNAME, WEBSITE, PHONENUM, PERSONALNO) VALUES
('BigDay', 'bigday.com', '0879123473', '00000002'),
('SmallDay', 'smallday.com', '0875454885', '00000009'),
('HelloWorld', 'helloworld.com', '0879523476', '00000015'),
('Zeleno', 'zeleno.com', '0879126597', '00000013'),
('Malko', 'malko.com', '0879126598', '00000010');


INSERT INTO  OFFICE(ADDRESS, CITY, AGENCYPERSONALNO, OFFICENAME)
VALUES  ('ul. Kiril Popol 17', 'Plovdiv', '00000001', 'SkylineOneOffice'),
       ('ul. Konstantin Velichkov 53', 'Varna', '00000004', 'Riverdale'),
       ('ul. Stoyan Radichev 23', 'Sofia', '00000003', 'VistaPointOffice'),
       ('ul. Kontadin Dimitriev 28', 'Sliven', '00000017', 'UrbanRoots'),
       ('ul. Momin Kamak 60', 'Burgas', '00000014', 'ZenithPropertyOffice'),
       ('ul. Sulza 14', 'Pleven', '00000019', 'PacificEstateOffice'),
       ('ul. Stoyan Mihaylovski 14', 'Ruse', '00000020', 'HorizonOneOffice'),
       ('ul. Ivan Dimitriev', 'Aytos', '00000016', 'ExplorePropertiesOffice'),
       ('ul. Kosta Hristov 78', 'Sofia', '00000012', 'NextGenRealtyOffice'),
       ('ul. Dimitri Velkov 45', 'Varna', '00000014', 'ZenithProperty2Office'),
       ('ul. Jeko Jekov', 'Stara Zagora', '00000002', 'EagleRealtyOffice'),
       ('ul. Hristo Smirnenski 80', 'Slivnitsa', '00000005', 'StellarEstatesOffice'),
       ('ul. Pop Vakarel 12', 'Pleven', '00000006', 'AetherPropertiesOffice'),
       ('ul. Jivko Berov', 'Plovdiv', '00000007', 'NovaRealtyOffice'),
       ('ul. Barek Bareun', 'Sofia', '00000008', 'SummitPropertiesOffice'),
       ('ul. Metodii Ralyn', 'Veliko Tarnovo', '00000011', 'EagleRealty2Office'),
       ('ul. Stefan Stambolyski', 'Sliven', '00000013', 'AllianceEstateOffice'),
       ('ul. Kseny Gridin', 'Burgas', '00000010', 'PacificEstate2Office'),
       ('ul. Kristian Milev 76', 'Sofia', '00000021', 'HomeStar'),
       ('ul. Ivan Stranski 65', 'Plovdiv', '00000025', 'NewHorizons');

INSERT INTO PARCELS(PARCELNO, DESCRIPTION, CITY, NEIGHBOURHOOD, REGULATION, NAMEOFOFFICE)
VALUES ('AP00000001', '5000 sq ft, southern exposure', 'Sofia', 'Buxton', 1, 'SkylineOneOffice'),
  ('AP00000002', '7500 sq ft, western exposure', 'Sofia', 'Ovcha Kupel', 1, 'Riverdale'),
  ('AP00000003', '4000 sq ft, eastern exposure', 'Sofia', 'Hipodruma', 1, 'UrbanRoots'),
  ('AP00000004', '6000 sq ft, northern exposure', 'Sofia', 'Vitosha', 1, 'SkylineOneOffice'),
  ('AP00000005', '9000 sq ft, eastern exposure', 'Plovdiv', 'Kichuka', 0, 'HorizonOneOffice'),
  ('AP00000006', '3500 sq ft, southern exposure', 'Plovdiv', 'Orlandovci', 0, 'NextGenRealtyOffice'),
  ('AP00000007', '8000 sq ft, western exposure', 'Burgas', 'Slaveykov', 0, 'VistaPointOffice'),
  ('AP00000008', '5500 sq ft, northern exposure', 'Varna', 'Asparuhovo', 1, 'StellarEstatesOffice'),
  ('AP00000009', '4500 sq ft, western exposure', 'Varna', 'Pobeda', 1, 'NovaRealtyOffice'),
  ('AP00000010', '7000 sq ft, eastern exposure', 'Varna', 'Chayka', 0, 'NovaRealtyOffice'),
  ('AP00000011', '5200 sq ft, southern exposure', 'Sliven', 'Bulgarka', 1, 'ZenithPropertyOffice'),
  ('AP00000012', '3800 sq ft, northern exposure', 'Pleven', 'Snejanka', 1, 'AetherPropertiesOffice'),
  ('AP00000013', '5800 sq ft, western exposure', 'Ruse', 'Klutsohor', 0, 'AllianceEstateOffice'),
  ('AP00000014', '4200 sq ft, southern exposure', 'Stara Zagora', 'Knqjevo', 0, 'ExplorePropertiesOffice'),
  ('AP00000015', '6600 sq ft, eastern exposure', 'Sofia', 'Monastery livadi', 1, 'Riverdale');

INSERT INTO CLIENTS(CLIENTNUM, CLIENTNAME, BUDGET, EMAIL, CLIENTPHONE)
VALUES
    ('CLN1000000', 'Emilia Ivanova', 150000.00, 'emiliaivanova@gmail.com', '0886760004'),
    ('CLN2000000', 'Maria Petrova', 158000.00, 'mariapetrova12@abv.bg', '0879651247'),
    ('CLN3000000', 'Stefani Koleva', 200000.00, 'stefanik11@abv.bg', '0894578965'),
    ('CLN4000000', 'Georgi Georgiev', 500000.00, 'georgigeorgiev@abv.bg', '0875491200'),
    ('CLN5000000', 'Elena Ivanova', 300000.00, 'e.ivanova@abv.bg', '0885152244'),
    ('CLN6000000', 'Diana Petrova', 250000.00, 'dianapetrova@gmail.com', '0875654987'),
    ('CLN7000000', 'Anastasia Dimitrova', 140000.00, 'anadimitrova@abv.bg', '0876965478'),
    ('CLN8000000', 'Petar Ivanov', 250000.00, 'petar.ivanov@abv.bg', '0887471236'),
    ('CLN9000000', 'Kristina Stoyanova', 400000.00, 'kristinastoyanova@abv.bg', '0887475214'),
    ('CLN1100000', 'Ivan Dimitrov', 600000.00, 'ivandimitrov@abv.bg', '0874123478'),
    ('CLN1200000', 'Nikolay Kostov', 350000.00, 'nikolay.kostov@abv.bg', '0894712358'),
    ('CLN1300000', 'Mariya Ivanova', 100000.00, 'mariyaivanova@abv.bg', '0879541879'),
    ('CLN1400000', 'Vladimir Petrov', 260000.00, 'vladimirpetrov@abv.bg', '0875554128'),
    ('CLN1500000', 'Svetlana Ivanova', 600000.00, 'svetlana.ivanova@abv.bg', '0879631478'),
    ('CLN1600000', 'Stoyan Dimitrov', 500000.00, 'stoyandimitrov@abv.bg', '0883531847'),
    ('CLN1700000', 'Vasil Vasilev', 800000.00, 'vasil.vasilev@abv.bg', '0874640002'),
    ('CLN1800000', 'Milena Hristova', 560000.00, 'milenahristova@abv.bg', '0879631429'),
    ('CLN1900000', 'Nikola Ivanov', 1000000.00, 'nikolaivanov@abv.bg', '0894173621'),
    ('CLN2400000', 'Iskra Koleva', 900000.00, 'iskra.koleva@abv.bg', '0881947821'),
    ('CLN2100000', 'Ivo Petrov', 1200000.00, 'ivopetrov@abv.bg', '0870003368'),
    ('CLN2200000', 'Kamelia Hristova', 700000.00, 'kameliahristova@abv.bg', '0879991426'),
    ('CLN2300000', 'Dobrin Ivanov', 1200000.00, 'dobrin.ivanov@abv.bg', '0887471253');

INSERT INTO FLATS(FLATNO, DESCRIPTION, CITY, NEIGHBOURHOOD, ROOMS, FLOORS, NAMEOFFICE)
VALUES
  ('FL00000010', '5800 sq ft, western exposure', 'Ruse', 'Klutsohor', 3, 7, 'AllianceEstateOffice'),
  ('FL00000011', '4200 sq ft, southern exposure', 'Stara Zagora', 'Knqjevo', 2, 4, 'ExplorePropertiesOffice'),
  ('FL00000012', '6600 sq ft, eastern exposure', 'Sofia', 'Monastery livadi', 3, 6, 'Riverdale'),
  ('FL00000013', '4800 sq ft, southern exposure', 'Plovdiv', 'Trakiya', 2, 4, 'HorizonOneOffice'),
  ('FL00000014', '5500 sq ft, western exposure', 'Burgas', 'Lazur', 3, 6, 'VistaPointOffice'),
  ('FL00000015', '4200 sq ft, eastern exposure', 'Sofia', 'Studentski Grad', 1, 3, 'Riverdale'),
  ('FL00000016', '6000 sq ft, northern exposure', 'Varna', 'Briz', 2, 5, 'NovaRealtyOffice'),
  ('FL00000017', '7000 sq ft, eastern exposure', 'Sofia', 'Mladost', 4, 8, 'UrbanRoots'),
  ('FL00000018', '4800 sq ft, southern exposure', 'Plovdiv', 'Kapana', 1, 5, 'NextGenRealtyOffice'),
  ('FL00000019', '5500 sq ft, western exposure', 'Burgas', 'Meden Rudnik', 2, 6, 'SkylineOneOffice'),
  ('FL00000020', '4200 sq ft, eastern exposure', 'Sofia', 'Lozenets', 3, 7, 'Riverdale'),
  ('FL00000021', '6000 sq ft, northern exposure', 'Varna', 'Briz', 1, 3, 'NovaRealtyOffice'),
  ('FL00000022', '7000 sq ft, eastern exposure', 'Sofia', 'Iztok', 4, 8, 'UrbanRoots'),
  ('FL00000023', '3800 sq ft, southern exposure', 'Pleven', 'Drujba', 2, 6, 'AetherPropertiesOffice'),
  ('FL00000024', '4800 sq ft, western exposure', 'Ruse', 'Center', 1, 4, 'AllianceEstateOffice'),
  ('FL00000025', '5500 sq ft, eastern exposure', 'Sliven', 'Zora', 3, 5, 'ZenithPropertyOffice'),
  ('FL00000026', '4200 sq ft, northern exposure', 'Stara Zagora', 'Trakia', 2, 7, 'ExplorePropertiesOffice'),
  ('FL00000027', '6000 sq ft, eastern exposure', 'Plovdiv', 'Kurshiyaka', 4, 9, 'HorizonOneOffice'),
  ('FL00000028', '7000 sq ft, southern exposure', 'Burgas', 'Slaveykov', 1, 3, 'VistaPointOffice'),
  ('FL00000029', '3800 sq ft, western exposure', 'Sofia', 'Mladost', 2, 5, 'Riverdale'),
  ('FL00000030', '4800 sq ft, eastern exposure', 'Varna', 'Galata', 3, 6, 'NovaRealtyOffice'),
  ('FL00000031', '5500 sq ft, northern exposure', 'Plovdiv', 'Sahat Tepe', 1, 4, 'UrbanRoots'),
  ('FL00000032', '4200 sq ft, eastern exposure', 'Sofia', 'Ivan Vazov', 2, 7, 'NextGenRealtyOffice');


INSERT INTO TOURFLATS(CLIENTSNUM, FLATSNO, DATE, HOUR)
VALUES
   ('CLN1000000', 'FL00000010', '2024-05-20', '10:00:00'),
  ('CLN2000000', 'FL00000011', '2024-05-20', '11:00:00'),
  ('CLN3000000', 'FL00000012', '2024-05-21', '14:30:00'),
  ('CLN4000000', 'FL00000013', '2024-05-21', '15:30:00'),
  ('CLN5000000', 'FL00000014', '2024-05-22', '09:00:00'),
  ('CLN6000000', 'FL00000015', '2024-05-22', '10:00:00'),
  ('CLN7000000', 'FL00000016', '2024-05-23', '13:00:00'),
  ('CLN8000000', 'FL00000017', '2024-05-23', '14:00:00'),
  ('CLN9000000', 'FL00000018', '2024-05-24', '12:00:00'),
  ('CLN1100000', 'FL00000019', '2024-05-24', '13:00:00'),
  ('CLN1200000', 'FL00000020', '2024-05-25', '11:30:00'),
  ('CLN1300000', 'FL00000021', '2024-05-25', '12:30:00'),
  ('CLN1400000', 'FL00000022', '2024-05-26', '15:30:00'),
  ('CLN1500000', 'FL00000023', '2024-05-26', '16:30:00'),
  ('CLN1600000', 'FL00000024', '2024-05-27', '10:30:00'),
  ('CLN1700000', 'FL00000025', '2024-05-27', '11:30:00'),
  ('CLN1800000', 'FL00000026', '2024-05-28', '14:00:00'),
  ('CLN1900000', 'FL00000027', '2024-05-28', '15:00:00'),
  ('CLN2400000', 'FL00000028', '2024-05-29', '09:30:00'),
  ('CLN2100000', 'FL00000029', '2024-05-29', '10:30:00'),
  ('CLN2200000', 'FL00000030', '2024-05-30', '13:30:00'),
  ('CLN2300000', 'FL00000031', '2024-05-30', '14:30:00');

INSERT INTO TOURPARCEL(DATE, HOUR, PARCELNO, CLIENTSNUM)
VALUES   ('2024-05-18', '10:00', 'AP00000001', 'CLN1000000'),
    ('2024-05-18', '11:00', 'AP00000002', 'CLN2000000'),
    ('2024-05-18', '12:00', 'AP00000003', 'CLN3000000'),
    ('2024-05-18', '13:00', 'AP00000004', 'CLN4000000'),
    ('2024-05-18', '14:00', 'AP00000005', 'CLN5000000'),
    ('2024-05-18', '15:00', 'AP00000006', 'CLN6000000'),
    ('2024-05-18', '16:00', 'AP00000007', 'CLN7000000'),
    ('2024-05-18', '17:00', 'AP00000008', 'CLN8000000'),
    ('2024-05-18', '18:00', 'AP00000009', 'CLN9000000'),
    ('2024-05-18', '19:00', 'AP00000010', 'CLN1100000');

INSERT INTO SALES(DEALNO, DATE, FLATSNUM, AGENCYPERSONALNO, CLIENTSNO)
VALUES  ('DL000011', '2024-06-01', 'FL00000031', '00000002', 'CLN2400000'),
    ('DL000002', '2024-06-02', 'FL00000014', '00000002', 'CLN2000000'),
    ('DL000003', '2024-06-03', 'FL00000015', '00000003', 'CLN3000000'),
    ('DL000004', '2024-06-04', 'FL00000016', '00000004', 'CLN4000000'),
    ('DL000005', '2024-06-05', 'FL00000017', '00000005', 'CLN5000000'),
    ('DL000006', '2024-06-06', 'FL00000018', '00000006', 'CLN6000000'),
    ('DL000007', '2024-06-07', 'FL00000019', '00000007', 'CLN7000000'),
    ('DL000008', '2024-06-08', 'FL00000020', '00000008', 'CLN8000000'),
    ('DL000009', '2024-06-09', 'FL00000026', '00000009', 'CLN9000000'),
    ('DL000010', '2024-06-10', 'FL00000027', '00000010', 'CLN1100000');

INSERT INTO PARCELDEAL(DEALNO, DATE, PARCELNUM, AGENCYPERSONALNO, CLIENTSNO)
VALUES ('DLP00001', '2024-06-03', 'AP00000001', '00000007', 'CLN1700000'),
       ('DLP00003', '2024-06-05', 'AP00000003', '00000009', 'CLN1900000'),
       ('DLP00004', '2024-06-06', 'AP00000004', '00000010', 'CLN3200000'),
       ('DLP00005', '2024-06-07', 'AP00000005', '00000011', 'CLN2100000'),
       ('DLP00006', '2024-06-08', 'AP00000006', '00000012', 'CLN2200000'),
       ('DLP00007', '2024-06-09', 'AP00000007', '00000013', 'CLN2300000'),
       ('DLP00008', '2024-06-10', 'AP00000008', '00000014', 'CLN1500000'),
       ('DLP00009', '2024-06-11', 'AP00000009', '00000015', 'CLN1600000'),
       ('DLP00010', '2024-06-12', 'AP00000015', '00000016', 'CLN2800000');

INSERT INTO HOUSES (HOUSENO, DESCRIPTION, CITY, NEIGHBOURHOOD, ROOMS, FLOORS, NAMEOFFICE)
VALUES
    ('HS0000005', 'Cozy house with garden', 'Sofia', 'Izgrev', 4, 2, 'NovaRealtyOffice'),
    ('HS0000006', 'Modern house with mountain view', 'Veliko Tarnovo', 'Kartala', 5, 3, 'ExplorePropertiesOffice');

INSERT INTO HOUSESDEALS (DEALNO, DATE, HOUSENO, AGENCYPERSONALNO, CLIENTSNO)
VALUES
    ('HDL00005', '2024-06-13', 'HS00000005', '00000007', 'CLN1700000'),
    ('HDL00006', '2024-06-14', 'HS00000006', '00000008', 'CLN1800000');

INSERT INTO FLATDEALS (DEALNO, DATE, FLATNO, AGENCYPERSONALNO, CLIENTSNO)
VALUES
    ('FDL00005', '2024-06-13', 'FL00000032', '00000007', 'CLN1700000'),
    ('FDL00006', '2024-06-14', 'FL00000031', '00000008', 'CLN1800000');

CREATE VIEW V_AGENCY_OFFICE
AS
SELECT O.officename, F.CITY, F.neighbourhood
FROM OFFICE O, FLATS F
WHERE O.OFFICENAME = F.NAMEOFFICE;

SELECT * FROM V_AGENCY_OFFICE
WHERE officename = 'SkylineOneOffice';

DROP VIEW V_AGENCY_OFFICE;

CREATE VIEW V_CLIENTS_ALL
AS
SELECT CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM
FROM CLIENTS
WHERE BUDGET >=  250000;

SELECT * FROM V_CLIENTS_ALL;

INSERT INTO V_CLIENTS_ALL(CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM)
VALUES ('Kalin Petrov', '0879247878', 'kalinpetrovv@abv.bg', '300000', 'CLN3400000');

DROP VIEW V_CLIENTS_ALL;

SELECT * FROM V_CLIENTS_ALL;

CREATE VIEW V_CLIENTS_ALL_WITH_CK
AS
SELECT CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM
FROM CLIENTS
WHERE BUDGET >=  250000
WITH CHECK OPTION;

SELECT * FROM V_CLIENTS_ALL_WITH_CK;

INSERT INTO V_CLIENTS_ALL_WITH_CK(CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM)
VALUES ('Ivan Ivanov', '0888123456', 'ivanivanov@abv.bg', '300000', 'CLN3400000');

SELECT * FROM V_CLIENTS_ALL_WITH_CK;

INSERT INTO V_CLIENTS_ALL_WITH_CK(CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM)
VALUES ('Georgi Petrov', '0888333444', 'georgipetrov@abv.bg', '200000', 'CLN2800000');

INSERT INTO V_CLIENTS_ALL_WITH_CK(CLIENTNAME, CLIENTPHONE, EMAIL, BUDGET, CLIENTNUM)
VALUES ('Petar Dimitrov', '0899123456', 'petardimitrov@abv.bg', '250000', 'CLN2900000');

SELECT * FROM V_CLIENTS_ALL_WITH_CK;

CREATE TABLE IF NOT EXISTS Patients (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
createdAt Date  DEFAULT NULL,
isDeleted Boolean,
lastConsultation Date  DEFAULT NULL,
lastName Varchar(30),
name Varchar(30), 
doctor integer,
FOREIGN KEY(doctor) REFERENCES Doctors(identifier));

CREATE TABLE IF NOT EXISTS Doctors (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
createdAt Date  DEFAULT NULL,
avatar Binary,
isDeleted Boolean,
email Varchar(30) DEFAULT NULL,
lastName Varchar(30),
name Varchar(30),
password Varchar(30));

CREATE TABLE IF NOT EXISTS Consultations (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
date Date  DEFAULT NULL,
createdAt Date  DEFAULT NULL,
notes TEXT DEFAULT NULL,
done Boolean  NOT NULL  DEFAULT 0,
rating integer  NOT NULL DEFAULT 0,
patient integer,
FOREIGN KEY(patient) REFERENCES Patients(identifier));
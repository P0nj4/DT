CREATE TABLE IF NOT EXISTS Patients (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
createdAt Date  DEFAULT NULL,
isDeleted integer DEFAULT 0,
lastConsultation Date  DEFAULT NULL,
lastName Varchar(30),
name Varchar(30), 
doctor integer,
FOREIGN KEY(doctor) REFERENCES Doctors(identifier));
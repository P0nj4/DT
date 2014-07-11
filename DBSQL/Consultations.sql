CREATE TABLE IF NOT EXISTS Consultations (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
consDate Date  DEFAULT NULL,
createdAt Date  DEFAULT NULL,
notes TEXT DEFAULT NULL,
done integer  NOT NULL  DEFAULT 0,
rating integer  NOT NULL DEFAULT 0,
patient integer,
FOREIGN KEY(patient) REFERENCES Patients(identifier))
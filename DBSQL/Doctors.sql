CREATE TABLE IF NOT EXISTS Doctors (
identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
createdAt Date  DEFAULT NULL,
avatar Binary,
isDeleted integer DEFAULT 0,
email Varchar(30) DEFAULT NULL,
lastName Varchar(30),
name Varchar(30),
password Varchar(30));
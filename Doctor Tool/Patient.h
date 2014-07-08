//
//  Patient.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 CREATE TABLE Patients (
 identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
 createdAt Date  DEFAULT NULL,
 deleted Boolean,
 lastConsultation Date  DEFAULT NULL,
 lastName Varchar(30),
 name Varchar(30),
 doctor integer,
 FOREIGN KEY(doctor) REFERENCES Doctors(identifier))
 
 */
@interface Patient : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, strong) NSDate *lastConsultation;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) Doctor *doctor;
@end

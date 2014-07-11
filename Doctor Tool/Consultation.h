//
//  Consultation.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entities.h"
@class Patient;

/*
 
 
 CREATE TABLE Consultations (
 identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
 date Date  DEFAULT NULL,
 createdAt Date  DEFAULT NULL,
 notes TEXT DEFAULT NULL,
 done Boolean  NOT NULL  DEFAULT 0,
 rating integer  NOT NULL DEFAULT 0,
 patient integer,
 FOREIGN KEY(patient) REFERENCES Patients(identifier))
 
 */

@interface Consultation : NSObject <Entities>
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, assign) BOOL done;
@property (nonatomic, weak) Patient *patient;
- (NSComparisonResult)compareTo:(Consultation *)consultation2;
- (id)initWithRating:(NSInteger)prating notes:(NSString *)pnotes date:(NSDate *)pdate patient:(Patient *)ppatient;
+ (NSMutableDictionary *)getAllWithParent:(id)parent staringDate:(NSDate *)start endingDate:(NSDate *)end;
+ (NSMutableDictionary *)getAllStaringDate:(NSDate *)start endingDate:(NSDate *)end;
@end

//
//  Patient.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Patient.h"
#import "Doctor.h"

@implementation Patient

- (id)initWithName:(NSString *)pname lastName:(NSString *)plastName doctor:(Doctor *)pdoctor{
    self = [super init];
    if (self) {
        self.name = pname;
        self.lastName = plastName;
        self.doctor = pdoctor;
    }
    return self;
}

/*
 identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
 createdAt Date  DEFAULT NULL,
 isDeleted Boolean,
 lastConsultation Date  DEFAULT NULL,
 lastName Varchar(30),
 name Varchar(30),
 doctor integer,
 FOREIGN KEY(doctor) REFERENCES Doctors(identifier))
 
 */

- (void)saveMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL result = [database executeUpdate:@"INSERT INTO Patients (createdAt, lastName, name, doctor) VALUES (?, ?, ?, ?)",[NSDate date], self.lastName, self.name, [NSNumber numberWithInteger:self.doctor.identifier], nil];
    if (!result) {
        [database close];
        @throw [[NSException alloc] initWithName:kGenericError reason:@"Enable to save the data" userInfo:nil];
    }
    
    NSInteger lastRow = (NSInteger)[database lastInsertRowId] ;
    self.identifier = (lastRow);
    [database close];
    
}

- (void)updateMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL result = [database executeUpdate:@"UPDATE Patients set lastName = ?, name = ?, doctor = ?", self.lastName, self.name, [NSNumber numberWithInteger:self.doctor.identifier], nil];
    [database close];
    
    if (!result) {    
        @throw [[NSException alloc] initWithName:kGenericError reason:@"Enable to save the data" userInfo:nil];
    }
}

- (void)loadMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * from Patients where identifier = ?",[NSString stringWithFormat:@"%li", (long)self.identifier], nil];
    
    while([results next]) {
        self.identifier = [results intForColumn:@"identifier"];
        self.name = [results stringForColumn:@"name"];
        self.lastName = [results stringForColumn:@"lastName"];
        self.createdAt = [results dateForColumn:@"createdAt"];
        self.isDeleted = [results boolForColumn:@"isDeleted"];
    }
    [database close];
    
}


+ (NSMutableDictionary *)getAll{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * from Patients where isDeleted = ?", [NSNumber numberWithBool:NO], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Patient *pat = nil;
    while([results next]) {
        pat = [[Patient alloc] init];
        pat.identifier = [results intForColumn:@"identifier"];
        pat.name = [results stringForColumn:@"name"];
        pat.lastName = [results stringForColumn:@"lastName"];
        pat.createdAt = [results dateForColumn:@"createdAt"];
        pat.isDeleted = [results boolForColumn:@"isDeleted"];
        [dict setObject:pat forKey:[NSNumber numberWithInteger:pat.identifier]];
    }
    [database close];
    
    return dict;
}


+ (NSMutableDictionary *)getAllWithParent:(id)parent{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    Doctor *doc = (Doctor *)parent;
    FMResultSet *results = [database executeQuery:@"SELECT * from Patients where isDeleted = ? and doctor = ?", [NSNumber numberWithBool:NO], [NSNumber numberWithInteger:doc.identifier], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Patient *pat = nil;
    while([results next]) {
        pat = [[Patient alloc] init];
        pat.identifier = [results intForColumn:@"identifier"];
        pat.name = [results stringForColumn:@"name"];
        pat.lastName = [results stringForColumn:@"lastName"];
        pat.createdAt = [results dateForColumn:@"createdAt"];
        pat.isDeleted = [results boolForColumn:@"isDeleted"];
        [dict setObject:pat forKey:[NSNumber numberWithInteger:pat.identifier]];
    }
    [database close];
    
    return dict;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%li %@ %@ %@ %hhd",(long)self.identifier, self.name, self.lastName, self.createdAt, self.isDeleted];
}

@end

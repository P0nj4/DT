//
//  Consultation.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Consultation.h"
#import "Patient.h"

@implementation Consultation


- (void)saveMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    /*
     @property (nonatomic, assign) NSInteger rating;
     @property (nonatomic, strong) NSDate *date;
     @property (nonatomic, strong) NSDate *createdAt;
     @property (nonatomic, assign) BOOL deleted;
     @property (nonatomic, strong) NSString *notes;
     @property (nonatomic, assign) BOOL *done;
     @property (nonatomic, weak) Patient *patient;
     
     */
    
    BOOL result = [database executeUpdate:@"INSERT INTO Consultations (rating, date, createdAt, notes, patient) VALUES (?, ?, ?, ?, ?)", [NSNumber numberWithInteger:self.rating], self.date, [NSDate date], self.notes, [NSNumber numberWithInteger:self.patient.identifier], nil];
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
    BOOL result = [database executeUpdate:@"UPDATE Consultations set rating = ?, date = ?, notes = ?, patient = ?, done = ?, deleted = ? where identifier = ?", [NSNumber numberWithInteger:self.rating], self.date, self.notes, [NSNumber numberWithInteger:self.patient.identifier], [NSNumber numberWithBool:self.done], [NSNumber numberWithBool:self.deleted], [NSNumber numberWithInteger:self.identifier], nil];
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
    FMResultSet *results = [database executeQuery:@"SELECT * from Consultations where identifier = ?",[NSString stringWithFormat:@"%li", (long)self.identifier], nil];
    while([results next]) {
        self.identifier = [results intForColumn:@"identifier"];
        self.rating = [results intForColumn:@"rating"];
        self.date = [results dateForColumn:@"date"];
        self.createdAt = [results dateForColumn:@"createdAt"];
        self.deleted = [results boolForColumn:@"deleted"];
        self.notes = [results stringForColumn:@"notes"];
        self.done = [results boolForColumn:@"done"];
    }
    [database close];
}


+ (NSMutableDictionary *)getAll{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * from Consultations where deleted = ?", [NSNumber numberWithBool:NO], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
        con.deleted = [results boolForColumn:@"deleted"];
        con.notes = [results stringForColumn:@"notes"];
        con.done = [results boolForColumn:@"done"];
        [dict setObject:con forKey:[NSNumber numberWithInteger:con.identifier]];
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
    
    Patient *pat = (Patient *)parent;
    FMResultSet *results = [database executeQuery:@"SELECT * from Consultations where deleted = ? and patient = ?", [NSNumber numberWithBool:NO], [NSNumber numberWithInteger:pat.identifier], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
        con.deleted = [results boolForColumn:@"deleted"];
        con.notes = [results stringForColumn:@"notes"];
        con.done = [results boolForColumn:@"done"];
        [dict setObject:con forKey:[NSNumber numberWithInteger:con.identifier]];
    }
    [database close];
    
    return dict;
}


@end

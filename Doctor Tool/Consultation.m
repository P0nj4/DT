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


- (id)initWithRating:(NSInteger)prating notes:(NSString *)pnotes date:(NSDate *)pdate{
    self = [super init];
    if (self) {
        self.rating = prating;
        self.notes = pnotes;
        self.date = pdate;
    }
    return self;
}

- (void)saveMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
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
    BOOL result = [database executeUpdate:@"UPDATE Consultations set rating = ?, date = ?, notes = ?, patient = ?, done = ?, isDeleted = ? where identifier = ?", [NSNumber numberWithInteger:self.rating], self.date, self.notes, [NSNumber numberWithInteger:self.patient.identifier], [NSNumber numberWithBool:self.done], [NSNumber numberWithBool:self.isDeleted], [NSNumber numberWithInteger:self.identifier], nil];
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
        self.isDeleted = [results boolForColumn:@"isDeleted"];
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
    FMResultSet *results = [database executeQuery:@"SELECT * from Consultations", nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con = [[Consultation alloc] init];
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
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
    FMResultSet *results = [database executeQuery:@"SELECT * from Consultations where patient = ?",  [NSNumber numberWithInteger:pat.identifier], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con = [[Consultation alloc] init];
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
        con.isDeleted = [results boolForColumn:@"isDeleted"];
        con.notes = [results stringForColumn:@"notes"];
        con.done = [results boolForColumn:@"done"];
        [dict setObject:con forKey:[NSNumber numberWithInteger:con.identifier]];
    }
    [database close];
    
    return dict;
}

+ (NSMutableDictionary *)getAllWithParent:(id)parent staringDate:(NSDate *)start endingDate:(NSDate *)end{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    Patient *pat = (Patient *)parent;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat:@"select * from Consultations where patient = ? AND date(Consultations.date) > date('%@') date(Consultation.date) < ('%@')", [formatter stringFromDate:start], [formatter stringFromDate:end]],[NSNumber numberWithInteger:pat.identifier], nil];
    //FMResultSet *results = [database executeQuery:@"SELECT * from Consultations where patient = ? AND date BETWEEN \"2010-01-01\" AND \"2015-01-01\" ", [NSNumber numberWithInteger:pat.identifier], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con = [[Consultation alloc] init];
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
       
        con.notes = [results stringForColumn:@"notes"];
        con.done = [results boolForColumn:@"done"];
        [dict setObject:con forKey:[NSNumber numberWithInteger:con.identifier]];
    }
    [database close];
    
    return dict;
}


+ (NSMutableDictionary *)getAllStaringDate:(NSDate *)start endingDate:(NSDate *)end{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    FMResultSet *results = [database executeQuery:[NSString stringWithFormat:@"select * from Consultations where date(Consultations.date) > date('%@') date(Consultation.date) < ('%@')", [formatter stringFromDate:start], [formatter stringFromDate:end]], nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Consultation *con = nil;
    while([results next]) {
        con = [[Consultation alloc] init];
        con.identifier = [results intForColumn:@"identifier"];
        con.rating = [results intForColumn:@"rating"];
        con.date = [results dateForColumn:@"date"];
        con.createdAt = [results dateForColumn:@"createdAt"];
        con.notes = [results stringForColumn:@"notes"];
        con.done = [results boolForColumn:@"done"];
        [dict setObject:con forKey:[NSNumber numberWithInteger:con.identifier]];
    }
    [database close];
    
    return dict;
}


@end

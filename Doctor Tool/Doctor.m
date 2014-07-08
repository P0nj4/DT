//
//  Doctor.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor


- (id)initWithName:(NSString *)pname lastName:(NSString *)plastName email:(NSString *)pemail password:(NSString *)pass avatar:(UIImage *)pavatar{
    self = [super init];
    if (self) {
        self.name = pname;
        self.lastName = plastName;
        self.avatar = pavatar;
        self.password = pass;
        self.email = pemail;
    }
    return self;
}

- (void)saveMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL result = [database executeUpdate:@"INSERT INTO Doctors (createdAt, avatar, email, lastName, name, password) VALUES (?, ?, ?, ?, ?, ?)",[NSDate date], self.avatar, self.email, self.lastName, self.name, self.password, nil];
    if (!result) {
        [database close];
        @throw [[NSException alloc] initWithName:kGenericError reason:@"Enable to save the data" userInfo:nil];
    }
    
    NSInteger lastRow = (NSInteger)[database lastInsertRowId] ;
    self.identifier = lastRow;
    [database close];
    
}

- (void)updateMe{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    BOOL result = [database executeUpdate:@"UPDATE Doctors set avatar = ?, email = ?, lastName = ?, name = ?, password = ?", self.avatar, self.email, self.lastName, self.name, self.password, nil];
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
    //FMResultSet *results = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM Doctors where identifier = %li", (long)self.identifier]];
    FMResultSet *results = [database executeQuery:@"SELECT * from Doctors where identifier = ?",[NSString stringWithFormat:@"%li", (long)self.identifier]];
    while([results next]) {
        self.identifier = [results intForColumn:@"identifier"];
        self.name = [results stringForColumn:@"name"];
        self.lastName = [results stringForColumn:@"lastName"];
        self.createdAt = [results dateForColumn:@"createdAt"];
        self.avatar = [UIImage imageWithData:[results dataForColumn:@"avatar"]];
        self.deleted = [results boolForColumn:@"deleted"];
        self.email = [results stringForColumn:@"email"];
        self.password = [results stringForColumn:@"password"];
    }
    [database close];
}


+ (NSMutableDictionary *)getAll{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    //FMResultSet *results = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM Doctors where identifier = %li", (long)self.identifier]];
    FMResultSet *results = [database executeQuery:@"SELECT * from Doctors where deleted = ?", [NSNumber numberWithBool:NO]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    Doctor *doc = nil;
    while([results next]) {
        doc = [[Doctor alloc] init];
        doc.identifier = [results intForColumn:@"identifier"];
        doc.name = [results stringForColumn:@"name"];
        doc.lastName = [results stringForColumn:@"lastName"];
        doc.createdAt = [results dateForColumn:@"createdAt"];
        doc.avatar = [UIImage imageWithData:[results dataForColumn:@"avatar"]];
        doc.deleted = [results boolForColumn:@"deleted"];
        doc.email = [results stringForColumn:@"email"];
        doc.password = [results stringForColumn:@"password"];
        [dict setObject:doc forKey:[NSNumber numberWithInteger:doc.identifier]];
    }
    [database close];
    
    return dict;
}
@end

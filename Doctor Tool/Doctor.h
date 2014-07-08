//
//  Doctor.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entities.h"
/*
 CREATE TABLE Doctors (
 identifier integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
 createdAt Date  DEFAULT NULL,
 avatar Binary,
 isDeleted Boolean,
 email Varchar(30) DEFAULT NULL,
 lastName Varchar(30),
 name Varchar(30),
 password Varchar(30))
 */
@interface Doctor : NSObject <Entities>
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, assign) BOOL isDeleted;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSMutableDictionary *patients;

- (id)initWithName:(NSString *)pname lastName:(NSString *)plastName email:(NSString *)pemail password:(NSString *)pass avatar:(UIImage *)pavatar;
@end

//
//  User.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

//typedef enum {Doctor, Admin, Other} Role;

@interface Doctor : NSObject
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSMutableDictionary *patients;
@property (nonatomic, strong) NSMutableDictionary *consultations;
//@property (nonatomic, assign) Role role;


- (id)initWithParse:(PFObject *)object error:(NSError **)error;
- (id)initWithEmail:(NSString *)pemail password:(NSString *)ppassword name:(NSString *)pname lastName:(NSString *)plastName avatar:(UIImage *)pavatar;
@end

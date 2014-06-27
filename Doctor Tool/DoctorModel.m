//
//  UserModel.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "DoctorModel.h"
#import "Doctor.h"
#import "NSString+MD5.h"

@implementation DoctorModel

+ (void)loginDoctor:(NSString *)email password:(NSString *)pass{
    
    if(![CommonValidations validateEmail:email]){
        @throw [[NSException alloc] initWithName:@"invalidEmailFormat" reason:@"" userInfo:nil];
    }
    pass = [pass stringConvertedToMD5];
    Doctor *u;
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"password" equalTo:pass];
    [query whereKey:@"email" equalTo:email];

    NSError *error;
    NSArray *result = [query findObjects:&error];
    
    if (!error) {
        if (result.count == 0) {
            @throw [[NSException alloc] initWithName:@"invalidLogin" reason:error.description userInfo:nil];
        }else{
            PFObject *obj = [result objectAtIndex:0];
            u = [[Doctor alloc] initWithParse:obj error:&error];
            if (error) {
                @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
            }
        }
    }else{
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
    [Session sharedInstance].doctor = u;
}

+ (void)registerDoctor:(Doctor *)u{
    
    if(![CommonValidations validateEmail:u.email]){
        @throw [[NSException alloc] initWithName:@"invalidEmailFormat" reason:@"" userInfo:nil];
    }
    
    if(![CommonValidations validateMinimumLength:u.password parameter:6]){
        @throw [[NSException alloc] initWithName:@"invalidPasswordLength" reason:@"" userInfo:nil];
    }
    
    PFObject *parse = [PFObject objectWithClassName:@"Doctor"];
    NSString *pass = [u.password stringConvertedToMD5];
    parse[@"name"] = u.name;
    parse[@"lastName"] = u.lastName;
    parse[@"password"] = pass;
    parse[@"email"] = u.email;
    NSError *error;
    [parse save:&error];
    if (error) {
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }else{
        u.identifier = parse.objectId;
        [Session sharedInstance].doctor = u;
    }
}


+ (NSMutableArray *)getAllUsers{
    NSMutableArray *arr;
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    NSError *error;
    NSArray *result = [query findObjects:&error];
    
    if (!error) {
        Doctor *u;
        for (PFObject *obj in result) {
            if (!arr) {
                arr = [[NSMutableArray alloc] initWithCapacity:result.count];
            }
            u = [[Doctor alloc] init];
            u.name = [obj objectForKey:@"name"];
            u.lastName = [obj objectForKey:@"lastName"];
            u.email = [obj objectForKey:@"email"];
            u.email = [obj objectForKey:@"objectId"];
            [arr addObject:u];
        }
    }else{
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
    return arr;
}

@end

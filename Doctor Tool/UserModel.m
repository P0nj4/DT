//
//  UserModel.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "UserModel.h"
#import <Parse/Parse.h>
#import "User.h"
#import "NSString+MD5.h"

NSString* const genericError = @"genericError";

@implementation UserModel

+ (User *)loginUser:(NSString *)userName password:(NSString *)pass{
    pass = [pass stringConvertedToMD5];
    User *u;
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"password" equalTo:pass];

    NSError *error;
    NSArray *result = [query findObjects:&error];
    
    if (!error) {
        if (result.count == 0) {
            @throw [[NSException alloc] initWithName:@"invalidLogin" reason:error.description userInfo:nil];
        }else{
            PFObject *obj = [result objectAtIndex:0];
            u = [[User alloc] init];
            u.name = [obj objectForKey:@"name"];
            u.lastName = [obj objectForKey:@"lastName"];
            u.email = [obj objectForKey:@"email"];
        }
    }else{
        @throw [[NSException alloc] initWithName:genericError reason:error.description userInfo:nil];
    }
    return u;
}

+ (void)registerUser:(User *)u{
    PFObject *parse = [PFObject objectWithClassName:@"_User"];
    NSString *pass = [u.password stringConvertedToMD5];
    parse[@"name"] = u.name;
    parse[@"lastName"] = u.lastName;
    parse[@"passwod"] = pass;
    parse[@"email"] = u.email;
    NSError *error;
    [parse save:&error];
    if (error) {
        @throw [[NSException alloc] initWithName:genericError reason:error.description userInfo:nil];
    }
}


+ (NSMutableArray *)getAllUsers{
    NSMutableArray *arr;
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    NSError *error;
    NSArray *result = [query findObjects:&error];
    
    if (!error) {
        User *u;
        for (PFObject *obj in result) {
            if (!arr) {
                arr = [[NSMutableArray alloc] initWithCapacity:result.count];
            }
            u = [[User alloc] init];
            u.name = [obj objectForKey:@"name"];
            u.lastName = [obj objectForKey:@"lastName"];
            u.email = [obj objectForKey:@"email"];
            u.email = [obj objectForKey:@"objectId"];
            [arr addObject:u];
        }
    }else{
        @throw [[NSException alloc] initWithName:genericError reason:error.description userInfo:nil];
    }
    return arr;
}

@end

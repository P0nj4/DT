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

+ (Doctor *)loginDoctor:(NSString *)userName password:(NSString *)pass{
    pass = [pass stringConvertedToMD5];
    Doctor *u;
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"password" equalTo:pass];

    NSError *error;
    NSArray *result = [query findObjects:&error];
    
    if (!error) {
        if (result.count == 0) {
            @throw [[NSException alloc] initWithName:@"invalidLogin" reason:error.description userInfo:nil];
        }else{
            PFObject *obj = [result objectAtIndex:0];
            u = [[Doctor alloc] init];
            u.name = [obj objectForKey:@"name"];
            u.lastName = [obj objectForKey:@"lastName"];
            u.email = [obj objectForKey:@"email"];
        }
    }else{
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
    return u;
}

+ (void)registerDoctor:(Doctor *)u{
    PFObject *parse = [PFObject objectWithClassName:@"Doctor"];
    NSString *pass = [u.password stringConvertedToMD5];
    parse[@"name"] = u.name;
    parse[@"lastName"] = u.lastName;
    parse[@"passwod"] = pass;
    parse[@"email"] = u.email;
    NSError *error;
    [parse save:&error];
    if (error) {
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
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

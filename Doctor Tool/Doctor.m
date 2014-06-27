//
//  User.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor
@synthesize avatar, name, lastName, identifier, email, password;

- (id)initWithParse:(PFObject *)object error:(NSError **)error{
    self = [super init];
    if (self) {
        if (![object objectForKey:@"name"] || [object objectForKey:@"date"] || [object objectForKey:@"notes"]) {
            *error = [NSError errorWithDomain:@"wrongPatient" code:200 userInfo:nil];
            return self;
        }
        self.identifier = object.objectId;
        self.name = [object objectForKey:@"name"];
        self.lastName = [object objectForKey:@"lastName"];
        self.email = [object objectForKey:@"email"];
        self.password = [object objectForKey:@"password"];
        
        self.consultations = [[NSMutableDictionary alloc] init];
        self.patients = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (id)initWithEmail:(NSString *)pemail password:(NSString *)ppassword name:(NSString *)pname lastName:(NSString *)plastName avatar:(UIImage *)pavatar{
    self = [super init];
    if (self) {
        self.email = pemail;
        self.password = ppassword;
        self.name = pname;
        self.lastName = plastName;
        self.avatar = pavatar;
    }
    return self;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"id:%@ name:%@ lastName:%@ email:%@", self.identifier, self.name, self.lastName, self.email];
}

@end

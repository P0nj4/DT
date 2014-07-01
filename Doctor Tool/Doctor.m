//
//  User.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Doctor.h"


@implementation Doctor
@synthesize avatar, name, lastName, identifier, email;

- (id)initWithObject:(NSManagedObject *)object error:(NSError **)error{
    self = [super init];
    if (self) {
        
        self.identifier = [object objectID];
        self.name = [object valueForKey:@"name"];
        self.lastName = [object valueForKey:@"lastName"];
        self.email = [object valueForKey:@"email"];
        
        self.consultations = [[NSMutableDictionary alloc] init];
        self.patients = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (NSManagedObject *)convertToDatabase:(NSManagedObjectContext *)context{
    NSManagedObject *newElement;
    newElement = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:context];
    [newElement setValue:self.name forKey:@"name"];
    [newElement setValue:self.lastName forKey:@"lastName"];
    [newElement setValue:self.email forKey:@"email"];
    return newElement;
}


- (NSManagedObject *)updateToDatabase:(NSManagedObjectContext *)context managedObject:(NSManagedObject*)object{
    [object setValue:self.name forKey:@"name"];
    [object setValue:self.lastName forKey:@"lastName"];
    [object setValue:self.email forKey:@"email"];
    return object;
}

- (id)init{
    self = [super init];
    if (self) {
        self.consultations = [[NSMutableDictionary alloc] init];
        self.patients = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithEmail:(NSString *)pemail name:(NSString *)pname lastName:(NSString *)plastName avatar:(UIImage *)pavatar{
    self = [super init];
    if (self) {
        self.email = pemail;
        self.name = pname;
        self.lastName = plastName;
        self.avatar = pavatar;
    }
    return self;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"name:%@ lastName:%@ email:%@", self.name, self.lastName, self.email];
}

@end

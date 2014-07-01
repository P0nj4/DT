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

- (NSMutableArray *)getAll{
    NSMutableArray *result = nil;
   
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Doctor" inManagedObjectContext:context];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)", @""];
    //[request setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *response = [context executeFetchRequest:request
                                              error:&error];
   
    Doctor *docAux = nil;
    for (NSManagedObject *matches in response) {
        NSError *err;
        docAux = [[Doctor alloc] initWithObject:matches error:&err];
        if (!err) {
            if (!result) {
                result = [[NSMutableArray alloc] init];
            }
            [result addObject:docAux];
        }
        docAux = nil;
    }
    return result;
}

- (void)update:(id)object{
    Doctor *docAux = (Doctor *)object;
    NSManagedObjectID *identifier = docAux.identifier;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *obj = [context objectRegisteredForID:identifier];
    
    [docAux updateToDatabase:context managedObject:obj];
    
    NSError *error;
    [context save:&error];
    if (error) {
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
}

- (void)save:(id)object{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newElement;
    
    Doctor *docAux = (Doctor *)object;
    newElement = [docAux convertToDatabase:context];
    NSError *error;
    [context save:&error];
    
    
    if (error) {
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
}


@end

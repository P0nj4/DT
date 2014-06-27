//
//  PatientModel.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "PatientModel.h"
#import "Patient.h"
#import "Doctor.h"

@implementation PatientModel

+ (void)loadDoctorPatients:(Doctor *)doc{
    if (doc.patients) {
        doc.patients = nil;
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"doctor" equalTo:doc.identifier];
    
    NSError *error;
    NSArray *result = [query findObjects:&error];
    if (!error) {
        
        Patient *pAux = nil;
        for (PFObject *obj in result) {
            
            pAux = [[Patient alloc] initWithParse:obj error:&error];
            if (!error) {
                [doc.patients setObject:pAux forKey:pAux.identifier];
            }else{
                error = nil;
            }
            pAux = nil;
        }
    }else{
        @throw [[NSException alloc] initWithName:kGenericError reason:error.description userInfo:nil];
    }
}

+ (void)addPatient:(Patient *)pat forDoctor:(Doctor *)doc{
    if (!pat || !doc) {
        @throw [[NSException alloc] initWithName:kGenericError reason:@"error" userInfo:nil];
    }else{
        PFObject *parse = [PFObject objectWithClassName:@"Patient"];
        parse[@"name"] = pat.name;
        parse[@"lastName"] = pat.lastName;
        NSError *error;
        [parse save:&error];
        pat.identifier = parse.objectId;
        NSLog(@"new patient added %@", pat.identifier);
        [doc.patients setObject:pat forKey:pat.identifier];
    }
}


@end

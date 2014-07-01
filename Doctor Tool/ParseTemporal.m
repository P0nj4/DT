//
//  ParseTemporal.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "ParseTemporal.h"
#import <Parse/Parse.h>

@implementation ParseTemporal


+ (void)saveExample{
   
    /*
    PFObject *doctor = [PFObject objectWithClassName:@"Doctor"];
    doctor.objectId = @"8FBlgsQzTq";
    //[doctor setObject:@"prueba" forKey:@"name"];
    //[doctor setObject:@"ape" forKey:@"lastName"];
    //[doctor setObject:@"email" forKey:@"email"];
    //[doctor setObject:@"password" forKey:@"password"];
    
    PFObject *patient = [PFObject objectWithClassName:@"Patient"];
    [patient setObject:@"asdasdas" forKey:@"name"];
    [patient setObject:@"asdasd" forKey:@"lastName"];
    [patient setObject:doctor forKey:@"Doctor"];

    [patient saveInBackground];*/
    
    PFObject *doctor = [PFObject objectWithClassName:@"Doctor"];
    doctor.objectId = @"uuSwHNdO7W";
    PFObject *patient = [PFObject objectWithClassName:@"Patient"];
    patient.objectId = @"SXRTzE8JNZ";
    
    PFObject *consultation = [PFObject objectWithClassName:@"Consultation"];
    [consultation setObject:@"consulta 2 " forKey:@"notes"];
    [consultation setObject:@5 forKey:@"rating"];
    [consultation setObject:doctor forKey:@"Doctor"];
    [consultation setObject:patient forKey:@"Patient"];
    
    [consultation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"error %@", error);
        }
    }];
    
}

+ (void)loadExample{
    PFQuery *query = [PFQuery queryWithClassName:@"Consultation"];
    [query whereKey:@"objectId" equalTo:@"27ZR6lfqKy"];
    [query includeKey:@"Doctor"];
    [query includeKey:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects %@", [[[objects objectAtIndex:0] objectForKey:@"Patient"] objectForKey:@"name"]);
    }];
}

+ (void)loadConsultationsByDoctor{
    PFQuery *query = [PFQuery queryWithClassName:@"Consultation"];
    PFQuery *innerQuery = [PFQuery queryWithClassName:@"Doctor"];
    [innerQuery whereKey:@"objectId" equalTo:@"8FBlgsQzTq"];
    [query includeKey:@"Doctor"];
    [query includeKey:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *obj in objects) {
            NSString *notes = [obj objectForKey:@"notes"];
            NSLog(@"%@", notes);
        }
    }];
}
@end

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

    [patient saveInBackground];
}

+ (void)loadExample{
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"objectId" equalTo:@"NdJr6xMWRl"];
    [query includeKey:@"Doctor"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects %@", [[[objects objectAtIndex:0] objectForKey:@"Doctor"] objectForKey:@"name"]);
    }];
}
@end

//
//  Consultation.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Consultation.h"

@implementation Consultation

@synthesize identifier, notes, date, doctor, done, medicaments, patient, rating;

- (id)initWithParse:(PFObject *)object error:(NSError **)error{
    self = [super init];
    if (self) {
        if (![object objectForKey:@"date"]) {
            *error = [NSError errorWithDomain:@"wrongPatient" code:200 userInfo:nil];
            return self;
        }
        self.identifier = object.objectId;
        self.notes = [object objectForKey:@"notes"];
        self.date = [object objectForKey:@"date"];
        self.done = [[object objectForKey:@"done"] boolValue];
        self.rating = [[object objectForKey:@"rating"] integerValue];
        
    }
    return self;
}

- (id)initWithDate:(NSDate *)pdate forPatient:(Patient *)ppatient forDoctor:(Doctor *)pdoctor withNotes:(NSString *)pnotes{
    self = [super init];
    if (self) {
        self.date = pdate;
        self.notes = pnotes;
        self.patient = ppatient;
        self.doctor = pdoctor;
    }
    return self;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"id:%@ notes:%@ date:%@ rating:%li", self.identifier, self.notes, self.date, (long)self.rating];
}
@end

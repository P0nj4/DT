//
//  ConsultationModel.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "ConsultationModel.h"
#import "Doctor.h"
#import "Patient.h"
#import "Consultation.h"


@implementation ConsultationModel

+ (void)loadConsultationsOfDoctor:(Doctor *)doc pendingsOnly:(BOOL)pendings{
    if (!doc.consultations) {
        doc.consultations = [[NSMutableDictionary alloc] init];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Consultation"];
    PFQuery *innerQuery = [PFQuery queryWithClassName:@"Doctor"];
    [innerQuery whereKey:@"objectId" equalTo:doc.identifier];
    [query includeKey:@"Patient"];
    if (pendings) {
        [query whereKey:@"date" greaterThan:[NSDate date]];
    }
    
    Consultation *consultation = nil;
    NSArray *objects = [query findObjects];
    
    for (PFObject *obj in objects) {
        PFObject *ppatient = [obj objectForKey:@"Patient"];
        PFObject *pconultation = obj;
        NSError *err;
        if (![doc.patients objectForKey:ppatient.objectId]) {
            Patient *patient = [[Patient alloc] initWithParse:ppatient error:&err];
            if (!err) {
                [doc.patients setObject:patient forKey:patient.identifier];
            }
        }
        consultation = [[Consultation alloc] initWithParse:pconultation error:&err];
        consultation.patient = [doc.patients objectForKey:ppatient.objectId];
        [doc.consultations setObject:consultation forKey:consultation.identifier];
    }
}


+ (void)addConsultation:(Consultation *)cons forDoctor:(Doctor *)doc andPatient:(Patient *)pat{
    PFObject *doctor = [PFObject objectWithClassName:@"Doctor"];
    doctor.objectId = doc.identifier;
    PFObject *patient = [PFObject objectWithClassName:@"Patient"];
    patient.objectId = pat.identifier;
    
    PFObject *consultation = [PFObject objectWithClassName:@"Consultation"];
    [consultation setObject:cons.notes forKey:@"notes"];
    [consultation setObject:[NSNumber numberWithBool:cons.done] forKey:@"done"];
    [consultation setObject:cons.date forKey:@"date"];
    [consultation setObject:[NSNumber numberWithInteger:cons.rating] forKey:@"rating"];
    NSError *err;
    [consultation save:&err];
    
    if (!err) {
        cons.identifier = consultation.objectId;
        [doc.consultations setObject:cons forKey:cons.identifier];
    }else{
        @throw [[NSException alloc] initWithName:kGenericError reason:err.description userInfo:nil];
    }
}



@end

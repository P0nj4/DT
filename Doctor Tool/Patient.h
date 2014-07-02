//
//  Patient.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 02/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Consultation, Doctor;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * lastConsultation;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSSet *doctor;
@property (nonatomic, retain) NSSet *consultations;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addDoctorObject:(Doctor *)value;
- (void)removeDoctorObject:(Doctor *)value;
- (void)addDoctor:(NSSet *)values;
- (void)removeDoctor:(NSSet *)values;

- (void)addConsultationsObject:(Consultation *)value;
- (void)removeConsultationsObject:(Consultation *)value;
- (void)addConsultations:(NSSet *)values;
- (void)removeConsultations:(NSSet *)values;

@end

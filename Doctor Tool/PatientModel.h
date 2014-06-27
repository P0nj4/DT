//
//  PatientModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonModel.h"

@class Patient, Doctor;

@interface PatientModel : CommonModel
+ (void)loadDoctorPatients:(Doctor *)doc;
+ (void)addPatient:(Patient *)pat forDoctor:(Doctor *)doc;
@end

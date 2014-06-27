//
//  ConsultationModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonModel.h"

@class Doctor, Consultation, Patient;

@interface ConsultationModel : CommonModel
- (void)loadConsultationsOfDoctor:(Doctor *)doc pendingsOnly:(BOOL)pendings;
- (void)addConsultation:(Consultation *)cons forDoctor:(Doctor *)doc andPatient:(Patient *)pat;
@end

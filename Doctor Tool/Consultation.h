//
//  Consultation.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Patient.h"

@interface Consultation : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) Doctor *doctor;
@property (nonatomic, weak) Patient *patient;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) BOOL done;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSMutableArray *medicaments;
@end

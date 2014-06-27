//
//  UserModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonModel.h"

@class Doctor;

@interface DoctorModel : CommonModel
+ (void)loginDoctor:(NSString *)email password:(NSString *)pass;
+ (void)registerDoctor:(Doctor *)u;
+ (NSMutableArray *)getAllUsers;
@end

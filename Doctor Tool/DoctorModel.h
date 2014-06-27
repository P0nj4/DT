//
//  UserModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Doctor;

@interface DoctorModel : NSObject
+ (Doctor *)loginUser:(NSString *)userName password:(NSString *)pass;
+ (void)registerUser:(Doctor *)u;
+ (NSMutableArray *)getAllUsers;
@end

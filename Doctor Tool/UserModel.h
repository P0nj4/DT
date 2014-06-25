//
//  UserModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserModel : NSObject
+ (User *)loginUser:(NSString *)userName password:(NSString *)pass;
+ (void)registerUser:(User *)u;
+ (NSMutableArray *)getAllUsers;
@end

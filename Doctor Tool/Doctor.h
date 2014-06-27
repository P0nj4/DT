//
//  User.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef enum {Doctor, Admin, Other} Role;

@interface Doctor : NSObject
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) UIImage *avatar;
//@property (nonatomic, assign) Role role;
@end

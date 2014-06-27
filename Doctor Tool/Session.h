//
//  Session.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Doctor;

@interface Session : NSObject

+ (Session *)sharedInstance;

@property (nonatomic, strong) Doctor *doctor;

@end

//
//  Patient.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Patient : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSDate *lastConsultation;
@property (nonatomic, strong) NSDate *createdAt;

- (id)initWithParse:(PFObject *)object error:(NSError **)error;
- (id)initWithName:(NSString *)pname lastName:(NSString *)plastName;
@end

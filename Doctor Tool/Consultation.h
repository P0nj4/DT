//
//  Consultation.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Consultation : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) BOOL done;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSMutableArray *medicaments;
@end

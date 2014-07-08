//
//  Entities.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 08/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//
#define kGenericError @"genericError"

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FMDatabase.h"

@protocol Entities <NSObject>
- (void)loadMe;
- (void)saveMe;
- (void)updateMe;
+ (NSMutableDictionary *)getAll;
+ (NSMutableDictionary *)getAllWithParent:(id)parent;
@end

//
//  Consultation.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 02/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Consultation : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) Patient *patient;

@end

//
//  Doctor.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 02/07/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Doctor : NSManagedObject

@property (nonatomic, retain) NSData * avatar;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *patients;
@end

@interface Doctor (CoreDataGeneratedAccessors)

- (void)addPatientsObject:(Patient *)value;
- (void)removePatientsObject:(Patient *)value;
- (void)addPatients:(NSSet *)values;
- (void)removePatients:(NSSet *)values;

@end

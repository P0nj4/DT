//
//  User.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//typedef enum {Doctor, Admin, Other} Role;

@interface Doctor : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSManagedObjectID* identifier;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSMutableDictionary *patients;
@property (nonatomic, strong) NSMutableDictionary *consultations;
//@property (nonatomic, assign) Role role;


- (id)initWithObject:(NSManagedObject *)object error:(NSError **)error;
- (id)initWithEmail:(NSString *)pemail name:(NSString *)pname lastName:(NSString *)plastName avatar:(UIImage *)pavatar;
- (NSManagedObject *)updateToDatabase:(NSManagedObjectContext *)context managedObject:(NSManagedObject*)object;
- (NSManagedObject *)convertToDatabase:(NSManagedObjectContext *)context;
@end

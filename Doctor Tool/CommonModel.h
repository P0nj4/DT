//
//  CommonModel.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CommonValidations.h"

#define kGenericError @"genericError"

@interface CommonModel : NSObject{
    // there is an implied @protected directive here
    NSManagedObjectContext *managedObjectContext;
}



@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSMutableArray *)getAll;
- (void)save:(id)object;
- (void)update:(id)object;

@end

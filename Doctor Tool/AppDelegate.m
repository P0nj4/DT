//
//  AppDelegate.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "FirstTimeStartingVC.h"


#import "PatientsVC.h"
#import "ParseTemporal.h"

#import "ConsultationsVC.h"
#import "Doctor.h"
#import "Patient.h"
#import "Consultation.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[Parse setApplicationId:@"6xGlxQ1JEvmYddqlk7DTYwdhMpTZo0lWYqCucgKB"                   clientKey:@"UJRJBoOibEEbPDQfY8hiTfONy3mEx1Y3oOrKdWrH"];
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    
    //UIViewController *viewController = [[FirstTimeStartingVC alloc] initWithNibName:@"FirstTimeStartingVC" bundle:nil];
    UIViewController *viewController = [[PatientsVC alloc] initWithNibName:@"PatientsVC" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:viewController];
    navController.navigationBar.opaque = YES;
    navController.navigationBar.translucent = NO;
    
    
    
    [self setExampleData];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setExampleData{
    NSArray *arr = [self getAllDoctors];
    if ([arr count] == 0) {
        
        Doctor * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor"
                                                          inManagedObjectContext:self.managedObjectContext];
        newEntry.name = @"pepe";
        newEntry.lastName = @"triaz";
        newEntry.password = @"1234";
        newEntry.email = @"pepe@gmail.com";
        newEntry.deleted = NO;
        newEntry.createdAt = [NSDate date];
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [Session sharedInstance].doctor = newEntry;
    }else{
        [Session sharedInstance].doctor = [arr objectAtIndex:0];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm"];
    
    for (Doctor *doc in arr) {
        NSLog(@"Doctor: %@", doc.description);
        if ([doc.patients count] > 0) {
            for (Patient *pat in [doc patients]) {
                NSLog(@"   Patient: %@", pat.description);
                if ([[pat consultations] count] > 0) {
                    for (Consultation *con in [pat consultations]) {
                        NSLog(@"      Consultation: %@", con.description);
                    }
                }
            }
        }else{
            NSMutableArray *patients = [[NSMutableArray alloc] init];
            for (int i = 0; i < 10; i++) {
                Patient *pat1 = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                              inManagedObjectContext:self.managedObjectContext];
                pat1.createdAt = [NSDate date];
                pat1.lastConsultation = [NSDate date];
                pat1.deleted = NO;
                pat1.name = [NSString stringWithFormat:@"paciente %i", i];
                pat1.lastName = [NSString stringWithFormat:@"apellido %i", i];
                [patients addObject:pat1];
                
                for (int j = 0; j < 10; j++) {
                    /*
                     @property (nonatomic, retain) NSDate * date;
                     @property (nonatomic, retain) NSNumber * done;
                     @property (nonatomic, retain) NSString * notes;
                     @property (nonatomic, retain) NSNumber * rating;
                     @property (nonatomic, retain) NSDate * createdAt;
                     @property (nonatomic, retain) Patient *patient;
                     */
                    Consultation *consultationAux = [NSEntityDescription insertNewObjectForEntityForName:@"Consultation"
                                                                                  inManagedObjectContext:self.managedObjectContext];
                    consultationAux.createdAt = [NSDate date];
                    
                    NSString *daystr = (j < 9 ? [NSString stringWithFormat:@"0%i", j+1] : [NSString stringWithFormat:@"%i", j+1]);
                    NSString *Hourstr = (j < 10 ? [NSString stringWithFormat:@"0%i", j] : [NSString stringWithFormat:@"%i", j]);
                    NSString *Minstr = (j % 3 ? @"15" : (j % 2 ? @"30" : @"00"));
                    
                    NSString *dateString = [NSString stringWithFormat:@"%@-07-2014 %@:%@", daystr, Hourstr, Minstr];
                    NSLog(@"%@", dateString);
                    consultationAux.date = [formatter dateFromString:dateString];
                    consultationAux.notes = [NSString stringWithFormat:@"notas %i", i];
                    consultationAux.rating = [NSNumber numberWithInt:i];
                    consultationAux.patient = pat1;
                }
            }
            doc.patients = [NSSet setWithArray:patients];
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }

        }
        
    }
}

- (void)addDoctor{
    // Add Entry to PhoneBook Data base and reset all fields
    
    //  1
    Doctor * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.name = @"pepe";
    newEntry.lastName = @"triaz";
    newEntry.password = @"";
    
    //  6
    Patient *pat1 = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                               inManagedObjectContext:self.managedObjectContext];
    pat1.name = @"paciente ";
    pat1.lastName = @"ejemplo 1";
    
    //  7
    Patient *pat2 = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                  inManagedObjectContext:self.managedObjectContext];
    
    pat1.name = @"paciente 2";
    pat1.lastName = @"ejemplo 2";
    
    //  8
    newEntry.patients = [NSSet setWithObjects:pat1 ,pat2, nil];
    
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
   

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"DoctorTool.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


-(NSArray*)getAllDoctors
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Doctor"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

@end

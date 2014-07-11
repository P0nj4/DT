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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //[Parse setApplicationId:@"6xGlxQ1JEvmYddqlk7DTYwdhMpTZo0lWYqCucgKB"                   clientKey:@"UJRJBoOibEEbPDQfY8hiTfONy3mEx1Y3oOrKdWrH"];
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    [self initializeDB];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"HasRun"]){
        [self exampleDataSet];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"HasRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [Session sharedInstance].doctor = [[Doctor alloc] init];
    [Session sharedInstance].doctor.identifier = 1;
    [[Session sharedInstance].doctor loadMe];
    
    UIViewController *viewController = [[PatientsVC alloc] initWithNibName:@"PatientsVC" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:viewController];
    navController.navigationBar.opaque = YES;
    navController.navigationBar.translucent = NO;

    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)exampleDataSet{
    Doctor *doc = [[Doctor alloc] initWithName:@"Germán" lastName:@"Pereyra" email:@"germanp@gmail.com" password:@"0000" avatar:nil];
    [doc saveMe];
    
    for (int i =0; i < 5; i++) {
        NSString *name;
        NSString *lastName;
        switch (i) {
            case 0:
                name = @"pepe";
                lastName = @"pepe";
                break;
            case 1:
                name = @"Rodígo";
                lastName = @"Herrera";
                break;
            case 2:
                name = @"Jorge";
                lastName = @"Pereyra";
                break;
            case 3:
                name = @"Antoño";
                lastName = @"Perez";
                break;
            case 4:
                name = @"Mirian";
                lastName = @"Rodíguez";
                break;
            default:
                name = @"123";
                lastName = @"321";
                break;
        }
        
        Patient *p = [[Patient alloc] initWithName:name lastName:lastName doctor:doc];
        [p saveMe];
    }
    
    Patient *paux = [[Patient alloc] init];
    paux.identifier = 1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    for (int i = 0; i < 23; i++) {
        NSString *strDate = [NSString stringWithFormat:@"2014-07-%@ ", (i > 9 ? [NSString stringWithFormat:@"%li", (long)i]: [NSString stringWithFormat:@"0%li", (long)i+1])];
        NSString *strHour = (i > 9 ? [NSString stringWithFormat:@"%li",(long)i] : [NSString stringWithFormat:@"0%li", (long)i]);
        NSString *strMins = (i % 3 ? @"15" : (i % 2 ? @"30" : @"00"));
        strDate = [strDate stringByAppendingString:[NSString stringWithFormat:@"%@:%@", strHour, strMins]];
        
        Consultation *consAux = [[Consultation alloc] initWithRating:0 notes:[NSString stringWithFormat:@"Notas_%i", i] date:[formatter dateFromString:strDate] patient:paux];
        [consAux saveMe];
    }

}

- (void)initializeDB{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString* path = nil;
    NSString* content = nil;
    for (int i = 0; i < 3; i++) {
        NSString *tableName = nil;
        
        switch (i) {
            case 0:
                tableName = @"Doctors";
                break;
            case 1:
                tableName = @"Patients";
                break;
            case 2:
                tableName = @"Consultations";
                break;
            default:
                break;
        }
        path = [[NSBundle mainBundle] pathForResource:tableName ofType:@"sql"];
        content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        [database executeUpdate:content];
    }
    
    [database close];
}

- (void)SCHEME{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT name, sql FROM sqlite_master WHERE type='table' ORDER BY name", [NSNumber numberWithBool:NO], nil];
    while([results next]) {

        NSLog(@"%@",[results stringForColumn:@"name"]);
        NSLog(@"%@",[results stringForColumn:@"sql"]);
    }
    [database close];
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




@end

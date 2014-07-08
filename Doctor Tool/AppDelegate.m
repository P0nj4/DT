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
   
    
    
    //UIViewController *viewController = [[FirstTimeStartingVC alloc] initWithNibName:@"FirstTimeStartingVC" bundle:nil];
    UIViewController *viewController = [[PatientsVC alloc] initWithNibName:@"PatientsVC" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:viewController];
    navController.navigationBar.opaque = YES;
    navController.navigationBar.translucent = NO;
    
    [self initializeDB];
    
  
    Doctor *doc = [[Doctor alloc] initWithName:@"german" lastName:@"pereyra" email:@"german.f.pereyra@gmail.com" password:@"1234" avatar:nil];
    [doc saveMe];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)initializeDB{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"DTDatabase.sqlite"];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"SQL"
                                                     ofType:@"sql"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSLog(@"%@",content);
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:content];
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

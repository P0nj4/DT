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
#import "DoctorModel.h"
#import "PatientModel.h"
#import "ConsultationsVC.h"
#import "Doctor.h"
#import "Patient.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"6xGlxQ1JEvmYddqlk7DTYwdhMpTZo0lWYqCucgKB"
                  clientKey:@"UJRJBoOibEEbPDQfY8hiTfONy3mEx1Y3oOrKdWrH"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    [DoctorModel loginDoctor:@"german.f.pereyra@gmail.com" password:@"123456"];
    
    //UIViewController *viewController = [[FirstTimeStartingVC alloc] initWithNibName:@"FirstTimeStartingVC" bundle:nil];
    UIViewController *viewController = [[ConsultationsVC alloc] initWithNibName:@"ConsultationsVC" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:viewController];
    
    
    //Doctor *d = [[Doctor alloc] initWithEmail:@"german.f.pereyra@gmail.com" password:@"123456" name:@"Germán" lastName:@"Pereyra" avatar:nil];
    //[DoctorModel registerDoctor:d];
//    
//    [DoctorModel loginDoctor:@"german.f.pereyra@gmail.com" password:@"123456"];
//    
//    Patient *newPatient = [[Patient alloc] initWithName:@"segundo paciente" lastName:@"lalalala"];
//    [PatientModel addPatient:newPatient forDoctor:[Session sharedInstance].doctor];
    NSLog(@"session doctor %@", [Session sharedInstance].doctor);
    
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
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

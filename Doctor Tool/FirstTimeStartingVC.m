//
//  FirstTimeStartingVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "FirstTimeStartingVC.h"

@interface FirstTimeStartingVC ()

@end

@implementation FirstTimeStartingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

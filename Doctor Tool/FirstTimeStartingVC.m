//
//  FirstTimeStartingVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "FirstTimeStartingVC.h"
#import "CardView.h"
#import "LoginView.h"
#import "SignUpView.h"

@interface FirstTimeStartingVC () <CardViewDelegate>
@property (nonatomic, strong) CardView *cardView;


- (IBAction)btnSignUpPressed:(id)sender;
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
    
    LoginView *login = [[LoginView alloc] init];
    SignUpView *signUp = [[SignUpView alloc] init];
    CardView *cv = [[CardView alloc] initWithFrontView:login backView:signUp Frame:signUp.frame withGesture:YES];
    self.cardView = cv;
    cv.useBackground = YES;
    cv.delegate = self;
    cv.center = self.view.center;
    self.cardView.alpha = 0;
    [[self view] addSubview:self.cardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)CardFliped:(BOOL)isFlipped{
}

- (IBAction)btnSignUpPressed:(id)sender {
    
    self.cardView.alpha = 1;
    self.cardView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        self.cardView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.cardView.transform = CGAffineTransformMakeScale(1., 1.);
        }];
    }];
}
@end

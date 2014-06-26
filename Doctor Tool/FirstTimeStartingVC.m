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

@interface FirstTimeStartingVC () <CardViewDelegate, LoginViewDelegate, SignUpViewDelegate>
@property (nonatomic, strong) CardView *cardView;
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) CardView *cv;

- (IBAction)btnSignUpPressed:(id)sender;
@end

@implementation FirstTimeStartingVC
@synthesize viewBG, cv;
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
    
    LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, 400, 428)];
    login.delegate = self;
    SignUpView *signUp = [[SignUpView alloc] initWithFrame:CGRectMake(0, 0, 400, 428)];
    signUp.delegate = self;

    viewBG = [[UIView alloc] initWithFrame:self.view.bounds];
    viewBG.backgroundColor = [UIColor blackColor];
    viewBG.alpha = 0;
    [self.view addSubview:viewBG];
    
    cv = [[CardView alloc] initWithFrontView:login backView:signUp Frame:CGRectMake(0, 0, 400, 428) withGesture:YES];
    self.cardView = cv;
    cv.useBackground = NO;
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

#pragma mark - CardViewDelegate

- (void)CardFliped:(BOOL)isFlipped{
    self.isLogin = !self.isLogin;
}

#pragma mark - LoginViewDelegate & SignUpViewDelegate
- (void)loginButtonPressed{
    if (!self.isLogin) {
        [self.cv flip];
    }
}

- (void)registerButtonPressed{
    if (self.isLogin) {
        [self.cv flip];
    }
}

- (void)loginWithFacebookButtonPressed{

}

- (void)loginWithGoogleButtonPressed{

}



#pragma mark - IBActions
- (IBAction)btnSignUpPressed:(id)sender {
    self.cardView.alpha = 1;
    self.cardView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        viewBG.alpha = 0.3;
        self.cardView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.cardView.transform = CGAffineTransformMakeScale(1., 1.);
        }];
    }];
}



@end

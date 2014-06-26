//
//  LoginView.h
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@protocol LoginViewDelegate <NSObject>

- (void)registerButtonPressed:(User *)usr;
- (void)loginButtonPressed:(User *)usr;
- (void)loginWithFacebookButtonPressed;
- (void)loginWithGoogleButtonPressed;
- (void)dismissCard;

@end

@interface LoginView : UIView
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnLoginWithGoogle;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginWithFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)btnGooglePressed:(id)sender;
- (IBAction)btnFacebookPressed:(id)sender;
- (IBAction)btnLoginPressed:(id)sender;
- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;

@end

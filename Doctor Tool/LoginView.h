//
//  LoginView.h
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)registerButtonPressed;
- (void)loginButtonPressed;
- (void)loginWithFacebookButtonPressed;
- (void)loginWithGoogleButtonPressed;

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

- (IBAction)btnGooglePressed:(id)sender;
- (IBAction)btnFacebookPressed:(id)sender;
- (IBAction)btnLoginPressed:(id)sender;
- (IBAction)btnRegisterPressed:(id)sender;

@end

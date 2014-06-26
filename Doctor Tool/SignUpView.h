//
//  SignUpView.h
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignUpViewDelegate <NSObject>

- (void)registerButtonPressed;
- (void)loginButtonPressed;

@end

@interface SignUpView : UIView
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, weak) id<SignUpViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnLoginPressed:(id)sender;
@end

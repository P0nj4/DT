//
//  SignUpView.h
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@protocol SignUpViewDelegate <NSObject>

- (void)registerButtonPressed:(User *)usr;
- (void)loginButtonPressed:(User *)usr;
- (void)dismissCard;
- (void)takePhoto:(User *)usr;

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
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnLoginPressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;
- (IBAction)btnAddImagePressed:(id)sender;

@end

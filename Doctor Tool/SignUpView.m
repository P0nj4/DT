//
//  SignUpView.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "SignUpView.h"
#import "User.h"

@interface SignUpView ()
@property (nonatomic, strong) User *usr;
@end

@implementation SignUpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{
    [[NSBundle mainBundle] loadNibNamed:@"SignUpView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.layer.borderWidth = 5;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
}


- (IBAction)btnRegisterPressed:(id)sender {
    if (!self.usr) {
        self.usr = [[User alloc] init];
    }
    
    self.usr.email = self.txtEmail.text;
    self.usr.name = self.txtName.text;
    self.usr.password = self.txtPassword.text;
    self.usr.lastName = self.txtLastName.text;
    
    if([self.delegate respondsToSelector:@selector(registerButtonPressed:)]){
        [self.delegate registerButtonPressed:self.usr];
    }
}

- (IBAction)btnLoginPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(loginButtonPressed:)]){
        [self.delegate loginButtonPressed:nil];
    }
}

- (IBAction)btnCancelPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dismissCard)]) {
        [self.delegate dismissCard];
    }
}
@end

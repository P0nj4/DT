//
//  LoginView.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "LoginView.h"
#import "Doctor.h"

@interface LoginView ()
@property (nonatomic, strong) Doctor *usr;
@end


@implementation LoginView

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
    [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.layer.borderWidth = 5;
    self.view.layer.cornerRadius = 4;
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
}


- (IBAction)btnGooglePressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(loginWithGoogleButtonPressed)]){
        [self.delegate loginWithGoogleButtonPressed];
    }
}

- (IBAction)btnFacebookPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(loginWithFacebookButtonPressed)]){
        [self.delegate loginWithFacebookButtonPressed];
    }
}

- (IBAction)btnLoginPressed:(id)sender {
    if (!self.usr) {
        self.usr = [[Doctor alloc] init];
    }
    self.usr.email = self.txtEmail.text;

    if([self.delegate respondsToSelector:@selector(loginButtonPressed:)]){
        [self.delegate loginButtonPressed:self.usr];
    }

}

- (IBAction)btnRegisterPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(registerButtonPressed:)]){
        [self.delegate registerButtonPressed:nil];
    }
}


- (IBAction)btnCancelPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dismissCard)]) {
        [self.delegate dismissCard];
    }
}

@end

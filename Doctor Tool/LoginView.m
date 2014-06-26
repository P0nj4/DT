//
//  LoginView.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()


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
    if([self.delegate respondsToSelector:@selector(loginButtonPressed)]){
        [self.delegate loginButtonPressed];
    }

}

- (IBAction)btnRegisterPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(registerButtonPressed)]){
        [self.delegate registerButtonPressed];
    }
}

@end

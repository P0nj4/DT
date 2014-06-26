//
//  SignUpView.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "SignUpView.h"

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
}


- (IBAction)btnRegisterPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(registerButtonPressed)]){
        [self.delegate registerButtonPressed];
    }
}

- (IBAction)btnLoginPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(loginButtonPressed)]){
        [self.delegate loginButtonPressed];
    }
}
@end

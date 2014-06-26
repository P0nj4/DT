//
//  LoginView.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "LoginView.h"

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


@end

//
//  Session.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Session.h"

static Session *sharedSession = nil;

@implementation Session


+ (Session *)sharedInstance {
    @synchronized(self) {
        if (sharedSession == nil) {
            sharedSession = [[self alloc] init]; // assignment not done here
        }
    }
    return sharedSession;
}

@end



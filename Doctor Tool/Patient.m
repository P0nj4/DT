//
//  Patient.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 27/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "Patient.h"


@implementation Patient

- (id)initWithParse:(PFObject *)object error:(NSError **)error{
    self = [super init];
    if (self) {
        if (![object objectForKey:@"objectId"] || [object objectForKey:@"name"] || [object objectForKey:@"lastName"]) {
            *error = [NSError errorWithDomain:@"wrongPatient" code:200 userInfo:nil];
            return self;
        }
        self.identifier = [object objectForKey:@"objectId"];
        self.name = [object objectForKey:@"name"];
        self.lastName = [object objectForKey:@"lastName"];
    }
    return self;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"id:%@ name:%@ lastName:%@", self.identifier, self.name, self.lastName];
}
@end

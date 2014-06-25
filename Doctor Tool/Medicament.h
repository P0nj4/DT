//
//  Medicament.h
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Medicament : NSObject
@property (nonatomic, assign) NSInteger *count;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notes;
@end

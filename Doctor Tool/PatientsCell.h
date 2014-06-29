//
//  PatientsCell.h
//  Doctor Tool
//
//  Created by German Pereyra on 6/29/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "XIBBasedTableCell.h"

@interface PatientsCell : XIBBasedTableCell
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UILabel *lblLastConsultation;
@property (nonatomic, weak) IBOutlet UILabel *lblCreatedAt;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;

@end

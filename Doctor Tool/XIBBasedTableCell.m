//
//  XIBBasedTableCell.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/29/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "XIBBasedTableCell.h"

@implementation XIBBasedTableCell

+ (XIBBasedTableCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    XIBBasedTableCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[XIBBasedTableCell class]]) {
            xibBasedCell = (XIBBasedTableCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ConsultationHoursVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/29/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "ConsultationHoursVC.h"

@interface ConsultationHoursVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ConsultationHoursVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}



- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor whiteColor];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.2;
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section > 9) {
        return [NSString stringWithFormat:@"%li:00", (long)section];
    }else{
        return [NSString stringWithFormat:@"0%li:00", (long)section];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"hourlyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section > 9) {
        cell.textLabel.text = [NSString stringWithFormat:@"0%li:", (long)indexPath.section];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%li:", (long)indexPath.section];
    }
    
    
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:(indexPath.row * 15 == 0 ? @"00" : [NSString stringWithFormat:@"%i", indexPath.row * 15])];
    return cell;
}
@end

//
//  ConsultationHoursVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/29/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "ConsultationHoursVC.h"
#import "Consultation.h"
#import "Patient.h"
#import "NSDate+CommonDateFunctions.h"


@interface ConsultationHoursVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *dic;
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
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *strDate = nil;
    
    NSMutableDictionary *dicOfConlsultationsForTheCurrentDate = [Consultation getAllStaringDate:self.currentDate endingDate:[[self.currentDate dateByAddingDays:1] dateBySubstractingMinutes:1]];
    
    self.dic = [[NSMutableDictionary alloc] initWithCapacity:dicOfConlsultationsForTheCurrentDate.count];
    
    for (Consultation *cons in dicOfConlsultationsForTheCurrentDate) {
        [cons.patient loadMe];
        strDate = [formatter stringFromDate:cons.date];
        [self.dic setObject:cons forKey:strDate];
    }
    NSLog(@"%@",self.dic);
    
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
    if (indexPath.section < 10) {
        cell.textLabel.text = [NSString stringWithFormat:@"0%li:", (long)indexPath.section];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%li:", (long)indexPath.section];
    }
    
    cell.textLabel.text = [cell.textLabel.text stringByAppendingString:(indexPath.row * 15 == 0 ? @"00" : [NSString stringWithFormat:@"%i", indexPath.row * 15])];

    if ([self.dic objectForKey:cell.textLabel.text]) {
        Consultation *consAux = [self.dic objectForKey:cell.textLabel.text];
        cell.textLabel.text = [cell.textLabel.text stringByAppendingString:[NSString stringWithFormat:@" - %@ %@", [Session sharedInstance].patient.name, [Session sharedInstance].patient.lastName]];
    }

    return cell;
}
@end

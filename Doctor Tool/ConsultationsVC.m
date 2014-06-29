//
//  ConsultationsVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/26/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "ConsultationsVC.h"
#import "VRGCalendarView.h"
#import "NSDate+convenience.h"

@interface ConsultationsVC () <VRGCalendarViewDelegate>

@end

@implementation ConsultationsVC

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
    VRGCalendarView *calendar = [[VRGCalendarView alloc] initWithFrame:CGRectMake(100, 70, 580, 40)];
    calendar.delegate=self;
    [self.view addSubview:calendar];
    calendar.layer.cornerRadius = 8;

}


-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        //NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        //[calendarView markDates:dates];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MM/yyyy"];
        NSDate *formatedDate = [format dateFromString:@"24/06/2014"];
        NSArray *date = [NSArray arrayWithObjects:formatedDate, nil];
        NSArray *color = [NSArray arrayWithObjects:[UIColor yellowColor],nil];
        [calendarView markDates:date withColors:color];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

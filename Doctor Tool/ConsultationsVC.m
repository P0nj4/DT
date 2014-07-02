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
#import "ConsultationHoursVC.h"

#import "Doctor.h"
#import "Consultation.h"

@interface ConsultationsVC () <VRGCalendarViewDelegate>
@property (nonatomic, strong) NSArray *allConsultations;
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
    VRGCalendarView *calendar = [[VRGCalendarView alloc] initWithFrame:CGRectMake(10, 5, 748, 40)];
    calendar.delegate=self;
    [self.view addSubview:calendar];
    calendar.layer.cornerRadius = 8;
    
    //[ConsultationModel loadConsultationsOfDoctor:[Session sharedInstance].doctor pendingsOnly:YES];

    Consultation *Consu1 = [[Consultation alloc] init];
    Consu1.date = [NSDate date];
    
    Consultation *Consu2 = [[Consultation alloc] init];
    NSDate *now = [NSDate date];
    int daysToAdd = -1;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    Consu2.date = newDate1;
    
    
    
//    NSArray *notSorted = [[Session sharedInstance].doctor.consultations allValues];
 //   NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
 //   self.allConsultations = [notSorted sortedArrayUsingDescriptors:@[sortDescriptor]];
    
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
        
        NSDate *curDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
        
        // set last of month
        [comps setMonth:[comps month]+1];
        [comps setDay:0];
        NSDate *tDateMonth = [calendar dateFromComponents:comps];
        NSLog(@"%@", tDateMonth);
        
        [comps setMonth:[comps month]-1];
        [comps setDay:0];
        NSDate *tDateMonth1 = [calendar dateFromComponents:comps];
        NSLog(@"%@", tDateMonth);
        
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date <= %@)", tDateMonth1, tDateMonth];
        NSArray *dates = [self.allConsultations filteredArrayUsingPredicate:predicate];
        
        NSMutableArray *filteredDAtes = [[NSMutableArray alloc] initWithCapacity:dates.count];
        for (Consultation *cons in dates) {
            [filteredDAtes addObject:cons.date];
        }
        
        [calendarView markDates:filteredDAtes withColors:color];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    [self.navigationController pushViewController:[[ConsultationHoursVC alloc] initWithNibName:@"ConsultationHoursVC" bundle:[NSBundle mainBundle]] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PatientsVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/26/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "PatientsVC.h"
#import "Doctor.h"
#import "PatientModel.h"
#import "LoadingView.h"
#import "Patient.h"
#import "PatientsCell.h"


@interface PatientsVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblPatients;
@property (nonatomic, strong) NSArray *patientsArray;
@end

@implementation PatientsVC

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
    if ([Session sharedInstance].doctor.patients.count == 0) {
        [LoadingView loadingShowOnView:self.view animated:NO frame:self.view.bounds];
        dispatch_queue_t queue = dispatch_queue_create("q_loadPatients", NULL);
        dispatch_async(queue, ^{
            [PatientModel loadDoctorPatients:[Session sharedInstance].doctor];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.patientsArray = [[Session sharedInstance].doctor.patients allValues];
                [LoadingView loadingHideOnView:self.view animated:YES];
                [self.tblPatients reloadData];
            });
        });
    }else{
        self.patientsArray = [[Session sharedInstance].doctor.patients allValues];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [Session sharedInstance].doctor.patients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TableCellWithNumberCellIdentifier";
    
    PatientsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (PatientsCell *)[PatientsCell cellFromNibNamed:@"PatientsCell"];
    }
    
    Patient *patient = [self.patientsArray objectAtIndex:indexPath.row];
    
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@", patient.name, patient.lastName];
    NSString *lastConsultation = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd, MMM yyyy"];
    if (patient.lastConsultation) {
        lastConsultation = [formatter stringFromDate:patient.lastConsultation];
    }else{
        lastConsultation = NSLocalizedString(@"lastConsultationNeverHad", nil);
    }
    
    cell.lblLastConsultation.text = [NSLocalizedString(@"lastConsultation", nil) stringByAppendingString:lastConsultation];
    cell.lblCreatedAt.text  = [NSLocalizedString(@"patientRegisteredAt", nil) stringByAppendingString:[formatter stringFromDate:patient.createdAt]];
     
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end

//
//  PatientsVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/26/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "PatientsVC.h"
#import "Doctor.h"

#import "LoadingView.h"
#import "Patient.h"
#import "PatientsCell.h"
#import "ConsultationsVC.h"


@interface PatientsVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblPatients;
@property (nonatomic, strong) NSArray *patientsArray;
@property (nonatomic, weak) Patient *selectedPatient;
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
    NSArray *patientsArrayAux = [[Patient getAllWithParent:[Session sharedInstance].doctor] allValues];
    self.patientsArray = [patientsArrayAux sortedArrayUsingSelector:@selector(compareTo:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.patientsArray.count;
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
    [formatter setDateFormat:@"MMM"];
    if (patient.lastConsultation) {
        NSDateFormatter* day = [[NSDateFormatter alloc] init];
        [day setDateFormat: @"EEEE"];
        NSString *strDay = NSLocalizedString([day stringFromDate: patient.lastConsultation], nil);
        [day setDateFormat: @"yyyy"];
        lastConsultation = [NSString stringWithFormat:NSLocalizedString(@"lastConsultationFormat", nil), strDay , [formatter stringFromDate:patient.lastConsultation], [day stringFromDate:patient.lastConsultation]];
    }else{
        lastConsultation = NSLocalizedString(@"lastConsultationNeverHad", nil);
    }
    
    if (lastConsultation) {
        cell.lblLastConsultation.text = [NSLocalizedString(@"lastConsultation", nil) stringByAppendingString:lastConsultation];
        cell.lblCreatedAt.text  = [NSLocalizedString(@"patientRegisteredAt", nil) stringByAppendingString:[formatter stringFromDate:patient.createdAt]];
    }
    
     
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedPatient = [self.patientsArray objectAtIndex:indexPath.row];
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"whatDoYouWantToDoWithThisPatient", nil) delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"addConsultation", nil), NSLocalizedString(@"editPatient", nil), NSLocalizedString(@"deletePatient", nil), NSLocalizedString(@"cancel", nil), nil];
    [as showInView:self.view];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        ConsultationsVC *vc = [[ConsultationsVC alloc] initWithNibName:@"ConsultationsVC" bundle:[NSBundle mainBundle]];
        [Session sharedInstance].patient = self.selectedPatient;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end

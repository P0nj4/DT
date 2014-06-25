//
//  SignUpVC.m
//  Doctor Tool
//
//  Created by Germán Pereyra on 25/06/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "SignUpVC.h"
#import "UserModel.h"
#import "User.h"
#import "UIImage+Resize.h"
#import "MBProgressHUD.h"

@interface SignUpVC ()
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnJustRegisterMe;

- (IBAction)btnTakePhotoPressed;
- (IBAction)btnJustRegisterMePressed;


@property (nonatomic, strong) User *userAux;
@end

@implementation SignUpVC
@synthesize txtEmail,txtLastName,txtName,txtPassword;

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

#pragma mark - IBAction
- (IBAction)btnTakePhotoPressed {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"takePhoto", nil), NSLocalizedString(@"useLibrary", nil), nil];
    [sheet showInView:self.view];
    
}

- (IBAction)btnJustRegisterMePressed {
    if (!self.userAux) {
        self.userAux = [[User alloc] init];
    }
    self.userAux.name = txtName.text;
    self.userAux.lastName = txtLastName.text;
    self.userAux.password = txtPassword.text;
    self.userAux.email = txtEmail.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_queue_t queue = dispatch_queue_create("q_registerUser", NULL);
    dispatch_async(queue, ^{
        @try {
            [UserModel registerUser:self.userAux];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [[[UIAlertView alloc] initWithTitle:nil message:@"DONE" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
        @catch (NSException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(exception.name, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
    });
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == txtName) {
        [txtLastName becomeFirstResponder];
    }else if (textField == txtLastName){
        [txtEmail becomeFirstResponder];
    }else if(textField == txtEmail){
        [txtPassword becomeFirstResponder];
    }else if(textField == txtPassword){
        [txtPassword resignFirstResponder];
    }
    return YES;
}



#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                              message:NSLocalizedString(@"noCamera", nil)
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }else{
        if (buttonIndex == 1) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            [picker setCameraDevice:(UIImagePickerControllerCameraDeviceFront)];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }else if (buttonIndex == 2){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}




#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (!self.userAux) {
        self.userAux = [[User alloc] init];
    }
    self.userAux.avatar = [chosenImage imageScaledToWidth:150];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end

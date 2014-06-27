//
//  FirstTimeStartingVC.m
//  Doctor Tool
//
//  Created by German Pereyra on 6/25/14.
//  Copyright (c) 2014 Ponja. All rights reserved.
//

#import "FirstTimeStartingVC.h"
#import "CardView.h"
#import "LoginView.h"
#import "SignUpView.h"
#import "MBProgressHUD.h"
#import "DoctorModel.h"
#import "Doctor.h"
#import "UIImage+Resize.h"

@interface FirstTimeStartingVC () <CardViewDelegate, LoginViewDelegate, SignUpViewDelegate>
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) CardView *cv;
@property (nonatomic, weak) Doctor *usr;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnLoginSignUp;

- (IBAction)btnSignUpPressed:(id)sender;
@end

@implementation FirstTimeStartingVC
@synthesize viewBG, cv;
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    LoginView *login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, 400, 428)];
    login.delegate = self;
    SignUpView *signUp = [[SignUpView alloc] initWithFrame:CGRectMake(0, 0, 400, 428)];
    signUp.delegate = self;

    viewBG = [[UIView alloc] initWithFrame:self.view.bounds];
    viewBG.backgroundColor = [UIColor blackColor];
    viewBG.alpha = 0;
    [self.view addSubview:viewBG];
    
    cv = [[CardView alloc] initWithFrontView:login backView:signUp Frame:CGRectMake(0, 0, 400, 428) withGesture:YES];
    cv.useBackground = NO;
    cv.delegate = self;
    cv.center = self.view.center;
    cv.alpha = 0;
    [[self view] addSubview:cv];
    
    
    for (UIButton *btn in self.btnLoginSignUp) {
        btn.layer.cornerRadius = 8;
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor colorWithRed:105/255.0f green:105/255.0f blue:105/255.0f alpha:1.0f].CGColor;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CardViewDelegate

- (void)CardFliped:(BOOL)isFlipped{
    self.isLogin = !self.isLogin;
}

#pragma mark - LoginViewDelegate & SignUpViewDelegate
- (void)loginButtonPressed{
    if (!self.isLogin) {
        [self.cv flip];
    }
}


- (void)registerButtonPressed:(Doctor *)usr{
    if (!self.isLogin) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_queue_t queue = dispatch_queue_create("q_registerUser", NULL);
        dispatch_async(queue, ^{
            @try {
                [DoctorModel registerUser:usr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        cv.alpha = 0;
                    }];
                });
            }
            @catch (NSException *exception) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(exception.name, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                });
            }
        });

    }else{
        [self.cv flip];
    }
}

- (void)loginButtonPressed:(Doctor *)usr{
    if (self.isLogin) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_queue_t queue = dispatch_queue_create("q_registerUser", NULL);
        dispatch_async(queue, ^{
            @try {
                [DoctorModel loginUser:usr.email password:usr.password];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        cv.alpha = 0;
                    }];
                });
            }
            @catch (NSException *exception) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [[[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(exception.name, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                });
            }
        });
    }else{
        [self.cv flip];
    }
}

- (void)loginWithGoogleButtonPressed{

}

- (void)loginWithFacebookButtonPressed{

}

- (void)dismissCard{
    [UIView animateWithDuration:0.3 animations:^{
        cv.alpha = 0;
        self.viewBG.alpha = 0;
    }];
}

- (void)takePhoto:(Doctor *)usr{
    self.usr = usr;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"takePhoto", nil), NSLocalizedString(@"useLibrary", nil), nil];
    [sheet showInView:self.view];

}

#pragma mark - IBActions
- (IBAction)btnSignUpPressed:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 2) {
        if (!cv.isFlipped) {
            [cv flipWithoutAnimation];
        }
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }
    
    cv.alpha = 1;
    cv.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        viewBG.alpha = 0.3;
        cv.transform = CGAffineTransformMakeScale(1.05, 1.05);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            cv.transform = CGAffineTransformMakeScale(1., 1.);
        }];
    }];
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
        if (buttonIndex == 0) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [picker setCameraDevice:(UIImagePickerControllerCameraDeviceFront)];
            
            [self presentViewController:picker animated:YES completion:NULL];
        }else if (buttonIndex == 1){
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
    if (!self.usr) {
        return;
    }
    self.usr.avatar = [chosenImage imageScaledToWidth:150];
    SignUpView *su = nil;
    if(![cv.front isKindOfClass:[LoginView class]]){
        su = (SignUpView *)cv.front;
    }else{
        su = (SignUpView *)cv.back;
    }
    su.imgAvatar.image = self.usr.avatar;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end

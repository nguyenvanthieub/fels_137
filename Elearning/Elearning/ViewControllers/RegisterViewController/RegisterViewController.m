//
//  RegisterViewController.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "RegisterManager.h"
#import "StoreData.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

UIActivityIndicatorView *spinnerRegister;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Register";
    
    RegisterManager *registerManager = [[RegisterManager alloc] init];
    registerManager.delegate = self;
    
    [registerManager doLogout];
    
    // loading
    spinnerRegister = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnerRegister.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [spinnerRegister setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
    [self.view addSubview:spinnerRegister];
}

- (IBAction)TurnOffKeyboard:(id)sender {
    [self.view endEditing:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnCancel:(id)sender {
    [self goBackLogin];
}

- (IBAction)btnDone:(id)sender {
    [spinnerRegister startAnimating];
    
    lblAlert.text = @"";
    
    RegisterManager *registerManager = [[RegisterManager alloc] init];
    registerManager.delegate = self;
    
    [registerManager doRegisterWithEmail:txtEmail.text
                                    name:txtFullName.text
                                password:txtPassword.text
                       confirmedPassword:txtRetypePassword.text];
}

#pragma mark RegisterManagerDelegate
- (void) didLogoutwithMessage:(NSString*) message
                    withError:(NSError*) error {
    [StoreData clearUser];
}

- (void) didResponseWithMessage:(NSString*) message
                      withError:(NSError*) error {
    [spinnerRegister stopAnimating];
    
    if ([message isEqualToString:@""]) {
        if (!error) {
            [StoreData clearInput];
            UserInput *input = [[UserInput alloc] init];
            input.rememberMe = YES;
            input.emailInput = txtEmail.text;
            input.passwordInput = txtPassword.text;
            [StoreData setInput:input];
            [self goLogin];
        }
    } else {
        lblAlert.text = message;
    }
}

#pragma mark Open other screen
- (void) goHome {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Home"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) goLogin {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Login"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) goBackLogin {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Login"];
//    [self presentViewController:vc animated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

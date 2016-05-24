//
//  LoginViewController.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "StoreData.h"
#import "UserInput.h"
#import "AESCrypt.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

UIActivityIndicatorView *spinnerLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self checkLogin];
    
    self.title = @"Login";
    lblAlert.text = @"";
    
    [self checkRememberMe];
    
    // loading
    spinnerLogin = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnerLogin.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [spinnerLogin setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
    [self.view addSubview:spinnerLogin];
}

- (IBAction)TurnOffKeyboard:(id)sender {
    [self.view endEditing:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnLogin:(id)sender {
    [spinnerLogin startAnimating];
    
    lblAlert.text = @"";
    [self saveRememberMe];
    
    LoginManager *loginManager = [[LoginManager alloc] init];
    loginManager.delegate = self;
    
    [loginManager doLoginWithEmail:txtEmail.text
                          password:txtPassword.text
                          remember:_rememberMeChecked];
}

- (IBAction)btnRegister:(id)sender {
    [self goRegister];
}

- (IBAction)btnRememberMe:(id)sender {
    if (_rememberMeChecked == YES) {
        _rememberMeChecked = NO;
        [bRememberMe setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    } else {
        _rememberMeChecked = YES;
        [bRememberMe setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    [self saveRememberMe];
}

#pragma mark Check Remember Me
- (void) checkRememberMe {
    UserInput *input = [[UserInput alloc] init];
    input = [StoreData getInput];
    _rememberMeChecked = input.rememberMe;
    
    if (_rememberMeChecked == YES) {
        [bRememberMe setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        txtEmail.text = input.emailInput;
        txtPassword.text = input.passwordInput;
    } else {
        [bRememberMe setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
}

- (void) saveRememberMe {
    if (_rememberMeChecked == YES) {
        UserInput *input = [[UserInput alloc] init];
        input.rememberMe = _rememberMeChecked;
        input.emailInput = txtEmail.text;
        input.passwordInput = txtPassword.text;
        [StoreData setInput:input];
    } else {
        [StoreData clearInput];
    }
}

#pragma mark Check Login
- (void) checkLogin {
    if ([StoreData getIsLogin] == YES) {
        [self goHome];
    }
}

#pragma mark LoginManagerDelegate
- (void) didResponseWithMessage:(NSString*) message
                      withError:(NSError*) error {
    [spinnerLogin stopAnimating];
    
    if ([message isEqualToString:@""]) {
        if (!error) {
            [StoreData setIsLogin:YES];
            [self goHome];
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

- (void) goRegister {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Register"];
    [self presentViewController:vc animated:YES completion:NULL];
}

@end

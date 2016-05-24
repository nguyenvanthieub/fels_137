//
//  LoginViewController.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

{
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UILabel *lblAlert;
    __weak IBOutlet UIButton *bRememberMe;
}

@property (assign, nonatomic) BOOL rememberMeChecked;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegister:(id)sender;
- (IBAction)btnRememberMe:(id)sender;

@end

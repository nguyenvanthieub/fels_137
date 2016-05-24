//
//  RegisterViewController.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtRetypePassword;
    __weak IBOutlet UITextField *txtFullName;
    __weak IBOutlet UILabel *lblAlert;
    
}
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;
@end

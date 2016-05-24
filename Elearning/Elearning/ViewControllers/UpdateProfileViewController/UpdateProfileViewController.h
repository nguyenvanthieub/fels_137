//
//  UpdateProfileViewController.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateProfileViewController : UIViewController
{
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtNewPassword;
    __weak IBOutlet UITextField *txtRetypePassword;
    __weak IBOutlet UITextField *txtFullName;
    __weak IBOutlet UILabel *lblAlert;
    __weak IBOutlet UIImageView *imgAvatar;
}

@property (strong, nonatomic) UIImagePickerController *avatarPicker;
@property (strong, nonatomic) NSString *avatarString;

- (IBAction)btnCancel:(id)sender;
- (IBAction)btnUpdate:(id)sender;
@end

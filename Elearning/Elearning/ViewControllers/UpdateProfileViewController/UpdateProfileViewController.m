//
//  UpdateProfileViewController.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import "UpdateProfileManager.h"
#import "User.h"
#import "StoreData.h"

@interface UpdateProfileViewController ()

@end

@implementation UpdateProfileViewController

UIActivityIndicatorView *spinnerUpdateProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Update profile";
    lblAlert.text = @"";
    
    User *user = [[User alloc] init];
    user = [StoreData getUser];
    
    txtEmail.text = user.email;
    txtNewPassword.text = @"";
    txtRetypePassword.text = @"";
    txtFullName.text = user.name;
    
    // view avatar - change link to user.avatar
//    NSURL *url = [NSURL URLWithString:@"http://findicons.com/files/icons/1072/face_avatars/300/a04.png"];
    NSURL *url = [NSURL URLWithString:user.avatar];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *tmpImage = [[UIImage alloc] initWithData:data];
    imgAvatar.image = tmpImage;
    if (imgAvatar.image == nil) {
        tmpImage=[UIImage imageNamed:@"noavatar.png"];
        imgAvatar.image = tmpImage;
    }
    
    // event click avatar
    [imgAvatar setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapOnAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatarAction:)];
    [imgAvatar addGestureRecognizer:tapOnAvatar];
    
    // loading
    spinnerUpdateProfile = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinnerUpdateProfile.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [spinnerUpdateProfile setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height/2.0)];
    [self.view addSubview:spinnerUpdateProfile];
}

- (IBAction)TurnOffKeyboard:(id)sender {
    [self.view endEditing:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnCancel:(id)sender {
    [self goBackHome];
}

- (IBAction)btnUpdate:(id)sender {
//    [spinnerUpdateProfile startAnimating];
    
    lblAlert.text = @"";
    
    self.avatarString = @"";
    if (imgAvatar.image) {
        self.avatarString = [self encodeToBase64String:imgAvatar.image];
    }
    
    UpdateProfileManager *updateProfileManager = [[UpdateProfileManager alloc] init];
    updateProfileManager.delegate = self;
    
    NSLog(@"Base64 image: %@", self.avatarString);
    
    NSString *strImageData = [self.avatarString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    [updateProfileManager doUpdateProfileWithName:txtFullName.text
                                            email:txtEmail.text
                                         password:txtNewPassword.text
                             passwordConfirmation:txtRetypePassword.text
                                           avatar:strImageData];
}

#pragma mark Avatar click
- (void)tapOnAvatarAction:(UITapGestureRecognizer *)tapOnAvatar {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Avatar" message:@"Select a photo" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction *action) {
                                                   }];
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Choose from Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self chooseFromGallery];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Take Photo"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
        [self takePhoto];
    }];
    
    [alert addAction:camera];
    [alert addAction:gallery];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)chooseFromGallery {
    self.avatarPicker = [[UIImagePickerController alloc] init];
    self.avatarPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.avatarPicker.delegate = self;
    [self presentViewController:self.avatarPicker animated:YES completion:nil];
}

- (void)takePhoto {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *cameraErrorAlert = [UIAlertController alertControllerWithTitle:@"Oops!!!" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraNotFound = [UIAlertAction actionWithTitle:@"Camera Not Found" style:UIAlertActionStyleDestructive handler:nil];
        
        [cameraErrorAlert addAction:cameraNotFound];
        [self presentViewController:cameraErrorAlert animated:YES completion:nil];
    } else {
        self.avatarPicker = [[UIImagePickerController alloc] init];
        self.avatarPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.avatarPicker.delegate = self;
        [self presentViewController:self.avatarPicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    CGSize viewSize = CGSizeMake(imgAvatar.frame.size.width, imgAvatar.frame.size.height);
    
    UIGraphicsBeginImageContext(viewSize);
    [chosenImage drawInRect:CGRectMake(0,0,viewSize.width,viewSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imgData = UIImagePNGRepresentation(newImage);
    [imgAvatar setImage:[[UIImage alloc] initWithData:imgData]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image,0.4) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark UpdateProfileManagerDelegate
- (void) didResponseWithMessage:(NSString*) message
                      withError:(NSError*) error {
    [spinnerUpdateProfile stopAnimating];
    
    lblAlert.text = message;
//    if ([message isEqualToString:@"Update success"]) {
//        if (!error) {
//            [self goHome];
//        }
//    }
}

#pragma mark Open other screen
- (void) goHome {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Home"];
    [self presentViewController:vc animated:YES completion:NULL];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) goBackHome {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Home"];
//    [self presentViewController:vc animated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

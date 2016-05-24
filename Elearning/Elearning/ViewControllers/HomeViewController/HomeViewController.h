//
//  HomeViewController.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserActivityTableViewCell.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UILabel *txtName;
    __weak IBOutlet UILabel *txtEmail;
    __weak IBOutlet UILabel *txtLearned;
    __weak IBOutlet UIImageView *imgAvatar;
}

@property (weak, nonatomic) IBOutlet UITableView *userActivityTableView;
@property (strong, nonatomic) NSArray *userActivityArray;

- (IBAction)btnWords:(id)sender;
- (IBAction)btnLesson:(id)sender;
- (IBAction)btnLogout:(id)sender;
- (IBAction)btnEdit:(id)sender;
@end

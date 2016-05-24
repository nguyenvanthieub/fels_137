//
//  HomeViewController.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/24/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"
#import "StoreData.h"
#import "HomeManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile";
}

-(void)viewWillAppear:(BOOL)animated
{
    User *user = [[User alloc] init];
    user = [StoreData getUser];
    
    txtName.text = user.name;
    txtEmail.text = user.email;
    txtLearned.text = [NSString stringWithFormat:@"Learned %d words", user.learnedWords];
    self.userActivityArray = user.activities;
    
    // view avatar - change link to user.avatar
//        NSURL *url = [NSURL URLWithString:@"http://findicons.com/files/icons/1072/face_avatars/300/a04.png"];
    NSURL *url = [NSURL URLWithString:user.avatar];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *tmpImage = [[UIImage alloc] initWithData:data];
    imgAvatar.image = tmpImage;
    if (imgAvatar.image == nil) {
        tmpImage=[UIImage imageNamed:@"noavatar.png"];
        imgAvatar.image = tmpImage;
    }
    
    // Get data from link show user
    //    HomeManager *homeManager = [[HomeManager alloc] init];
    //    homeManager.delegate = self;
    //
    //    [homeManager doShowUser];
}

- (IBAction)btnWords:(id)sender {
    [self goWords];
}

- (IBAction)btnLesson:(id)sender {
    [self goLesson];
}

- (IBAction)btnLogout:(id)sender {
    HomeManager *homeManager = [[HomeManager alloc] init];
    homeManager.delegate = self;
    
    [homeManager doLogout];
}

- (IBAction)btnEdit:(id)sender {
    [self goUpdateProfile];
}

#pragma mark HomeManagerDelegate
- (void) didLogoutwithMessage:(NSString*) message
                    withError:(NSError*) error {
    [StoreData clearUser];
    [self goLogin];
}

- (void) didReceiveUser:(User*) user
            withMessage:(NSString*) message
              withError:(NSError*) error {
    if ([message isEqualToString:@""]) {
        if (!error) {
            if (user != nil) {
                txtName.text = user.name;
                txtEmail.text = user.email;
                txtLearned.text = [NSString stringWithFormat:@"Learned %d words", user.learnedWords];
                
                // view avatar - change link to user.avatar
//                NSURL *url = [NSURL URLWithString:@"http://findicons.com/files/icons/1072/face_avatars/300/a04.png"];
                NSURL *url = [NSURL URLWithString:user.avatar];
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                UIImage *tmpImage = [[UIImage alloc] initWithData:data];
                imgAvatar.image = tmpImage;
                if (imgAvatar.image == nil) {
                    tmpImage=[UIImage imageNamed:@"noavatar.png"];
                    imgAvatar.image = tmpImage;
                }
                
                self.userActivityArray = user.activities;
            }
        }
    }
}

#pragma mark - UITableView
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userActivityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    UserActivityTableViewCell *cell = (UserActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSDictionary *activity = [self.userActivityArray objectAtIndex:indexPath.row];
    
    cell.activityContentLabel.text = [activity valueForKey:@"content"];
    cell.activityCreatedDate.text = [activity valueForKey:@"created_at"];
    
    return cell;
}

#pragma mark Open other screen
- (void) goLogin {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Login"];
//    [self presentViewController:vc animated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) goUpdateProfile {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"UpdateProfile"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) goWords {
    NSLog(@"Click Button Words");
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Words"];
//    [self presentViewController:vc animated:YES completion:NULL];
}

- (void) goLesson {
    NSLog(@"Click Button Lesson");
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Lesson"];
//    [self presentViewController:vc animated:YES completion:NULL];
}

@end

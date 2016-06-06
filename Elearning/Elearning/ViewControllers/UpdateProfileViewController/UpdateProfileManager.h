//
//  UpdateProfileManager.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/28/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@protocol UpdateProfileManagerDelegate
- (void) didResponseWithMessage:(NSString*) message
                      withError:(NSError*) error;
@end

@interface UpdateProfileManager : NSObject
@property (nonatomic, weak) id<UpdateProfileManagerDelegate> delegate;
- (void)doUpdateProfileWithName:(NSString *)name
                          email:(NSString *)email
                       password:(NSString *)password
           passwordConfirmation:(NSString *)passwordConfirmation
                         avatar:(NSString *)avatarString;
@end

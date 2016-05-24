//
//  ParseJson.h
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ParseJson : NSObject

- (User *)parseLoginResponse:(id)responseData;

- (User *)parseRegisterResponse:(id)responseData;

- (User *)parseUpdateProfileResponse:(id)responseData;

- (User *)parseShowUserResponse:(id)responseData;

@end

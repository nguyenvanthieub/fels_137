//
//  ParseJson.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "ParseJson.h"

@implementation ParseJson

- (User *)parseLoginResponse:(id)responseData
{
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:@"user"];
    
    User *user = [[User alloc] init];
    
    user.userId = [[userInfo objectForKey:@"id"] intValue];
    user.name = [userInfo objectForKey:@"name"];
    user.email = [userInfo objectForKey:@"email"];
    user.avatar = [userInfo objectForKey:@"avatar"];
    user.authToken = [userInfo objectForKey:@"auth_token"];
    user.learnedWords = [[userInfo objectForKey:@"learned_words"] intValue];
    user.activities = [userInfo objectForKey:@"activities"];
    
    return user;
}

- (User *)parseRegisterResponse:(id)responseData {
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:@"user"];
    
    User *user = [[User alloc] init];
    
    user.userId = [[userInfo objectForKey:@"id"] intValue];
    user.name = [userInfo objectForKey:@"name"];
    user.email = [userInfo objectForKey:@"email"];
    user.avatar = [userInfo objectForKey:@"avatar"];
    user.authToken = [userInfo objectForKey:@"auth_token"];
    user.learnedWords = [[userInfo objectForKey:@"learned_words"] intValue];
    user.activities = [userInfo objectForKey:@"activities"];
    
    return user;
}

- (User *)parseUpdateProfileResponse:(id)responseData {
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:@"user"];
    
    User *user = [[User alloc] init];
    
    user.userId = [[userInfo objectForKey:@"id"] intValue];
    user.name = [userInfo objectForKey:@"name"];
    user.email = [userInfo objectForKey:@"email"];
    user.avatar = [userInfo objectForKey:@"avatar"];
    user.authToken = [userInfo objectForKey:@"auth_token"];
    user.learnedWords = [[userInfo objectForKey:@"learned_words"] intValue];
    user.activities = [userInfo objectForKey:@"activities"];
    
    return user;
}

- (User *)parseShowUserResponse:(id)responseData
{
    NSDictionary *logInData = [self parseJSONData:responseData];
    NSDictionary *userInfo = [logInData objectForKey:@"user"];
    
    User *user = [[User alloc] init];
    
    user.userId = [[userInfo objectForKey:@"id"] intValue];
    user.name = [userInfo objectForKey:@"name"];
    user.email = [userInfo objectForKey:@"email"];
    user.avatar = [userInfo objectForKey:@"avatar"];
    user.authToken = [userInfo objectForKey:@"auth_token"];
    user.learnedWords = [[userInfo objectForKey:@"learned_words"] intValue];
    user.activities = [userInfo objectForKey:@"activities"];
    
    return user;
}

- (id)parseJSONData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&error];
            if (error != nil) {
                return nil;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

@end

//
//  LoginManager.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/26/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "LoginManager.h"
#import "DataValidation.h"
#import "NetworkConnection.h"
#import "ParseJson.h"
#import "StoreData.h"
#import "User.h"

#define URL_LOGIN "https://manh-nt.herokuapp.com/login.json"
#define PARAM_LOGIN "session[email]=%@&session[password]=%@&session[remember_me]=%d"

@implementation LoginManager

- (void)doLoginWithEmail:(NSString *)email
                password:(NSString *)password
                remember:(BOOL)rememberMe
{
    NSString *errorMessage = @"";
    [self checkLoginWithEmail:email password:password errorMessage:&errorMessage];
    
    // check local ok, send request login
    if ([errorMessage isEqualToString:@""]) {
        
        int iRememberMe = 0;
        if (rememberMe == YES) {
            iRememberMe = 1;
        }

        NSString *paramLogin = [NSString stringWithFormat:@PARAM_LOGIN, email, password, iRememberMe];
        
        [NetworkConnection postWithUrl:@URL_LOGIN params:paramLogin resultRequest:^(NSDictionary * dic, NSError * error) {
            
            NSString *message = @"Lost connection";
            if (!error) {
                if (dic != nil) {
                    message = dic[@"message"];
                    if (!message) {
                        message = dic[@"error"];
                        if (!message) {
                            User *user = [[User alloc] init];
                            ParseJson *parserLogin = [[ParseJson alloc] init];
                            user = [parserLogin parseLoginResponse:dic];
                            [StoreData setUser:user];
                            message = @"";
                        }
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didResponseWithMessage:message withError:error];
            });
            
        }];

    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didResponseWithMessage:errorMessage withError:nil];
        });
    }
}

- (BOOL)checkLoginWithEmail:(NSString *)email
                   password:(NSString *)password
                errorMessage:(NSString **)errorMessage
{
    
    if (![DataValidation isValidEmailAddress:email errorMessage:errorMessage]) {
        return NO;
    }
    
    if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
        return NO;
    }
    
    return YES;
    
}

@end

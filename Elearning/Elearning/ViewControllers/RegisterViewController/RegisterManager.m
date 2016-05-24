//
//  RegisterManager.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "RegisterManager.h"
#import "DataValidation.h"
#import "NetworkConnection.h"
#import "ParseJson.h"
#import "StoreData.h"
#import "User.h"

#define URL_LOGOUT "https://manh-nt.herokuapp.com/logout.json"
#define PARAM_LOGOUT "auth_token=%@"
#define URL_REGISTER "https://manh-nt.herokuapp.com/users.json"
#define PARAM_REGISTER "user[name]=%@&user[email]=%@&user[password]=%@&user[password_confirmation]=%@"

@implementation RegisterManager

- (void)doLogout {
    User *user = [[User alloc] init];
    user = [StoreData getUser];
    
    NSString *paramLogout = [NSString stringWithFormat:@PARAM_LOGOUT, user.authToken];;
    
    [NetworkConnection deleteWithUrl:@URL_LOGOUT params:paramLogout resultRequest:^(NSDictionary * dic, NSError * error) {

        NSString *message = @"Lost connection";
        if (!error) {
            if (dic != nil) {
                message = dic[@"message"];
                if (!message) {
                    message = dic[@"error"];
                    if (!message) {
                        message = @"";
                    }
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didLogoutwithMessage:message withError:error];
        });
        
    }];
}

- (void)doRegisterWithEmail:(NSString *)email
                       name:(NSString *)name
                   password:(NSString *)password
          confirmedPassword:(NSString *)confirmedPassword
{
    NSString *errorMessage = @"";
    [self checkRegisterWithEmail:email name:name password:password confirmedPassword:confirmedPassword errorMessage:&errorMessage];
    
    // check local ok, send request login
    if ([errorMessage isEqualToString:@""]) {
        
        NSString *paramRegister = [NSString stringWithFormat:@PARAM_REGISTER, name, email, password, confirmedPassword];

        [NetworkConnection postWithUrl:@URL_REGISTER params:paramRegister resultRequest:^(NSDictionary * dic, NSError * error) {

            NSString *message = @"Lost connection";
            if (!error) {
                if (dic != nil) {
                    message = dic[@"message"];
                    if (!message) {
                        message = dic[@"error"];
                        if (!message) {
                            User *user = [[User alloc] init];
                            ParseJson *parserLogin = [[ParseJson alloc] init];
                            user = [parserLogin parseRegisterResponse:dic];
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

- (BOOL)checkRegisterWithEmail:(NSString *)email
                          name:(NSString *)name
                      password:(NSString *)password
             confirmedPassword:(NSString *)confirmedPassword
                  errorMessage:(NSString **)errorMessage
{
    
    if (![DataValidation isValidEmailAddress:email errorMessage:errorMessage]) {
        return NO;
    }
    
    if (![DataValidation isValidName:name errorMessage:errorMessage]){
        return NO;
    }
    
    if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
        return NO;
    }
    
    if (![DataValidation isValidPassword:confirmedPassword errorMessage:errorMessage]) {
        return NO;
    }
    
    if (![DataValidation isValidConfirmedPassword:confirmedPassword password:password errorMessage:errorMessage]) {
        return NO;
    }
    
    return YES;
    
}
@end

//
//  HomeManager.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "HomeManager.h"
#import "NetworkConnection.h"
#import "User.h"
#import "StoreData.h"
#import "ParseJson.h"

#define URL_LOGOUT "https://manh-nt.herokuapp.com/logout.json"
#define PARAM_LOGOUT "auth_token=%@"
#define URL_SHOWUSER "https://manh-nt.herokuapp.com/users/%d.json"
#define PARAM_SHOWUSER "auth_token=%@"

@implementation HomeManager

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

- (void)doShowUser {
    User *user = [[User alloc] init];
    user = [StoreData getUser];
    
    NSString *urlShowUser = [NSString stringWithFormat:@URL_SHOWUSER, user.userId];
    NSString *paramShowUser = [NSString stringWithFormat:@PARAM_SHOWUSER, user.authToken];
    
    [NetworkConnection getWithUrl:urlShowUser params:paramShowUser resultRequest:^(NSDictionary * dic, NSError * error) {
        
        if (!error && dic != nil) {
            if (dic[@"message"] == nil) {
                if (dic[@"error"] == nil) {
                    User *user = [[User alloc] init];
                    ParseJson *parserLogin = [[ParseJson alloc] init];
                    user = [parserLogin parseShowUserResponse:dic];
                    [StoreData setUser:user];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate didReceiveUser:user withMessage:@"" withError:error];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate didReceiveUser:nil withMessage:dic[@"error"] withError:error];
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didReceiveUser:nil withMessage:dic[@"message"] withError:error];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didReceiveUser:nil withMessage:@"Lost connection" withError:error];
            });
        }
    }];
}

@end

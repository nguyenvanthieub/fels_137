//
//  UpdateProfileManager.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/28/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "UpdateProfileManager.h"
#import "DataValidation.h"
#import "StoreData.h"
#import "NetworkConnection.h"
#import "ParseJson.h"

#define URL_UPDATEPROFIlE "https://manh-nt.herokuapp.com/users/%d.json"
#define PARAM_UPDATEPROFILE "user[name]=%@&user[email]=%@&user[password]=%@&user[password_confirmation]=%@&user[avatar]=%@&auth_token=%@"

@implementation UpdateProfileManager
-(void) doUpdateProfileWithName:(NSString *)name
                          email:(NSString *)email
                       password:(NSString *)password
           passwordConfirmation:(NSString *)passwordConfirmation
                         avatar:(NSString *)avatarString
{
    NSString *errorMessage = @"";
    [self checkUpdateProfileWithName:name
                               email:email
                            password:password
                passwordConfirmation:passwordConfirmation
                        errorMessage:&errorMessage];
   
    // check local ok, send request update profile
    if ([errorMessage isEqualToString:@""]) {
        User *user = [[User alloc] init];
        user = [StoreData getUser];
        
        NSString *urlUpdateProfile = [NSString stringWithFormat:@URL_UPDATEPROFIlE, user.userId];
        NSString *paramUpdateProfile = [NSString stringWithFormat:@PARAM_UPDATEPROFILE, name, email, password, passwordConfirmation, avatarString, user.authToken];

        [NetworkConnection patchWithUrl:urlUpdateProfile params:paramUpdateProfile resultRequest:^(NSDictionary * dic, NSError * error) {
            
            NSString *message = @"Lost connection";
            if (!error) {
                if (dic != nil) {
                    if (dic[@"message"] == nil && dic[@"error"] == nil) {
                        User *user = [[User alloc] init];
                        ParseJson *parserLogin = [[ParseJson alloc] init];
                        user = [parserLogin parseUpdateProfileResponse:dic];
                        [StoreData setUser:user];
                        message = @"Update success";
                    } else {
                        message = @"Error update";
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

- (BOOL)checkUpdateProfileWithName:(NSString *)name
                      email:(NSString *)email
                   password:(NSString *)password
       passwordConfirmation:(NSString *)passwordConfirmation
               errorMessage:(NSString **)errorMessage
{
    
    if (![DataValidation isValidName:name errorMessage:errorMessage]){
        return NO;
    }
    
    if (![DataValidation isValidEmailAddress:email errorMessage:errorMessage]) {
        return NO;
    }

//    if (![DataValidation isValidPassword:password errorMessage:errorMessage]) {
//        return NO;
//    }
//    
//    if (![DataValidation isValidPassword:passwordConfirmation errorMessage:errorMessage]) {
//        return NO;
//    }
    
    if (![DataValidation isValidConfirmedPassword:passwordConfirmation password:password errorMessage:errorMessage]) {
        return NO;
    }
    
    return YES;

}

@end

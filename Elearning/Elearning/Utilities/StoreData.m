//
//  StoreData.m
//  Elearning
//
//  Created by Nguyen Van Thieu B on 5/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

#import "StoreData.h"
#import "AESCrypt.h"

#define PASS "thieumao"

@implementation StoreData

//NSString *pass = @"thieumao";

+ (User *)getUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    User *user = [[User alloc] init];
//    user.userId = [defaults integerForKey:@"user_id"];
//    user.name = [defaults objectForKey:@"name"];
//    user.email = [defaults objectForKey:@"email"];
//    user.avatar = [defaults objectForKey:@"avatar"];
//    user.authToken = [defaults objectForKey:@"auth_token"];
//    user.activities = [defaults objectForKey:@"activities"];
    user.userId = [defaults integerForKey:@"user_id"];
    user.name = [AESCrypt decrypt:[defaults objectForKey:@"name"] password:@PASS];
    user.email = [AESCrypt decrypt:[defaults objectForKey:@"email"] password:@PASS];
    user.avatar = [AESCrypt decrypt:[defaults objectForKey:@"avatar"] password:@PASS];
    user.authToken = [AESCrypt decrypt:[defaults objectForKey:@"auth_token"] password:@PASS];
    user.activities = [defaults objectForKey:@"activities"];
    return user;
}

+ (void)setUser:(User *)user {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:user.userId forKey:@"user_id"];
//    [defaults setObject:user.name forKey:@"name"];
//    [defaults setObject:user.email forKey:@"email"];
//    [defaults setObject:user.avatar forKey:@"avatar"];
//    [defaults setObject:user.authToken forKey:@"auth_token"];
//    [defaults setObject:user.activities forKey:@"activities"];
    [defaults setInteger:user.userId forKey:@"user_id"];
    [defaults setObject:[AESCrypt encrypt:user.name password:@PASS] forKey:@"name"];
    [defaults setObject:[AESCrypt encrypt:user.email password:@PASS] forKey:@"email"];
    [defaults setObject:[AESCrypt encrypt:user.avatar password:@PASS] forKey:@"avatar"];
    [defaults setObject:[AESCrypt encrypt:user.authToken password:@PASS]forKey:@"auth_token"];
    [defaults setObject:user.activities forKey:@"activities"];
}

+ (void)clearUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user_id"];
    [defaults removeObjectForKey:@"name"];
    [defaults removeObjectForKey:@"email"];
    [defaults removeObjectForKey:@"avatar"];
    [defaults removeObjectForKey:@"auth_token"];
    [defaults removeObjectForKey:@"activities"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (UserInput *)getInput {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserInput *input = [[UserInput alloc] init];
//    input.rememberMe = [defaults boolForKey:@"remember_me"];
//    input.emailInput = [defaults objectForKey:@"email_input"];
//    input.passwordInput = [defaults objectForKey:@"password_input"];
    input.rememberMe = [defaults boolForKey:@"remember_me"];
    input.emailInput = [AESCrypt decrypt:[defaults objectForKey:@"email_input"] password:@PASS];
    input.passwordInput = [AESCrypt decrypt:[defaults objectForKey:@"password_input"] password:@PASS];
    return input;
}

+ (void)setInput:(UserInput *)input {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:input.rememberMe forKey:@"remember_me"];
//    [defaults setObject:input.emailInput forKey:@"email_input"];
//    [defaults setObject:input.passwordInput forKey:@"password_input"];
    [defaults setBool:input.rememberMe forKey:@"remember_me"];
    [defaults setObject:[AESCrypt encrypt:input.emailInput password:@PASS] forKey:@"email_input"];
    [defaults setObject:[AESCrypt encrypt:input.passwordInput password:@PASS] forKey:@"password_input"];
}

+ (void)clearInput {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"remember_me"];
    [defaults removeObjectForKey:@"email_input"];
    [defaults removeObjectForKey:@"password_input"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL) getIsLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"is_login"];
}

+ (void) setIsLogin:(BOOL)isLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isLogin forKey:@"is_login"];
}

@end

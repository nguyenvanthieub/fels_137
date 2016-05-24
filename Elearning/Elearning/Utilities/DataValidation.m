//
//  DataValidation.m
//  Elearning
//

#import "DataValidation.h"

@implementation DataValidation

+ (BOOL)isValidEmailAddress:(NSString *)emailAddress errorMessage:(NSString **)errorMessage {
    
    // Check if email is empty
    if ([emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Email required";
        return NO;
    }
    
    // Check if valid email
    if (emailAddress.length) {
        // Create a regex string for email
        NSString *emailFilter = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        // Create predicate with format matching your regex string
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:
                                       @"SELF MATCHES %@", emailFilter];
        
        // Check if email is invalid
        if (![emailPredicate evaluateWithObject:emailAddress]) {
            *errorMessage = @"Email is invalid";
            return NO;
        }
    }
    
    // Check maximum length
    if (emailAddress.length > 255) {
        *errorMessage = [NSString stringWithFormat:@"Email can not be longer than 255 chars"];
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidPassword:(NSString *)password errorMessage:(NSString **)errorMessage {
    
    // Check if password is empty
    if ([password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Password required";
        return NO;
    }
    
    // Check minimum length
    if (password.length < 6) {
        *errorMessage = [NSString stringWithFormat:@"Password should be at least 6 chars"];
        return NO;
    }
    
    // Check maximum length
    if (password.length > 50) {
        *errorMessage = [NSString stringWithFormat:@"Password can not be longer than 50 chars"];
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidConfirmedPassword:(NSString *)confirmedPassword password:(NSString *)password  errorMessage:(NSString **)errorMessage {
    if(![password isEqualToString:confirmedPassword]){
        *errorMessage = @"Retype password not corrected";
        return NO;
    }
    
    return YES;
}

+ (BOOL)isValidName:(NSString *)name errorMessage:(NSString **)errorMessage {
    
    // Check if name is empty
    if ([name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        *errorMessage = @"Full Name required";
        return NO;
    }
    
    // Check minimum length
    if (name.length < 2) {
        *errorMessage = [NSString stringWithFormat:@"Full Name should be at least 2 chars"];
        return NO;
    }
    
    if (name.length > 50) {
        *errorMessage = [NSString stringWithFormat:@"Full Name can not be longer than 50 chars"];
        return NO;
    }
    
    return YES;
}

@end

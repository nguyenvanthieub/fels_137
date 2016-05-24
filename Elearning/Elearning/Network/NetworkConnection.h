//
//  NetworkConnection.h
//  Elearning
//

#import <Foundation/Foundation.h>

@interface NetworkConnection : NSObject

typedef void(^ResultRequest)(NSDictionary*,NSError*);

+ (void) getWithUrl:(NSString*)url
             params:(NSString*)params
      resultRequest:(ResultRequest)complete;

+ (void) postWithUrl:(NSString*)url
              params:(NSString*)params
       resultRequest:(ResultRequest)complete;

+ (void) patchWithUrl:(NSString*)url
               params:(NSString*)params
        resultRequest:(ResultRequest)complete;

+ (void) deleteWithUrl:(NSString*)url
                params:(NSString*)params
         resultRequest:(ResultRequest)complete;

@end

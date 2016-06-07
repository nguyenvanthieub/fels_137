//
//  APIHandler.h
//  Elearning
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"

@interface APIHandler : NSObject

typedef void(^ResponseSuccess)(id response);
typedef void(^ResponseFail)(NSError *error);

+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(ResponseSuccess)success
               fail:(ResponseFail)fail;

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ResponseSuccess)success
              fail:(ResponseFail)fail;

+ (void)patchWithUrl:(NSString *)url
              params:(NSDictionary *)params
             success:(ResponseSuccess)success
                fail:(ResponseFail)fail;

+ (void)deteleWithUrl:(NSString *)url
               params:(NSDictionary *)params
              success:(ResponseSuccess)success
                 fail:(ResponseFail)fail;

@end

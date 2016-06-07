//
//  APIHandler.m
//  Elearning
//

#import "APIHandler.h"

@implementation APIHandler

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}

+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
            success:(ResponseSuccess)success
               fail:(ResponseFail)fail {
    
    // Get session manager
    AFHTTPSessionManager *manager = [self manager];
    
    // Make post request
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ResponseSuccess)success
              fail:(ResponseFail)fail {
    
    // Get session manager
    AFHTTPSessionManager *manager = [self manager];
    
    // Make get request
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)patchWithUrl:(NSString *)url
              params:(NSDictionary *)params
             success:(ResponseSuccess)success
                fail:(ResponseFail)fail {
    // Get session manager
    AFHTTPSessionManager *manager = [self manager];
    
    // Make patch request
    [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)deleteWithUrl:(NSString *)url
               params:(NSDictionary *)params
              success:(ResponseSuccess)success
                 fail:(ResponseFail)fail {
    // Get session manager
    AFHTTPSessionManager *manager = [self manager];
    
    // Make patch request
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end

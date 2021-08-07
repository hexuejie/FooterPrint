//
//  AFNetworkUtils.m
//  Hometown
//
//  Created by SilenceMac on 15/12/23.
//  Copyright © 2015年 陈小卫. All rights reserved.
//

#import "AFNetworkUtils.h"


@implementation AFNetworkUtils

+(void)GET:(NSString *)URLStr parameters:(NSDictionary *)parameters callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock{
    AFHTTPSessionManager *session = [AFNetworkUtils shareAFNManager];

    NSString *cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:kAppSessionIdKey]];
    [session.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
//    [session GET:URLStr parameters:parameters progress:^(NSProgress *downloadProgress) {
////        NSLog(@"进度");
//    } success:^(NSURLSessionDataTask *task, id  responseObject) {
////        NSLog(@"成功");
//        callBackBlock(YES,task,responseObject,nil);
//    } failure:^(NSURLSessionDataTask *task, NSError * error) {
//        NSLog(@"%@", error.userInfo);
//        callBackBlock(NO,task,nil,nil);
//    }];
        [session GET:URLStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         callBackBlock(YES,task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.userInfo);
               callBackBlock(NO,task,nil,nil);
    }];
    
    
    
}
+(AFHTTPSessionManager *)shareAFNManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}
+(void)POST:(NSString *)URLStr parameters:(NSDictionary *)parameters callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock{
    AFHTTPSessionManager *session = [AFNetworkUtils shareAFNManager];

      URLStr = [NSString stringWithFormat:@"%@?v=2.0",URLStr];
    NSLog(@"%@",URLStr);
    NSString *cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:kAppSessionIdKey]];
    [session.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
//    [session POST:URLStr parameters:parameters progress:^(NSProgress *downloadProgress) {
////        NSLog(@"进度");
//    } success:^(NSURLSessionDataTask *task, id  responseObject) {
////        NSLog(@"成功");
//        callBackBlock(YES,task,responseObject,nil);
//    } failure:^(NSURLSessionDataTask *task, NSError * error) {
//        NSLog(@"%@", error.userInfo);
//        callBackBlock(NO,task,nil,nil);
//    }];
        [session POST:URLStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           callBackBlock(YES,task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBackBlock(NO,task,nil,nil);

    }];
    
    
}

+(void)POSTBody:(NSString *)URLStr parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSString *cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@",[[NSUserDefaults standardUserDefaults] objectForKey:kAppSessionIdKey]];
    [session.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
//    [session POST:URLStr  parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        block(formData);
//    } progress:^(NSProgress *downloadProgress) {
////        NSLog(@"进度");
//    } success:^(NSURLSessionDataTask *task, id  responseObject) {
////        NSLog(@"成功");
//        callBackBlock(YES,task,responseObject,nil);
//    } failure:^(NSURLSessionDataTask *task, NSError * error) {
//        NSLog(@"%@", error.userInfo);
//        callBackBlock(NO,task,nil,nil);
//    }];
      [session.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
      [session POST:URLStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             callBackBlock(YES,task,responseObject,nil);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error.userInfo);
          callBackBlock(NO,task,nil,nil);

      }];
}
@end

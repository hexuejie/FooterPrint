//
//  AFNetworkUtils.h
//  Hometown
//
//  Created by SilenceMac on 15/12/23.
//  Copyright © 2015年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetworkUtils : NSObject

/**
 *  GET请求
 *  详细用法请参考 AFNetworking 框架
 *  @param URLStr 完整的请求路径
 *  @param parameters  参数
 *  @param callBackBlock     回调
 */
+(void)GET:(NSString *)URLStr parameters:(NSDictionary *)parameters callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock;

/**
 *  POST请求
 *  详细用法请参考 AFNetworking 框架
 *  @param URLStr 完整的请求路径
 *  @param parameters  参数
 *  @param callBackBlock     回调
 */
+(void)POST:(NSString *)URLStr parameters:(NSDictionary *)parameters callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock;

/**
 *  POSTBody请求
 *  详细用法请参考 AFNetworking 框架
 *  @param URLStr 完整的请求路径
 *  @param parameters  参数
 *  @param callBackBlock     回调
 */
+(void)POSTBody:(NSString *)URLStr parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock;

@end

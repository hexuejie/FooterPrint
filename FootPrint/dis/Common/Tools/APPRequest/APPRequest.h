//
//  APPRequest.h
//  接口请求
//
//  Created by Silence on 17/1/11.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AjaxResult.h"

typedef void (^RequestFinishedBlock) (AjaxResult *result);

@interface APPRequest : NSObject

/**
 *  GET请求
 *
 *  @param URLString 完整的请求路径
 *  @param dicParam  参数
 *  @param block     回调
 */
+(void)GET:(NSString *)URLString parameters:(NSDictionary *)dicParam finished:(void(^)(AjaxResult *result)) block;

/**
 *  POST请求
 *
 *  @param URLString 完整的请求路径
 *  @param dicParam  参数
 *  @param block     回调
 */
+(void)POST:(NSString *)URLString parameters:(NSDictionary *)dicParam finished:(void(^)(AjaxResult *result)) block;

/**
 *  提交图片
 *
 *  @param URLString 完整的请求路径
 *  @param dicParam  参数
 *  @param images 图片数组
 *  @param block     回调
 */
+(void)POSTImage: (NSString *)URLString parameters:(NSDictionary *)dicParam andImages:(NSArray<UIImage *> *)images finished:(void(^)(AjaxResult *result)) block;

+(void)POSTImage:(NSString *)URLString parameters:(NSDictionary *)dicParam andImages:(NSArray<UIImage *> *)images andImageNames:(NSArray<NSString *> *)imageNames finished:(void (^)(AjaxResult *result))block;

@end

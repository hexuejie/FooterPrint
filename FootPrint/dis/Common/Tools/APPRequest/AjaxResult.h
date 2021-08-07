//
//  AjaxResult.h
//  
//
//  Created by SilenceMac on 17/1/11.
//  Copyright © 2017年 陈小卫. All rights reserved.
//
#pragma mark - 网络请求状态枚举
typedef enum : NSUInteger {
    AjaxResultStateSuccess = 1, // 请求完成返回成功
    AjaxResultStateParamError = 500, // 请求参数错误
    AjaxResultStateTokenError = -201, // token失效
    AjaxResultStateUserError = -200, // 用户不存在
    AjaxResultStateFail = 410,  //  请求完成返回失败信息
    AjaxResultStateSessionError = 420,    // 请求完成session失效
    AjaxResultStateNoData = 500,   //  没有数据
    AjaxResultStateServerUpdate = 999,   //  服务器升级维护中（用于服务器临时调整，通过顶层返回）
    AjaxResultStateNetFail = 888,   //  网络错误
    AjaxResultStateAppRequestError = 1001, // app请求问题
    AjaxResultStateAuthError = 2001 // 无权限操作
} AjaxResultState;
#import <Foundation/Foundation.h>


@interface AjaxResult : NSObject

/**
 *  对应的状态
 */
@property(assign,nonatomic) AjaxResultState code;

/**
 *  字典数据(业务数据)
 */
@property(strong,nonatomic) id data;
/**
 *  信息提示
 */
@property(strong,nonatomic) NSString *message;

/**
 *  请求回来的原生数据
 */
@property (nonatomic, strong) id originDatas;

//数据转换后的对象
@property (nonatomic, strong) id object;

@end


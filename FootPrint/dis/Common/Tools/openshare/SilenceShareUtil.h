//
//  SilenceShareUtil.h
//  Dy
//
//  Created by Silence on 16/8/3.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenShareHeader.h"
#pragma mark 网络请求状态枚举
typedef enum : NSUInteger {
    ShareTypeWX,
    ShareTypeWXSpace,
    ShareTypeSina,
    ShareTypeQQ,
    ShareTypeQQSpace
} ShareType;

typedef void(^HandleShareClick)(ShareType type);

@interface SilenceShareUtil : NSObject
@property (nonatomic , strong) HandleShareClick handleShareClick;

//获取实例
+(SilenceShareUtil *)shareUtil;

/**
 *  弹出分享视图
 *
 *  @param shareTypeArray 需要分享的类型及平台数组 对应枚举ShareType
 *  @param shareMsg       OSMessage 需要分享的内容，详情参考opershare
 *  @param success        成功回调
 *  @param fail           失败回调
 */
-(void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg Success:(shareSuccess)success Fail:(shareFail)fail;

/**
 *  弹出分享视图
 *
 *  @param shareTypeArray 需要分享的类型及平台数组 对应枚举ShareType
 *  @param shareMsg       OSMessage 需要分享的内容，详情参考opershare
 *  @param success        成功回调
 *  @param fail           失败回调
 */
-(void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg HandleShareClick:(HandleShareClick)shareClick Success:(shareSuccess)success Fail:(shareFail)fail;

/**
 *  隐藏视图
 */
-(void)hide;

// 处理点击
-(void)handle:(ShareType)type;

@end

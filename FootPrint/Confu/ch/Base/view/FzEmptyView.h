//
//  FzEmptyView.h
//  FzShop
//  空界面
//  Created by Silence on 2016/11/7.
//  Copyright © 2016年 FzShop. All rights reserved.
//

// 空界面类型枚举
typedef enum : NSUInteger {
    EmptyViewTypeCommon, // 通用空界面
    EmptyViewTypeFail,  //页面加载失败
    EmptyViewTypeBank,  //页面加载失败
    EmptyViewTypeNetFail,  //网络请求失败
    EmptyViewTypeSystemBusy,  //抱歉！系统繁忙
    EmptyViewTypeLoading, // 加载中……
    EmptyViewTypeCart,  // 暂无商品
    EmptyViewTypeOrder, // 暂无订单
    
    EmptyViewTypeLive, // 直播页面无数据
    EmptyViewTypeInformation, // 暂无资讯
    EmptyViewTypeMessage, // 消息页面无数据
    EmptyViewTypeCourse, // 课程页面无数据
    EmptyViewTypeRecord, // 学习记录无数据
    EmptyViewTypeSearch, // 搜索页面无数据
    EmptyViewTypeShop, // 购买商品无数据
    EmptyViewTypeEnterprise, // 企业开通无数据
    EmptyViewTypeComplete, // 完成课程无数据
    EmptyViewTypeComments, // 评论列表无数据
    EmptyViewTypeDownLoad, // 下载列表无数据
} EmptyViewType;

// 空界面里面事件类型
typedef enum : NSUInteger {
    EmptyViewEventTypeBuy,//无商品
    EmptyViewEventTypeReload // 重新加载
} EmptyViewEventType;

typedef void (^EmptyViewEventBlock)(EmptyViewEventType eventType);

#import "BaseView.h"

@interface FzEmptyView : BaseView


/**
 初始化空视图

 @param emptyViewType 空界面类型枚举
 @param view 需要显示在哪个界面里面
 @param eventBlock 事件回调
 @return 生成的后的界面
 */
-(instancetype)initEmptyViewType:(EmptyViewType)emptyViewType showInView:(UIView *)view eventBlock:(EmptyViewEventBlock)eventBlock;
//placeholder_property//

/**
 初始化空视图 根据请求回来的状态

 @param ajaxResultState 请求状态
 @param view 需要显示在哪个界面里面
 @param eventBlock 事件回调
 @return 生成的后的界面
 */
-(instancetype)initEmptyViewWithAjaxResultState:(AjaxResultState)ajaxResultState showInView:(UIView *)view eventBlock:(EmptyViewEventBlock)eventBlock;
//placeholder_property//
//placeholder_method_declare//

/**
 显示
 */
-(void)show:(CGFloat)height;
//placeholder_method_declare//


/**
 隐藏
 */
-(void)hide;
//placeholder_method_declare//

@end

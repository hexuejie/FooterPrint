//
//  BaseVC.h
//  VegetableBasket
//
//  Created by Silence on 2017/1/12.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FzEmptyView.h"
#import "SilenceImagePreview.h"
#import "OpenShareHeader.h"
#import "SilenceShareUtil.h"

typedef void (^BlockLoginSuccess)();

@interface BaseVC : UIViewController

@property (nonatomic, copy) void (^BlockBackClick)(void);
//placeholder_property//
- (void)showMorePop:(UIButton *)sender;

// 登录事件
- (void)loginAction;

/**
 左边的按钮
 */
@property (nonatomic , strong) UIButton *leftButton;
//placeholder_property//
/**
 用户是否登录了
 */
@property (nonatomic , assign ,readonly) BOOL isLogin;
//placeholder_property//
/**
 是否回主页
 */
@property (nonatomic , assign ) BOOL isBackHome;

#pragma mark - 公开的方法
//placeholder_property//
/**
 初始化UI（给子类实现）
 */
-(void)setupUI;
//placeholder_property//
/**
 加载数据（给子类实现）
 */
-(void)loadData;
//placeholder_property//
/**
 点击了返回按钮
 */
-(void)leftButtonClick;

/**
 拨打电话
 */
- (void)callPhone:(NSString *)phone;
//placeholder_property//
/**
 检查登录并跳转至登录界面
 
 @return 返回是否登录了
 */
-(BOOL)checkLoginBlokc:(BlockLoginSuccess)block;
/**
 去消息中心
 */
-(void)gotoMsgCenter;
//placeholder_property//
/**
 添加右上角更多按钮
 */
-(void)addMorePopBtn;

/**
 扫码
 */
//-(void)startScan;

/**
 扫码跳转
 */
//-(void) gotoScanCenter : (NSString *) scanParam;

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

#pragma mark - 空界面 相关的内容
/**
 空界面 （里面的类型请参考枚举 EmptyViewType）
 */
@property (nonatomic , strong) FzEmptyView *emptyView;
//placeholder_property//
/**
 *  显示加载视图
 */
-(void) showLoadingView;

- (void)toRootViewController;

/**7
 *  隐藏加载视图
 */
//placeholder_property//
-(void) hideLoadingView;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

//显示一些根据状态显示的空view，这个请求基本都要调
-(void)showEmptyViewWithAjaxResultState:(AjaxResultState)ajaxResultState eventBlock:(EmptyViewEventBlock)eventBlock;

//显示空的view
-(void)showEmptyView:(EmptyViewType)emptyViewType eventBlock:(EmptyViewEventBlock)eventBlock;

//显示空的view 可设置尺寸
-(void)showEmptyView:(EmptyViewType)emptyViewType viewHeight:(CGFloat)height eventBlock:(EmptyViewEventBlock)eventBlock;

//隐藏空的view
-(void)hideEmptyView;

// 大图浏览
- (void)showBigImageView:(NSArray *)imglist Index:(NSInteger )index;

- (void)BackHome:(NSInteger)selectIndex;

//获取设备系统
- (NSString *)deviceVersion;

/**
 分享

 @param shareTypeArray 分享对象
 @param shareMsg 分享内容
 @param success 成功回调
 @param fail 失败回调
 */
-(void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg Success:(shareSuccess)success Fail:(shareFail)fail;

- (void)showShareViews:(NSInteger)shareType shareId:(NSString *)shareid shareImgUrl:(NSString *)imgUrl shareTitle:(NSString *)title Success:(shareSuccess)success Fail:(shareFail)fail;

- (UIView *)getDefaultFootView:(CGPoint)point;

- (void)GoLiveRoom:(NSString *)liveId liveState:(NSInteger)livestate;
- (void)shareImgUrl:(NSString *)imgUrl andSuccess:(shareSuccess)success Fail:(shareFail)fail;
- (void)ShareGroupshareImgUrl:(NSString *)imgUrl shareUrl:(NSString *)urlStr withTitle:(NSString *)title  Success:(shareSuccess)success Fail:(shareFail)fail;
@end

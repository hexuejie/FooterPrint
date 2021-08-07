//
//  AppConfig.h
//  常用宏和初始化配置
//  Created by Silence on 17/1/11.
//  Copyright © 2017年 陈小卫. All rights reserved.
//



#ifndef AppConfig_h
#define AppConfig_h


#pragma mark - 订单状态
typedef enum : NSUInteger {
    OrderStateAll, // 全部
    OrderStateObligation,  // 待付款
    OrderStateReceiving,    // 待收货
    OrderStateFinishedOrJudge,  // 待评价、已完成
} OrderState;


#pragma mark - 订单操作
typedef enum : NSUInteger {
    OrderOptCancel,  // 取消订单
    OrderOptPay,     // 去付款
    OrderOptJudge,  // 去评价
    OrderOptViewJudge,  // 查看评价
    OrderOptReceive,     // 收货
} OrderOpt;


#pragma mark - Action
//------------------------Begin Action---------------------------

// Action 地址

//
//#define HOST_ACTION    @"https://yk.jiaoyin.vip/api/app"
//#define HOST_IMG    @"https://yk.jiaoyin.vip"
//#define kWXAppId @"wx749661e8f174d2b6"
//#define kWXAppSecreat @"c8377aa3b97998af11c34dfa1eeb69ad"
//#define kJPushAppkey @"3c5a94cc6e49a7706a696ce11" //3c5a94cc6e49a7706a696ce11
//#define Wechat_Jump @"yk.jiaoyin.vip://"


#define HOST_ACTION    @"https://ketang.grazy.cn/api/app"
#define HOST_IMG    @"https://ketang.grazy.cn/"
#define kWXAppId @"wx9f8d870892328f8f"  // wx9f8d870892328f8f  正式 wx749661e8f174d2b6
#define kWXAppSecreat @"c8377aa3b97998af11c34dfa1eeb69ad"
//极光推送appkey
#define kJPushAppkey @"18a3e3a8e583834789f347cf"
#define Wechat_Jump @"ketang.grazy.cn://"

#define is_iPhoneXSerious @available(iOS 11.0, *) && UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0




#define APPKEY @"1105788405"



#pragma mark - 本地数据
#define APP_LOCAL_CART_COUNT @"AppLocalCartCcount"

#pragma mark - 第三方key
#define kQQAppId @"1109592726"
#define kWeiboAppId @"37967058"




// 百度地图第三方key
#define kBaiduAppkey @"GdZpRgFm6ZIYjtfaZ0EMxMjPFp38nDqf"



// 百度地图第三方key
#define kBaiduAppkey @"GdZpRgFm6ZIYjtfaZ0EMxMjPFp38nDqf"

#define kNotification_CheckStateChange @"kNotification_CheckStatesChange"

#define kNotification_UpdateHot @"kNotification_UpdateHot"


#define kHotName  @"kHotName"

#pragma mark - 通知
// 分类改变了
#define kNotify_Category_Change   @"kNotify_Category_Change"
//sessionId key
#define kAppSessionIdKey @"kAppSessionIdKey"
// 登录状态发生变化
#define kNotification_LoginStateChange @"kNotification_LoginStateChange"
// 消息数量变化
#define kNotification_MessageChange @"kNotification_MessageChange"

#define kNotification_LoginOut @"kNotificatio_LoginOutAc"

#define kNotification_LoginActions @"kNotification_LoginActions"

#define kNotification_DirectionChange @"kNotification_DirectionChange"



// 接口请求
#define APP_ACTION(actUrl)  [NSString stringWithFormat:@"%@%@", HOST_ACTION,actUrl]
#define APP_IMAGE_ACTION(actUrl)  [NSString stringWithFormat:@"%@%@", HOST_IMG_UPLOAD,actUrl]
// 图片路径
#define APP_IMG(imgUrl)  [NSURL URLWithString:[imgUrl hasPrefix:@"http"] ? imgUrl : [NSString stringWithFormat:@"%@%@", HOST_IMG,imgUrl]]

//------------------------End Action---------------------------

#pragma mark - 常用默认值
#define kSplitHeight (1.0 / [UIScreen mainScreen].scale)
#define kBaseSpace 10

#pragma mark - 默认图片
/**** 默认图片 ****/
#define kDefaultImageLarge      [UIImage imageNamed:@"square_default_img"]


// 隐私政策
#define  PRIVANCY_LINK [NSString stringWithFormat:@"%@%@", HOST_IMG,@"/privacy.html"]
// 用户协议
#define  Protocal_IINK [NSString stringWithFormat:@"%@%@", HOST_IMG,@"/user.html"]


#pragma mark - 颜色类
//----------------------颜色类---------------------------
#define kColor_BG RGBA(246, 246, 246, 1) // 主背景
#define kColor_Split RGBA(244, 244, 244,1) //分割线颜色

#pragma mark - 常用宏
#pragma mark - weakself
#define WS(weakself) __block typeof (self) weakself = self;

/*主窗口*/
#define KeyWindow [UIApplication sharedApplication].keyWindow

//UserId 
#define KUserId [[NSUserDefaults standardUserDefaults] objectForKey:@"KUserId"]
#define Ktoken [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

#define isAudit [[NSUserDefaults standardUserDefaults] objectForKey:@"is_audit"]

#define KTour [[NSUserDefaults standardUserDefaults] objectForKey:@"KTour"]

#define sandboxCheckURL @"https://sandbox.itunes.apple.com/verifyReceipt"
#define productCheckURL @"https://buy.itunes.apple.com/verifyReceipt"

//单次允许流量播放
#define KIsOneTrafficPlay [[NSUserDefaults standardUserDefaults] boolForKey:@"isOneTrafficPlay"]
//是否允许流量播放
#define KIsTrafficPlay [[NSUserDefaults standardUserDefaults] boolForKey:@"isTrafficPlay"]
//是否允许流量下载
#define KIsTrafficDownLoad [[NSUserDefaults standardUserDefaults] boolForKey:@"isTrafficDownLoad"]
//当前网络状态
#define KNetWorkStatus [[NSUserDefaults standardUserDefaults] objectForKey:@"networkStatus"]

#define is_iPhoneXSerious @available(iOS 11.0, *) && UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0

/*判断机型*/
#define KISIPHONE5 (SCREEN_HEIGHT == 568.0)
#define KISIPHONE6 (SCREEN_HEIGHT == 667.0)
#define KISIPHONE6P (SCREEN_HEIGHT == 736.0)
#define KISIPHONEX (SCREEN_HEIGHT == 812.0)

#pragma mark -  获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - 获取导航栏+状态栏的高度
#define KNavAndStatusHight (KISIPHONEX?88:64)

#pragma mark - 获取导航栏的高度
#define KNavHight 44

#pragma mark - 获取状态栏的高度
#define KStatusHight ([[UIApplication sharedApplication] statusBarFrame].size.height)

#pragma mark - 获取标签栏的高度
#define KTabBarHight (KISIPHONEX?83:49)

#pragma mark - 获取安全区的高度
#define KSafeAreaHeight (KISIPHONEX?34:0)

#define is_iPhoneXSerious @available(iOS 11.0, *) && UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0


#pragma mark - 获取一般导航栏视图高度
#define KViewHeight (SCREEN_HEIGHT-KNavAndStatusHight-KTabBarHight)

#pragma mark -  获取当前时间戳
#define KCurrentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
#endif

//get the left top origin's x,y of a view
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//get the width size of the view:width,height
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//get the right bottom origin's x,y of a view
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height )

//get the x,y of the frame
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)
//get the size of the frame
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)

#pragma mark -  获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#pragma mark - 颜色相关
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:A]]
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:A]]
#define IMAGENAME(A) [UIImage imageNamed:A]
/**** 解决图片变形 ****/
#define kImgViewFix(imgView) [imgView setContentMode:UIViewContentModeScaleAspectFill];imgView.clipsToBounds = YES;


#pragma mark - 字体相关


//直接获取指定字体大小的UIFont
#define FONT_SIZE(size) [UIFont systemFontOfSize:size]

//不同设备的屏幕比例(当然倍数可以自己控制)
#define FontSizeScale ((SCREEN_HEIGHT > 568) ? SCREEN_HEIGHT/568 : 1)

//直接获取指定字体大小适配后的UIFont
#define FONT_Fit(size) [UIFont systemFontOfSize:size*FontSizeScale]
//直接获取指定字体大小适配后的粗体UIFont
#define FONT_Bold_Fit(size) [UIFont boldSystemFontOfSize:size*FontSizeScale]


#endif




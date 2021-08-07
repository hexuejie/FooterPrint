//
//  JPushNotification.m
//  Dy
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "JPushNotification.h"
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "ImportHeader.h"
#import "APPCache.h"
#import <AudioToolbox/AudioToolbox.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define jpush_mac_key   @"jpush_mac_key"

@implementation JPushMsgModel

@end

@implementation JPushNotification

static JPushNotification *jpushNotification = nil;

+(JPushNotification *) shareJPushNotification{
    @synchronized(self){
        if (jpushNotification == nil) {
            jpushNotification = [[self alloc] init];
        }
    }
    return jpushNotification;
}

-(id)init
{
    self = [super init];
    
    return self;
}

#pragma mark delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (application.applicationState == UIApplicationStateInactive) {
        [self handleNotification:notification.userInfo];
    }//消息处理
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions{
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    //本地消息处理
//    [self LocalMessageSys:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {// 关闭状态
        [self handleNotification:userInfo];
    }else{
//        [self CreateLocalnotification:userInfo];
    }// 激活或者在后台
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)  (NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //本地消息处理
//        [self LocalMessageSys:userInfo];
        //        [self CreateLocalnotification:userInfo];
    }
    else {
        // 本地通知
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self handleNotification:userInfo];
    }
    else {
        // 本地通知
    }
    
    completionHandler();  // 系统要求执行这个方法
}

#pragma mark private methods
/**
 *  注册极光服务
 *
 *  @param launchOptions
 */
-(void) registerJpushNotification : (NSDictionary *)launchOptions{
    
    [self initJpushNotification:self];
    [self registerJpush:launchOptions];
  NSString *regis =  [JPUSHService registrationID];
    NSLog(@"%@",regis);
}
/**
 *  设备登录极光服务器
 */
-(void) loginJPush{
//    [self loginJPush:[APPUserDefault getCurrentUserFromLocal].member_id];
}
/**
 *  设备登录极光服务器
 *
 *  @param alias 推送标识
 */
-(void) loginJPush :(NSString *)alias{
//    for (int i = 0; i < 100; i ++) {
//        [JPUSHService setAlias:[NSString stringWithFormat:@"%d",i] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//            NSLog(@"%ld",(long)iResCode);
//
//             } seq:0];
//    }
    
    
    if (alias) {
        NSLog(@"%@",alias);
        [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
          
            NSLog(@"ResCode =%ld",(long)iResCode);
            NSLog(@"iAlias =%@",iAlias);
            NSLog(@"seq =%ld",(long)seq);
            
            [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                if (iResCode == 0) {
                    NSLog(@"iAlias =%@",iAlias);

                }
                
                
            } seq:seq];


        } seq:0];
    }
}
/**
 *  退出现有注册
 */
-(void) logoutJPush{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:0];
}
//获取UUID
-(NSString *) getUUID{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
//极光注册回调
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias {
    NSString *callbackString = [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,tags, alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}

#pragma mark - 极光推送服务
-(void)registerJpush :(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    BOOL isProduction;
#if DEBUG
    isProduction = FALSE;
#else
    isProduction = TRUE;
#endif
    
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppkey
                          channel:@"Publish channel"
                 apsForProduction:isProduction];
}

#pragma mark 消息处理
// 处理点击通知
-(void)handleNotification:(NSDictionary *)userInfo{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (![app.window.rootViewController isKindOfClass:[UITabBarController class]]) { //没有标签栏
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //延迟五秒
            
            if ([app.window.rootViewController isKindOfClass:[UITabBarController class]]) { // 3秒在没有 ，不做处理了
                
                [self disposePushMessage:userInfo];
            }
        });
    }else{
        
        [self disposePushMessage:userInfo];
    }
}

- (void)disposePushMessage:(NSDictionary *)userInfo{
    
    NSInteger pushType = [userInfo[@"push_type"] integerValue];
    NSString *pushData = userInfo[@"data"];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取当前导航控制器
    UITabBarController  *tableBar = (UITabBarController *)app.window.rootViewController;
    UINavigationController *currentNav = tableBar.selectedViewController;
    UIViewController *currentController = currentNav.visibleViewController;
    
    //1 公告 2视频 3链接 4音频
    if (pushType == 1) {
        
        MessageDetailVC *next = [[MessageDetailVC alloc] init];
        next.messageId = pushData;
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
        [currentController presentViewController:nav animated:YES completion:nil];
    }else if(pushType == 2){
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = 1;
        next.courseId = pushData;
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
        [currentController presentViewController:nav animated:YES completion:nil];
    }else if(pushType == 3){
        
        MessageDetailVC *next = [[MessageDetailVC alloc] init];
        next.requsetUrl = pushData;
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
        [currentController presentViewController:nav animated:YES completion:nil];
    }else if(pushType == 4){
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = 2;
        next.courseId = pushData;
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
        [currentController presentViewController:nav animated:YES completion:nil];
    }
}

//创建本地消息
-(void)CreateLocalnotification :(NSDictionary *)userInfo{
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = userInfo[@"param"];
    
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber += 1;
    
    [self sendMsgOperation];
}

-(void) sendMsgOperation{
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isSoundOpen"]){
        AudioServicesPlaySystemSound(1007);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    }
}
//
//-(void)LocalMessageSys :(NSDictionary *)userInfo{
//
//    NSData *jsonData = [userInfo[@"param"] dataUsingEncoding:NSUTF8StringEncoding];
//
//    if (jsonData) {
//        NSError *err;
//        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:&err];
//        NSInteger pushType = [param[@"pushType"] integerValue];
//        JPushMsgModel * msgModel = [self getCurrentMsgFromLocal];
//        if (pushType == 1) { //活动
//            msgModel.ActiveMsgCount += 1;
//        }else if (pushType == 2){ //系统
//            msgModel.SystemMsgCount += 1;
//        }else if (pushType == 3){ //点赞
//            msgModel.LikeMsgCount += 1;
//        }else if (pushType == 4){ //评论
//            msgModel.CommentMsgCount += 1;
//        }
//        [self saveMsgToLocal:msgModel];
//    }
//}

/** 保存消息到本地 */
-(void) saveMsgToLocal:(JPushMsgModel *) msgModel{
    if (!msgModel) {
        return;
    }
    msgModel.TotalMsgCount = msgModel.ActiveMsgCount + msgModel.SystemMsgCount + msgModel.LikeMsgCount + msgModel.CommentMsgCount;
    
    [self removeCurrentMsgFromLocal];
    APPCache *cache = [[APPCache alloc] init];
    cache.cacheType = 999;
    cache.cacheJson = msgModel.mj_JSONString;
    [cache saveOrUpdate];
}

/** 获取消息 */
-(JPushMsgModel *) getCurrentMsgFromLocal{
    NSString *where = @"where cacheType=999";
    APPCache *cache = [APPCache findFirstWithFormat:where];
    if (cache != nil) {
        return [JPushMsgModel mj_objectWithKeyValues:cache.cacheJson];
    }
    return [[JPushMsgModel alloc] init];
    
}

/** 保存消息到本地 */
-(void) removeCurrentMsgFromLocal{
    NSString *where = @"where cacheType=999";
    [APPCache deleteObjectsWithFormat:where];
}

- (void)resetBadge{
    
    [JPUSHService resetBadge];
}

@end

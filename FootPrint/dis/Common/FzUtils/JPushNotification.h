//
//  JPushNotification.h
//  Dy
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "APPNotification.h"
#import "JPUSHService.h"
#import "JKDBModel.h"
@interface JPushMsgModel : JKDBModel

@property (nonatomic, assign) NSInteger ActiveMsgCount;
@property (nonatomic, assign) NSInteger SystemMsgCount;
@property (nonatomic, assign) NSInteger LikeMsgCount;
@property (nonatomic, assign) NSInteger CommentMsgCount;
@property (nonatomic, assign) NSInteger TotalMsgCount;

@end

@interface JPushNotification : APPNotification<JPUSHRegisterDelegate>

+(JPushNotification *) shareJPushNotification;

-(void) registerJpushNotification : (NSDictionary *)launchOptions;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

-(void) loginJPush;
-(void) loginJPush :(NSString *)alias;
-(void) logoutJPush;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/** 保存消息到本地 */
-(void) saveMsgToLocal:(JPushMsgModel *) msgModel;

/** 获取消息 */
-(JPushMsgModel *) getCurrentMsgFromLocal;

/** 退出登录，清空本地消息 */
-(void) removeCurrentMsgFromLocal;

-(void) resetBadge;

@end

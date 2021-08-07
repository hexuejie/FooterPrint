//
//  APPNotification.m
//  Dy
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "APPNotification.h"
#import "AppDelegate.h"

#define Notification_Jpush_Key @"Notification_Jpush_Key"
#define Notification_EaseMob_Key @"Notification_EaseMob_Key"

@implementation APPNotification

static NSMutableDictionary *notifications;

+(APPNotification *) shareAPPNotification
{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).appNotification;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void) initJpushNotification :(id)obj{
    [self initAppNotification:obj key:Notification_Jpush_Key];
}
-(void) initEaseMobNotification :(id)obj{
    [self initAppNotification:obj key:Notification_EaseMob_Key];
}

-(void) initAppNotification :(id)obj key:(NSString *)key{
    if (notifications == nil) {
        notifications = [[NSMutableDictionary alloc]init];
    }
    [notifications setObject:obj forKey:key];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    for (NSString *key in notifications) {
        [(APPNotification *)notifications[key] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}


@end

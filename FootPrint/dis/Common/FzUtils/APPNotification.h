//
//  APPNotification.h
//  Dy
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPNotification : NSObject
{
    //通知
}

+(APPNotification *) shareAPPNotification;

-(void) initJpushNotification :(id)obj;
-(void) initEaseMobNotification :(id)obj;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

@end

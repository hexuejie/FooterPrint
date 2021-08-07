//
//  AppDelegate.h
//  YXGJ
//
//  Created by YyMacBookPro on 2018/7/24.
//  Copyright © 2018年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ImportHeader.h"
#import "APPManager.h"
#import "APPNotification.h"
#import "PLPlayerView.h"
#include "AFNetworking.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,assign)AFNetworkReachabilityStatus status;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) APPManager *appManager;

@property (strong, nonatomic) MainTabBarController *mainVC;

@property (strong, nonatomic) AudioDetailVC *audioDetailVC;


@property (nonatomic, strong) APPNotification *appNotification;

// 到后台流逝的时间
@property (assign, nonatomic) NSInteger timeGone;
/*是否可以横屏**/
@property(nonatomic,assign) BOOL allowRotation;

@property (nonatomic, strong) PLPlayerView *playerView;


@property(nonatomic,assign) BOOL portiaint;


@property(nonatomic,assign) BOOL allowShow404;
@property(nonatomic,strong) NSString *registrationID;



@end


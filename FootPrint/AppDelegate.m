//
//  AppDelegate.m
//  YXGJ
//
//  Created by YyMacBookPro on 2018/7/24.
//  Copyright © 2018年 cscs. All rights reserved.
//

#import "AppDelegate.h"
#import "ImportHeader.h"
#import <UMCommon/UMCommon.h>
#import "UIAlertController+Blocks.h"
#import <UMCommonLog/UMCommonLogHeaders.h>
#import "OpenShare.h"
#import "OpenShareHeader.h"
#import "JPushNotification.h"
#import "WXApi.h"
//#import "JSHAREService.h"
#import <PLPlayerKit/PLPlayerKit.h>
#import "YCDownloadSession.h"
#import "CourseDetailModel.h"
#import "CoreStatus.h"
#import "PayModel2.h"
#import <Bugly/Bugly.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate ()<WXApiDelegate>

@property (strong, nonatomic) NSDate *goBackgroundDate;


@end

@implementation AppDelegate

static UIApplication * application = nil;

+(UIApplication *)shareInstance{
    
    if(application == nil){
        
        application= [[UIApplication alloc]init];
    }
    return application;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.allowShow404 = YES;
    [Bugly startWithAppId:@"80af4b761d"];
    
    
    // 后台播放逻辑
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

    [[UIApplication  sharedApplication] beginReceivingRemoteControlEvents];
    AudioDetailVC *a = [[AudioDetailVC alloc] init];
    self.audioDetailVC = a;
    
    //后台播放显示信息设置
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:@"isOneTrafficPlay"];
    [user setObject:[CoreStatus currentNetWorkStatusString] forKey:@"networkStatus"];
    
    [user synchronize];
    
    self.playerView = [[PLPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*14/25)];
    self.playerView.thumbImageView.image = [UIImage imageNamed:@"mydefault"];
    self.appManager = [[APPManager alloc] init];
    
    //注册微信三方平台
    [OpenShare connectWeixinWithAppId:kWXAppId miniAppId:@""];
    [OpenShare connectQQWithAppId:kQQAppId];
    // Appkey：5f642748b473963242a20854
    
    //        JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    //    config.appKey = @"e40bb445da3aa1210d221f6d";
    //                    config.WeChatAppSecret = kWXAppSecreat;
    //
    //    config.WeChatAppId = kWXAppId;
    //    config.universalLink = @"https://www.92zhiqu.com/app/";
    //        [JSHAREService setupWithConfig:config];
    //    [JSHAREService setDebug:YES];
    
    
//    [UMConfigure initWithAppkey:@"" channel:@"App Store"];

   
    [UMConfigure initWithAppkey:@"5f9005bcfac90f1c19a888cb" channel:@"App Store"];
    //开发者需要显式的调用此函数，日志系统才能工作
//       [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
    //开发者需要显式的调用此函数，日志系统才能工作
//     [UMCommonLogManager setUpUMCommonLogManager];
    
    //此函数在UMCommon.framework版本1.4.2及以上版本，在UMConfigure.h的头文件中加入。
    //如果用户用组件化SDK,需要升级最新的UMCommon.framework版本。
//    NSString * deviceID =[UMConfigure deviceIDForIntegration];
//    NSLog(@"集成测试的deviceID:%@", deviceID);

  BOOL ba =  [AVAudioSession canPlayInBackground];
    NSLog(@"%d",ba);
    
    
//    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
//        NSLog(@"WeChatSDKLog:%@",log);
//    }];
    //务必在调用自检函数前注册
    
    
    [WXApi registerApp:kWXAppId
         universalLink:@"https://yk.jiaoyin.vip/app/"];
    
    //调用自检函数
//    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
//        NSLog(@"%@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
//        NSLog(@"god bless");
//        
//
//    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MksChangeStatus) name:kNotification_CheckStateChange object:nil];
    
    
    
    
    // 只要不是no，就是审核状态
    
    
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"APP_FIRST_START"] > 0) {
        [self showMianViewController];
    }else{
        FzPageVC *next = [[FzPageVC alloc] init];
        next.hidesBottomBarWhenPushed = YES;
        next.finishPageBlock = ^(void){
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"APP_FIRST_START"];
            
            [self showMianViewController];
        };
        self.window.rootViewController = next;
        
    }
    
    if (self.appNotification == nil) {
        self.appNotification = [[APPNotification alloc]init];
    }
    
    //初始化极光推送
    [[JPushNotification shareJPushNotification] registerJpushNotification:launchOptions];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name:kNotification_LoginStateChange object:nil];
    
    //注册通知
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    WS(weakself)
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
      if(resCode == 0){
        NSLog(@"registrationID获取成功：%@",registrationID);
          weakself.registrationID = registrationID;
          [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
          [[NSUserDefaults standardUserDefaults] synchronize];
      }
      else{
        NSLog(@"registrationID获取失败，code：%d",resCode);
      }
    }];
    //
    //        [self confitUShareSettings];
    //       [self configUSharePlatforms];
    
    
    
    [self getHotKeyword];
    
    //setup downloadsession
    [self setUpDownload];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMianViewController) name:kNotification_LoginOut object:nil];
    
    return YES;
}


- (void)getHotKeyword {
    [APPRequest GET:@"/getHotKeyword" parameters:@{} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            if (result.data) {
                if (result.data[@"search"]) {
                    NSString *name = result.data[@"search"][@"name"];
                    [[NSUserDefaults standardUserDefaults] setObject:name forKey:kHotName];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_UpdateHot object:nil];
                }
            }
            
            
          
        }
    }];
}



//- (void)confitUShareSettings {
//    [UMConfigure initWithAppkey:@"5f642748b473963242a20854" channel:nil];
//
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = YES;
//      //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
//
//    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://www.92zhiqu.com/app/"
//
//                                                        };
//}
//- (void)configUSharePlatforms
//
//{
//
////    [UMConfigure initWithAppkey:@"5f642748b473963242a20854" channel:@"App Store"];
//    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWXAppId appSecret:kWXAppSecreat redirectURL:@"https://www.92zhiqu.com"];
//
//}
//-(void)setBackgroundPlayMusic
//{
//    //获取音频会话
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//
//   //设置后台播放
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    //激活会话
//    [session setActive:YES error:nil];
//    [self setLockScreenInfo];
//}
///设置锁屏信息
-(void)setLockScreenInfo
{
    // MPMediaItemPropertyAlbumTitle
    // MPMediaItemPropertyAlbumTrackCount
    // MPMediaItemPropertyAlbumTrackNumber
    // MPMediaItemPropertyArtist
    // MPMediaItemPropertyArtwork
    // MPMediaItemPropertyComposer
    // MPMediaItemPropertyDiscCount
    // MPMediaItemPropertyDiscNumber
    // MPMediaItemPropertyGenre
    // MPMediaItemPropertyPersistentID
    // MPMediaItemPropertyPlaybackDuration
    // MPMediaItemPropertyTitle

    //获取锁屏中心
    MPNowPlayingInfoCenter *playCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    //设置歌曲名
    infoDict[MPMediaItemPropertyAlbumTitle] = @"测试";
    //设置歌手名
    infoDict[MPMediaItemPropertyArtist] = @"周杰伦";
    //设置图片
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:@"80_80"]];
    
    infoDict[MPMediaItemPropertyArtwork] = artWork;
    //设置总时长
    infoDict[MPMediaItemPropertyPlaybackDuration] = @(20);
    
    playCenter.nowPlayingInfo = infoDict;
   
}
//响应远程音乐播放控制消息

- (void)remoteControlReceivedWithEvent:(UIEvent*)event
{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                // *播放和暂停切换
                NSLog(@"播放");
                [self.playerView play];
//                if (self.playerView.player.status == PLPlayerStatusPlaying) {
//                    [self.playerView.player pause];
//                } else {
//
//                }
                break;
           case UIEventSubtypeRemoteControlPreviousTrack:
                // *播放上一曲按钮
                NSLog(@"播放上一曲按钮");
                [self.audioDetailVC lastPlayerModel];

                break;
           case UIEventSubtypeRemoteControlNextTrack:
                // *播放下一曲按钮
                NSLog(@"播放下一曲按钮");
                [self.audioDetailVC nextPlayerModel];
                break;
         case UIEventSubtypeRemoteControlPause:
                // * 暂停
                NSLog(@"暂停按钮");
                [self.playerView pause];

                break;
            default:
                break;
        }
    }
}
- (void)showMianViewController {
    if (self.playerView.player.status == PLPlayerStatusPlaying) {
        [self.playerView.player stop];
    }
    
    self.mainVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = self.mainVC;
    
}
- (void)setUpDownload {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    path = [path stringByAppendingPathComponent:@"download"];
    YCDConfig *config = [YCDConfig new];
    config.saveRootPath = path;
    config.uid = @"100006";
    config.maxTaskCount = 1;
    config.taskCachekMode = YCDownloadTaskCacheModeKeep;
    config.launchAutoResumeDownload = true;
    [YCDownloadManager mgrWithConfig:config];
    [YCDownloadManager allowsCellularAccess:KIsTrafficDownLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadTaskFinishedNoti:) name:kDownloadTaskFinishedNoti object:nil];
}

- (void)downloadTaskFinishedNoti:(NSNotification *)noti{
    YCDownloadItem *item = noti.object;
    if (item.downloadStatus == YCDownloadStatusFinished) {
        CoursePlayerFootModel *mo = [CoursePlayerFootModel infoWithData:item.extraData];
        NSString *detail = [NSString stringWithFormat:@"%@已经下载完成！", mo.title];
        [self localPushWithTitle:@"YCDownloadSession" detail:detail];
    }
}

- (void)localPushWithTitle:(NSString *)title detail:(NSString *)body  {
    
    if (title.length == 0) return;
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    localNote.alertBody = body;
    localNote.alertAction = @"滑动来解锁";
    localNote.hasAction = NO;
    localNote.soundName = @"default";
    localNote.userInfo = @{@"type" : @1};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    [[YCDownloader downloader] addCompletionHandler:completionHandler identifier:identifier];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    [[JPushNotification shareJPushNotification] application:application didReceiveLocalNotification:notification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [[JPushNotification shareJPushNotification] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult completionHandler) {
    }];
}


// 横屏或者竖屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {

    if (self.allowRotation) {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    //      [JSHAREService handleOpenUrl:userActivity.webpageURL];
    // if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
    //        // 其他SDK的回调
    //    }
    //    return YES;
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
    
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)  (NSInteger))completionHandler {
    
    [[JPushNotification shareJPushNotification] jpushNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)(void))completionHandler {
    
    [[JPushNotification shareJPushNotification] jpushNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [self.appNotification application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"token获取不到原因：%@",error.description);
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    //    if (!result) {
    //        // 其他如支付等SDK的回调
    //    }
    //    return result;
    return  [WXApi handleOpenURL:url delegate:self];
    
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //      BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    //    if (!result) {
    //         // 其他如支付等SDK的回调
    //    }
    //    return result;
    return [WXApi handleOpenURL:url delegate:self];
}





-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSString *urlStr = [url absoluteString];
    
    
    if ([url.host isEqualToString:@"safepay"] || [urlStr isEqualToString:Wechat_Jump]) {
        
        
        if ([PayModel2 sharedInstance].order_sn.length>0) {
            
            [APPRequest GET:@"/orderStatus" parameters:@{@"order_sn":[PayModel2 sharedInstance].order_sn} finished:^(AjaxResult *result) {
                
                if (result.code == AjaxResultStateSuccess) {
                    
                    NSInteger status = [result.data integerValue];
                    
                    if (status == 1 || status == 2) { //成功
                        [self toFinishOrder];
                        
                    }else{ //未付款
                        
                        [KeyWindow showTip:@"订单支付失败！"];
                    }
                }
            }];
        }
        
        //
        //        //  拿到这个链接的数据，数据大概是这样的
        //        //  然后，一样的套路方法
        //        NSString * urlNeedJsonStr = url.absoluteString;
        //        NSArray * afterComStr = [urlNeedJsonStr componentsSeparatedByString:@"?"];
        //        //  这个decode方法，在上面找哈
        //        NSString * lastStr = [self URLDecodedString:afterComStr.lastObject];
        //        //  这个lastStr，其实是一个jsonStr，转一下，就看到了数据
        //        NSDictionary * dict = [self  dictionaryWithJsonString:lastStr];
        //
        //  dict的结构差不多是这样
        /*
         "memo": {
         "result":"订单相关信息，如订单号，支付金额等等";
         "ResultStatus":"9000";
         },
         ******
         */
        
        //  9000 ：支付成功
        //  8000 ：订单处理中
        //  4000 ：订单支付失败
        //  6001 ：用户中途取消
        //  6002 ：网络连接出错
        //  这里的话，就可以根据状态，去处理自己的业务了
        
    }
    
    //    [JSHAREService handleOpenUrl:url];
    if ([url.absoluteString containsString:@"Weixinauth"]) {
        return [self.appManager application:app openURL:url options:options];
    }
    return YES;
}

- (void)toFinishOrder{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UITabBarController *tableBar = (UITabBarController *)window.rootViewController;
    //获取当前导航控制器
    UINavigationController *currentNav = tableBar.selectedViewController;
    AddOrderVC *currentController = (AddOrderVC *)currentNav.visibleViewController;
    
    PayCompleteVC *next = [[PayCompleteVC alloc] init];
    next.order_sn = currentController.order_sn;
    [currentController.navigationController pushViewController:next animated:YES];
    
//        TogetcherVC *next = [[TogetcherVC alloc] init];
//        next.order_sn = currentController.order_sn;
//        [currentController.navigationController pushViewController:next animated:YES];
    
}

- (NSString*)URLDecodedString:(NSString*)str {
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

-  (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.window endEditing:YES];
    self.goBackgroundDate = [NSDate date];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"");
    if (self.playerView.currentIsFullScreen) {
        NSLog(@"要进全屏");
    }
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // playerView
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //桌面消息数量
    application.applicationIconBadgeNumber = 0;
    [[JPushNotification shareJPushNotification] resetBadge];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.timeGone = [[NSDate date] timeIntervalSinceDate:self.goBackgroundDate];
    if (self.playerView.currentIsFullScreen > 0) {
        NSLog(@"要去全屏了");
        [self performSelector:@selector(goToFullScreen) withObject:self afterDelay:0.06];
    }
    

}
- (void)goToFullScreen {
    if (self.playerView.currentIsFullScreen == 1) {
        [self.playerView transformWithOrientation:UIDeviceOrientationLandscapeLeft];

    } else if (self.playerView.currentIsFullScreen == 2) {
        [self.playerView transformWithOrientation:UIDeviceOrientationLandscapeRight];

    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

//- (void)loginStatusChanged{
//
//    if ([CoreStatus isNetworkEnable]) { //有网络
//
//        [APPRequest GET:@"/appAudit" parameters:nil finished:^(AjaxResult *result) { //获取审核状态
//
//            if (result.code == AjaxResultStateSuccess) {
//
//                NSString *audit = result.data;
//
//                [APPRequest GET:@"/version" parameters:nil finished:^(AjaxResult *result) { //在获取版本号
//
//                    if (result.code == AjaxResultStateSuccess) {
//
//                        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//                        // app版本号
//                        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//                        // 后台版本号
//                        NSString *version = result.data[@"v"];
//
//                        if ([audit isEqualToString:@"yes"]) {
//
//                            if (![version isEqualToString:app_Version]) {
//
//                                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                                [user setObject:@"yes" forKey:@"is_audit"];
//                                [user synchronize];
//                            }else{
//
//                                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                                [user setObject:@"no" forKey:@"is_audit"];
//                                [user synchronize];
//                            }
//                        }
//
//                        else{
//
//                            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                            [user setObject:@"no" forKey:@"is_audit"];
//                            [user synchronize];
//                        }
//
////                        if (Ktoken) {
////                            self.mainVC = [[MainTabBarController alloc] init];
////                            self.window.rootViewController = self.mainVC;
////                        }
//
//
////                        else{
//
////
//
////
//}

- (void)MksChangeStatus{
    // 如果不是审核状态，为yes说明不是审核状态，就不用调这个接口
    if ([isAudit isEqualToString:@"no"]) {
        return;
    }
    
    if ([CoreStatus isNetworkEnable]) { //有网络
        NSDictionary *param = @{
            @"version_type":@"ios"
        };
         
        [APPRequest GET:@"/version" parameters:param finished:^(AjaxResult *result) { //在获取版本号
            
            if (result.code == AjaxResultStateSuccess) {
                
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app版本号
                NSString *now_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                // 后台版本号
                NSString *lineVersion = result.data[@"v"];
                NSLog(@"now=%@,line=%@",now_Version,lineVersion);
                //  现在大于线上 为true 如果当前大于线上，说明是 check状态
                
                BOOL checkStatus  = [self compareVersion:lineVersion current:now_Version];
//                checkStatus = NO;
                if (!checkStatus) {
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    // 储存为非审核状态
                    [user setObject:@"no" forKey:@"is_audit"];
                    
                    [user synchronize];
                }
                else {
                    
                }
            }
            
        }];
        
    }
    
}


#pragma mark 比较版本
- (BOOL)compareVersion:(NSString *)lineStr current:(NSString *)nowStr{
    NSMutableArray * lineAry =[NSMutableArray arrayWithArray: [lineStr componentsSeparatedByString:@"."]];
    NSMutableArray * nowAry =[NSMutableArray arrayWithArray:[nowStr componentsSeparatedByString:@"."]];
    if(lineAry.count>nowAry.count){
        while (nowAry.count<lineAry.count) {
            [nowAry addObject:@"0"];
        }
    }else if(nowAry.count > lineAry.count){
        while (lineAry.count < nowAry.count) {
            [lineAry addObject:@"0"];
        }
    }
    
    for(int i=0;i<nowAry.count;i++){
        int nowVal = [[nowAry objectAtIndex:i] intValue];
        int lineVal = [[lineAry objectAtIndex:i] intValue];
        if(nowVal == lineVal){
            continue;
        }
        if(nowVal>lineVal){
            return YES;
        }else{
            return NO;
        }
        
    }
    return NO;
    
    
    
    
    
    
}



#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
        //            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        //            [_delegate managerDidRecvMessageResponse:messageResp];
        //        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
        //            SendAuthResp *authResp = (SendAuthResp *)resp;
        //            [_delegate managerDidRecvAuthResponse:authResp];
        //        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
        //            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
        //            [_delegate managerDidRecvAddCardResponse:addCardResp];
        //        }
    } else if ([resp isKindOfClass:[WXChooseCardResp class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvChooseCardResponse:)]) {
        //            WXChooseCardResp *chooseCardResp = (WXChooseCardResp *)resp;
        //            [_delegate managerDidRecvChooseCardResponse:chooseCardResp];
        //        }
    }else if ([resp isKindOfClass:[WXChooseInvoiceResp class]]){
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvChooseInvoiceResponse:)]) {
        //            WXChooseInvoiceResp *chooseInvoiceResp = (WXChooseInvoiceResp *)resp;
        //            [_delegate managerDidRecvChooseInvoiceResponse:chooseInvoiceResp];
        //        }
    }else if ([resp isKindOfClass:[WXSubscribeMsgResp class]]){
        //        if ([_delegate respondsToSelector:@selector(managerDidRecvSubscribeMsgResponse:)])
        //        {
        //            [_delegate managerDidRecvSubscribeMsgResponse:(WXSubscribeMsgResp *)resp];
        //        }
    }else if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]]){
        //        if ([_delegate respondsToSelector:@selector(managerDidRecvLaunchMiniProgram:)]) {
        //            [_delegate managerDidRecvLaunchMiniProgram:(WXLaunchMiniProgramResp *)resp];
        //        }
    }else if([resp isKindOfClass:[WXInvoiceAuthInsertResp class]]){
        //        if ([_delegate respondsToSelector:@selector(managerDidRecvInvoiceAuthInsertResponse:)]) {
        //            [_delegate managerDidRecvInvoiceAuthInsertResponse:(WXInvoiceAuthInsertResp *) resp];
        //        }
    }
    
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
        //            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
        //            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        //        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        //        if (_delegate
        //            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
        //            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
        //            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        //        }
    }
}

@end

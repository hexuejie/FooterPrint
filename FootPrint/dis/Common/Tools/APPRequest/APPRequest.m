//
//  APPRequest.m
//  接口请求
//
//  Created by Silence on 17/1/11.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "APPRequest.h"
#import "AFNetworkUtils.h"
#import "ImportHeader.h"
#import "SilenceImageAssets.h"
#import "UIAlertController+Blocks.h"
#import "JPushNotification.h"
@implementation APPRequest

+(void)GET:(NSString *)URLString parameters:(NSDictionary *)dicParam finished:(void (^)(AjaxResult *result))block{
    dicParam = [APPRequest sign:URLString parameters:dicParam];
    NSString *str = APP_ACTION(URLString);
    if ([URLString hasPrefix:@"http"]) {
        str = URLString;
    }
#if DEBUG
    
    NSLog(@"请求地址：%@",[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:str parameters:dicParam error:nil]);
#endif
    [AFNetworkUtils GET:str parameters:dicParam callBackBlock:^(BOOL success, NSURLSessionDataTask *task, id responseObject, NSError *error) {
        [APPRequest handleAjaxResult:success task:task data:responseObject error:error finished:block];
    }];
}

+(void)POST:(NSString *)URLString parameters:(NSDictionary *)dicParam finished:(void (^)(AjaxResult *result))block{
    dicParam = [APPRequest sign:URLString parameters:dicParam];
    NSString *str = APP_ACTION(URLString);
    if ([URLString hasPrefix:@"http"]) {
        str = URLString;
    }
#if DEBUG
    NSLog(@"请求地址：%@",[[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:str parameters:dicParam error:nil]);
#endif
//    if ([URLString containsString:@"update"]) {
//        str = @"";
//       }
    NSLog(@"%@",str);
    NSLog(@"%@",dicParam);

    [AFNetworkUtils POST:str parameters:dicParam callBackBlock:^(BOOL success, NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        [APPRequest handleAjaxResult:success task:task data:responseObject error:error finished:block];
    }];
}

+(void)POSTImage:(NSString *)URLString parameters:(NSDictionary *)dicParam andImages:(NSArray<UIImage *> *)images finished:(void (^)(AjaxResult *result))block{
    dicParam = [APPRequest sign:URLString parameters:dicParam];
    NSString *str = APP_ACTION(URLString);
    if ([URLString hasPrefix:@"http"]) {
        str = URLString;
    }
#if DEBUG
    NSLog(@"请求地址：%@",[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:str parameters:dicParam error:nil]);
#endif
    [AFNetworkUtils POSTBody:str parameters:dicParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (images && [images count] > 0) {
            for (NSInteger index = 0; index < images.count; index++) {
                
                NSData *data = UIImageJPEGRepresentation(images[index], 0.5);

                [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"img%ld.png",index] mimeType:@"image/png"];
            }
        }
    } callBackBlock:^(BOOL success, NSURLSessionDataTask *task, id responseObject, NSError *error) {
        [APPRequest handleAjaxResult:success task:task data:responseObject error:error finished:block];
    }];
}

+(void)POSTImage:(NSString *)URLString parameters:(NSDictionary *)dicParam andImages:(NSArray<UIImage *> *)images andImageNames:(NSArray<NSString *> *)imageNames finished:(void (^)(AjaxResult *result))block{
    dicParam = [APPRequest sign:URLString parameters:dicParam];
    NSString *str = APP_ACTION(URLString);
    if ([URLString hasPrefix:@"http"]) {
        str = URLString;
    }
#if DEBUG
    NSLog(@"请求地址：%@",[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:str parameters:dicParam error:nil]);
#endif
    [AFNetworkUtils POSTBody:str parameters:dicParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (images && [images count] > 0) {
            for (NSInteger index = 0; index < images.count; index++) {
                
                NSData *data = UIImagePNGRepresentation(images[index]);
                if (data == nil) {
                    data = UIImageJPEGRepresentation(images[index], 1.0);
                }
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@",imageNames[index]] fileName:[NSString stringWithFormat:@"%@.jpg",imageNames[index]] mimeType:@"image/png"];
            }
        }
    } callBackBlock:^(BOOL success, NSURLSessionDataTask *task, id responseObject, NSError *error) {
        [APPRequest handleAjaxResult:success task:task data:responseObject error:error finished:block];
    }];
}

+(void)handleAjaxResult:(BOOL)success task:(NSURLSessionDataTask *)task data:(id)responseObject error:(NSError *)error finished:(void (^)(AjaxResult *result))block{
    
    AjaxResult *result = [[AjaxResult alloc] init];
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    
    UITabBarController *tableBar = [[UITabBarController alloc] init];
    //获取当前导航控制器
    if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        tableBar = (UITabBarController *)window.rootViewController;
    }
    UINavigationController *currentNav = [[UINavigationController alloc] init];
    BaseVC *currentController = [[BaseVC alloc] init];
    if (tableBar.viewControllers.count != 0) {
     
        currentNav = tableBar.selectedViewController;
        currentController = (BaseVC *)currentNav.visibleViewController;
    }
    // 调到第一次安装指导控制器
    if ([window.rootViewController isKindOfClass:[FzPageVC class]]) {
        currentController = (FzPageVC *)window.rootViewController;
    }
    
    if (success) {
        
        result = [AjaxResult mj_objectWithKeyValues:responseObject];
    }else{
     
        if (!responseObject) {
            
            result.code = 888;
        }
    }
    result.originDatas = responseObject;
    block(result);
    if (result.code == AjaxResultStateNetFail) { //网络请求失败
        
        if ([currentController isKindOfClass:[CourseDetailVC class]]) {
          
            return;
        }
        [currentController showEmptyView:EmptyViewTypeNetFail eventBlock:^(EmptyViewEventType eventType) {
           
            [currentController hideEmptyView];
            [currentController loadData];
        }];
    }else if (result.code == AjaxResultStateTokenError || result.code == AjaxResultStateUserError){
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"token"];
        [user synchronize];
        [APPUserDefault removeCurrentUserFromLocal];
        [[JPushNotification shareJPushNotification] logoutJPush];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LoginStateChange object:nil];
    }else if (result.code != AjaxResultStateSuccess) {
        [KeyWindow showFailTip:result.message];
    }
#if DEBUG
    NSLog(@"%@",responseObject);
#endif
}

//处理签名
+(NSDictionary *)sign:(NSString *)signKey parameters:(NSDictionary *)dicParam{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setDictionary:dicParam];

    if (Ktoken) {

        [param setObject:Ktoken forKey:@"jwt_token"];
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [param setObject:app_Version forKey:@"v"];
    
    
    
    
     
    return param;
}


@end

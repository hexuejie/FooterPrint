//
//  WXLoginVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/20.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "WXLogInVC.h"
#import "OpenShare.h"
#import "OpenShareHeader.h"
#import "JPushNotification.h"
#import "WXApi.h"
#import "PrivacyPolicyVC.h"
#import "BindVC.h"
@interface WXLogInVC ()

@end

@implementation WXLogInVC
- (void)leftButtonClicked {
    [self.navigationController popViewControllerAnimated:true];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
    self.leftButton.hidden = false;
    self.selectBtn.selected = YES;
    
    [self.selectBtn setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateSelected];
    [self.selectBtn setImage:[UIImage imageNamed:@"login_defu"] forState:UIControlStateNormal];
    
    [self setBack];
}
- (void)setBack{
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, KStatusHight + 10, 30, 30);
    [btn setImage:[UIImage imageNamed:@"ic_return"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.view addSubview:btn];
    
}
  
- (void)viewDidLoad {
    [super viewDidLoad];
    //placeholder_method_call//
  
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];

}
//placeholder_method_impl//

//微信登录
- (IBAction)btnWXLoginClick:(id)sender {
    NSLog(@"WXLogin");
    if (!self.selectBtn.selected) {
        [KeyWindow showTip:@"请同意用户协议"];
        return;
    }
    //placeholder_method_call//
//
//    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    WXApi sendReq:req completion:^(BOOL success) {
//
//    }
/*
 {
     "jwt_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IntcInVpZFwiOjM1MDQsXCJsb2dpbl90aW1lXCI6MTYxOTU3Nzk2OH0i.V_GVQSYs5ByP-8E-4ymtn1NWS0S4JKbe28DEDOd7pYQ";
     uname = 5f83fcccca69c105;
 }
 */
    WS(weakself)
    [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
        if([[message allKeys] containsObject:@"code"]){
            [KeyWindow showLoadingHUD];
            [APPRequest POST:@"/wechatLogin" parameters:@{@"code":message[@"code"]} finished:^(AjaxResult *result) {
                [KeyWindow hiddenLoading];
                if (result.code == AjaxResultStateSuccess) {
                    
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:result.data[@"uname"]  forKey:@"uname"];
                    [user synchronize];
                   
                    if([result.data[@"mobile_bind"] intValue] == 0 ) {
                        
                        BindVC *next = [[BindVC alloc] init];
                        next.jwt_token = result.data[@"jwt_token"];
                        next.bindStatus = 0;
                        next.BlockBackClick = ^{
                          
                            [self loadData];
                        };
                        [weakself.navigationController pushViewController:next animated:YES];
                        return;
                    }
                    [user setObject:result.data[@"jwt_token"] forKey:@"token"];
                    [user synchronize];
                    
                    [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {

                        if (result.code == AjaxResultStateSuccess) {

                            UserModel *user = [UserModel mj_objectWithKeyValues:result.data];
                            [[JPushNotification shareJPushNotification] loginJPush:user.user.uid];
                        }
                    }];
                    [weakself addPush];
                 [self.navigationController popViewControllerAnimated:true];

                }
            }];
        }
    } Fail:^(NSDictionary *message, NSError *error) {
        
        [KeyWindow showTip:@"认证失败"];
    }];
}
- (void)addPush {
//    registrationID
    

   NSString *registrationID = [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
    if (registrationID) {
        NSMutableDictionary *param = @{
            @"registration_id":registrationID
         }.mutableCopy;
        
        [APPRequest POST:@"/jiguang/registration" parameters:param finished:^(AjaxResult *result) {

            if (result.code == AjaxResultStateSuccess) {

               
            }
        }];
    }
    
  
}

//placeholder_method_impl//

//游客登录
- (IBAction)btnTouristsClick:(id)sender {
    //placeholder_method_call//

//
//    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
//    UIWindow *window =  [[UIApplication sharedApplication] keyWindow];
//    window.rootViewController = mainVC;
}
//placeholder_method_impl//

- (IBAction)seletAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)protocalActionClick:(UIButton *)sender {
    PrivacyPolicyVC *next = [[PrivacyPolicyVC alloc] init];
    next.index = 2;
    BaseNavViewController *nextNav = [[BaseNavViewController alloc] initWithRootViewController:next];
    [self presentViewController:nextNav animated:YES completion:nil];
    
}
@end

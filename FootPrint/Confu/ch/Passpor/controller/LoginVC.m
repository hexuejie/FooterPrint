//
//  LoginVC.m
//  Zhongsheng
//
//  Created by 陈小卫 on 17/6/6.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "LoginVC.h"
#import "NSString+RegexCategory.h"
#import "JPushNotification.h"
#import "RegisterVC.h"
#import "PrivacyPolicyVC.h"
#import "UUIDTool.h"
@interface LoginVC ()
@property (nonatomic, assign)BOOL isReading;

@end

@implementation LoginVC

#pragma mark - 飞卓类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftButton.hidden = NO;
    
    CGFloat Footheight = 50;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-Footheight-KSafeAreaHeight, SCREEN_WIDTH, Footheight)];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Footheight)];
    lblTitle.hidden = NO;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"北京脚印互动科技有限公司";
    lblTitle.font = [UIFont systemFontOfSize:13.0];
    //placeholder_method_call//

    lblTitle.textColor = RGB(192, 196, 204);
    [footerView addSubview:lblTitle];
    
    [self.view addSubview:footerView];
    [self.btnArragement addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
          
          PrivacyPolicyVC *next = [[PrivacyPolicyVC alloc] init];
          next.index = 1;
          BaseNavViewController *nextNav = [[BaseNavViewController alloc] initWithRootViewController:next];
          [self presentViewController:nextNav animated:YES completion:nil];
      }];
    [self.btnarragement2 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            PrivacyPolicyVC *next = [[PrivacyPolicyVC alloc] init];
            next.index = 2;
            BaseNavViewController *nextNav = [[BaseNavViewController alloc] initWithRootViewController:next];
            [self presentViewController:nextNav animated:YES completion:nil];
        }];
    
    [self.txtPhone addTarget:self action:@selector(textPhoneTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.txtPwd addTarget:self action:@selector(textPwdTextChange:) forControlEvents:UIControlEventEditingChanged];
    
   
    
}
//placeholder_method_impl//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//
#pragma mark - 代理

#pragma mark 系统代理

#pragma mark - 直接添加监听方法

-(void)textPhoneTextChange:(UITextField *)textField{
    
    if (textField.text.length > 0 && self.txtPwd.text.length > 0) {
        //placeholder_method_call//

        self.btnLogin.backgroundColor = RGB(4, 134, 254);
    }else{
        
        self.btnLogin.backgroundColor = RGB(131, 193, 254);
    }
}
//placeholder_method_impl//
- (void)textPwdTextChange:(UITextField *)textField{

    if (textField.text.length > 0 && self.txtPhone.text.length > 0) {
        //placeholder_method_call//

        self.btnLogin.backgroundColor = RGB(4, 134, 254);
    }else{
        
        self.btnLogin.backgroundColor = RGB(131, 193, 254);
    }
}
//placeholder_method_impl//
#pragma mark 自定义代理

#pragma mark - 事件

- (IBAction)goingToProtocolAction:(UIButton *)sender {
    
    
    
}

- (IBAction)selectAction:(UIButton *)sender {
     sender.selected =! sender.selected;
    //placeholder_method_call//
    if (sender.selected) {
        
        self.isReading = YES;
        [sender setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];
    }else{
        
        self.isReading = NO;
        [sender setImage:[UIImage imageNamed:@"login_defu"] forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)btnRegistClick:(id)sender {
    
    RegisterVC *next = [[RegisterVC alloc] init];
    //placeholder_method_call//

    [self.navigationController pushViewController:next animated:true];
}
//placeholder_method_impl//
- (IBAction)btnLoginClick:(id)sender{
     if (!self.isReading) {
        
        [KeyWindow showTip:@"请阅读并同意《用户服务协议》"];
        return;
    }

    if ([self.txtPhone.text isNilOrEmpty]) {
        
        [self.view showTip:@"手机号不能为空"];
        return;
    }
    if (![self.txtPhone.text isMobileNumber]) {
        
        [self.view showTip:@"手机号码格式不正确"];
        return;
    }
    if ([self.txtPwd.text isNilOrEmpty]) {
     
        [self.view showTip:@"登录密码不能为空"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.txtPhone.text forKey:@"uname"];
    [param setObject:self.txtPwd.text forKey:@"password"];

    [self.view showLoadingHUD];
    //placeholder_method_call//
    
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //        NSInteger goldInt = [[user objectForKey:@"gold"] integerValue];
    //        NSString *goldText = [NSString stringWithFormat:@"%ld",(long)goldInt];
            NSString *gold = [user objectForKey:@"gold"];
    if (gold != nil) {
        [param setObject:gold forKey:@"gold"];
    } else {
        [param setObject:@"0" forKey:@"gold"];

    }
    WS(weakself)
    [APPRequest POST:@"/accountLogin" parameters:param finished:^(AjaxResult *result) {
        
        [self.view hiddenLoading];
        if (result.code == AjaxResultStateSuccess) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            // 登陆后将本地的数据学习币清空
            [user setObject:@"0" forKey:@"gold"];
            
            [user setObject:result.data[@"jwt_token"] forKey:@"token"];
            [user synchronize];
            
            [weakself getinfo];

        }
    }];
}

- (IBAction)tourAction:(UIButton *)sender {
    NSString *uuidStr = [UUIDTool getUUIDInKeychain];

NSDictionary *param = @{
    @"unique_id":uuidStr
};
    
    WS(weakself)
    [APPRequest POST:@"/guestLogin" parameters:param finished:^(AjaxResult *result) {
        
//        [self.view hiddenLoading];
        if (result.code == AjaxResultStateSuccess) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            // 登陆后将本地的数据学习币清空
            
            
            [user setObject:result.data[@"jwt_token"] forKey:@"token"];
            [user setObject:@"KTour" forKey:@"KTour"];
            [user synchronize];
            [weakself getinfo];
             
           

        }
    }];
    
}
- (void)getinfo {
    [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            UserModel *user = [UserModel mj_objectWithKeyValues:result.data];
            [[JPushNotification shareJPushNotification] loginJPush:user.user.uid];
            [self.navigationController popViewControllerAnimated:true];

        }
    }];
}

#pragma mark - 公开方法

+(void) logout{
    [APPUserDefault removeCurrentUserFromLocal];

    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LoginStateChange object:nil];
}

#pragma mark - 私有方法
#pragma mark  - 第三方登录

#pragma mark - get set

@end

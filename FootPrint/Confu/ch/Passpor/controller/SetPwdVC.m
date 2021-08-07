//
//  GetPwdVC.m
//  Zhongsheng
//
//  Created by YyMacBookPro on 2017/6/15.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "SetPwdVC.h"
#import "NSString+Extension.h"
#import "NSString+RegexCategory.h"

@interface SetPwdVC (){
    
    NSTimer *timer;
    NSInteger countTimer;
}

@end

@implementation SetPwdVC

#pragma mark - 飞卓类注释逻辑

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//


#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 事件

- (IBAction)btnCodeClick:(id)sender {
    
    if([self.txtPhone.text isNullOrEmpty]){
//        [SilenceHUDUtil showInfo:@"请输入手机号码"];
        return;
    }
    if (![self.txtPhone.text isMobileNumber]) {
//        [SilenceHUDUtil showInfo:@"手机号码格式不正确"];
        return;
    }
    //placeholder_method_call//

//    [SilenceHUDUtil showProgressWithMask];
    self.btnCode.enabled = NO;
    [APPRequest GET:nil parameters:@{@"to":self.txtPhone.text,@"type":@"2"} finished:^(AjaxResult *result) {
        self.btnCode.enabled = YES;
//        [SilenceHUDUtil dismiss];
        if (result.code == AjaxResultStateSuccess) {

            [self settime];
        }
    }];
}
//placeholder_method_impl//


- (IBAction)btnSubmitClick:(id)sender {
    
    if([self.txtPhone.text isNullOrEmpty]){
//        [SilenceHUDUtil showInfo:@"手机号码不能为空"];
        return;
    }
    if (![self.txtPhone.text isMobileNumber]) {
//        [SilenceHUDUtil showInfo:@"手机号码格式不正确"];
        return;
    }
    if ([self.txtCode.text isNullOrEmpty]) {
//        [SilenceHUDUtil showInfo:@"请输入验证码"];
        return;
    }
    if ([self.txtPwd.text isNilOrEmpty]) {

//        [SilenceHUDUtil showInfo:@"请输入新密码"];
        return;
    }
    if (self.txtPwd.text.length < 6) {

//        [SilenceHUDUtil showInfo:@"密码不能小于6位"];
        return;
    }
    //placeholder_method_call//

    if ([self.txtPwd2.text isNilOrEmpty]) {

//        [SilenceHUDUtil showInfo:@"请确认新密码"];
        return;
    }
    if (self.txtPwd2.text.length < 6) {

//        [SilenceHUDUtil showInfo:@"密码不能小于6位"];
        return;
    }
    if (![self.txtPwd.text isEqualToString:self.txtPwd2.text]) {

//        [SilenceHUDUtil showInfo:@"两次密码不一致"];
        return;
    }
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:self.txtPhone.text forKey:@"userPhone"];
    [param setObject:self.txtPwd2.text forKey:@"userPwd"];
    [param setObject:self.txtCode.text forKey:@"securityCode"];
//placeholder_method_call//

//    [SilenceHUDUtil showProgressWithMask];
    [APPRequest POST:nil parameters:param finished:^(AjaxResult *result) {

//        [SilenceHUDUtil dismiss];
        if (result.code == AjaxResultStateSuccess) {

//            [SilenceHUDUtil showSuccess:@"修改成功"];

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"KUserId"];
            [userDefaults removeObjectForKey:@"token"];
            [userDefaults synchronize];
            [APPUserDefault removeCurrentUserFromLocal];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
//placeholder_method_impl//

#pragma mark - 公开方法

#pragma mark - 私有方法

- (void)settime{

    countTimer = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//placeholder_method_call//

    [self timeFireMethod];
    self.btnCode.enabled = NO;
}
//placeholder_method_impl//

-(void)timeFireMethod{

    countTimer--;
    if (countTimer == 0) {
        //placeholder_method_call//

        [timer invalidate];
        [self.btnCode setTitle:@"  获取验证码  " forState:UIControlStateNormal];
        self.btnCode.enabled = YES;
    }
    else
    {
        [self.btnCode setTitle:[NSString stringWithFormat:@"  %lds后获取  ",countTimer] forState:UIControlStateNormal];
    }
}
//placeholder_method_impl//

#pragma mark - get set

@end

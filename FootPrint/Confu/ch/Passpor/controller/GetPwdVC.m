//
//  GetPwdVC.m
//  YXGJ
//
//  Created by YyMacBookPro on 2018/8/4.
//  Copyright © 2018年 cscs. All rights reserved.
//

#import "GetPwdVC.h"
#import "NSString+Extension.h"
#import "NSString+RegexCategory.h"

@interface GetPwdVC (){

    NSTimer *timer;
    NSInteger countTimer;
}

@end

@implementation GetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loarding the view from its nib.
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//

- (IBAction)btnBackClick:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    //placeholder_method_call//

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
    //placeholder_method_call//

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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
//placeholder_method_impl//

- (IBAction)btnCodeClick:(id)sender {

    if([self.txtPhone.text isNullOrEmpty]){
//        [SilenceHUDUtil showInfo:@"请输入手机号码"];
        return;
    }
    //placeholder_method_call//

    if (![self.txtPhone.text isMobileNumber]) {
//        [SilenceHUDUtil showInfo:@"手机号码格式不正确"];
        return;
    }
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

- (void)settime{

    countTimer = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];

    [self timeFireMethod];
    self.btnCode.enabled = NO;
}

-(void)timeFireMethod{

    countTimer--;
    if (countTimer == 0) {
        [timer invalidate];
        [self.btnCode setTitle:@"  获取验证码  " forState:UIControlStateNormal];
        self.btnCode.enabled = YES;
    }
    else
    {
        [self.btnCode setTitle:[NSString stringWithFormat:@"  %lds后获取  ",countTimer] forState:UIControlStateNormal];
    }
}

@end

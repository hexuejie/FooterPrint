//
//  RegisterVC.m
//  Zhongsheng
//
//  Created by YyMacBookPro on 2017/6/12.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "RegisterVC.h"
#import "NSString+Extension.h"
#import "NSString+RegexCategory.h"
#import "JPushNotification.h"
@interface RegisterVC (){
    
//    NSTimer *timer;
//    NSInteger countTimer;
}

@end

@implementation RegisterVC

#pragma mark - 飞卓类注释逻辑

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    self.csViewTop.constant = KStatusHight;
    
    CGFloat Footheight = 50;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-Footheight-KSafeAreaHeight, SCREEN_WIDTH, Footheight)];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Footheight)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"北京脚印互动科技有限公司";
    lblTitle.font = [UIFont systemFontOfSize:13.0];
    //placeholder_method_call//
    lblTitle.hidden = NO;
    lblTitle.textColor = RGB(192, 196, 204);
    [footerView addSubview:lblTitle];
    
    [self.view addSubview:footerView];
    
    [self.txtPhone addTarget:self action:@selector(textPhoneTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.txtPwd addTarget:self action:@selector(textPwdTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.txtPwd2 addTarget:self action:@selector(textPwd2TextChange:) forControlEvents:UIControlEventEditingChanged];
}
//placeholder_method_impl//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 直接添加监听方法

-(void)textPhoneTextChange:(UITextField *)textField{
    
    if (textField.text.length > 0 && self.txtPwd.text.length > 0 && self.txtPwd2.text.length > 0) {
        //placeholder_method_call//

        self.btnRegist.backgroundColor = RGB(4, 134, 254);
    }else{
        
        self.btnRegist.backgroundColor = RGB(131, 193, 254);
    }
}

- (void)textPwdTextChange:(UITextField *)textField{
    
    if (textField.text.length > 0 && self.txtPhone.text.length > 0 && self.txtPwd2.text.length > 0) {
        //placeholder_method_call//

        self.btnRegist.backgroundColor = RGB(4, 134, 254);
    }else{
        
        self.btnRegist.backgroundColor = RGB(131, 193, 254);
    }
}
//placeholder_method_impl//

- (void)textPwd2TextChange:(UITextField *)textField{
    
    if (textField.text.length > 0 && self.txtPhone.text.length > 0 && self.txtPwd.text.length > 0) {
        //placeholder_method_call//

        self.btnRegist.backgroundColor = RGB(4, 134, 254);
    }else{
        
        self.btnRegist.backgroundColor = RGB(131, 193, 254);
    }
}
//placeholder_method_impl//

#pragma mark - 事件

//注册
- (IBAction)btnRegisterClick:(id)sender{

    if([self.txtPhone.text isNullOrEmpty]){
        
        [KeyWindow showTip:@"手机号码不能为空"];
        return;
    }
    //placeholder_method_call//

    if (![self.txtPhone.text isMobileNumber]) {
        
        [KeyWindow showTip:@"手机号码格式不正确"];
        return;
    }
//    if ([self.txtCode.text isNullOrEmpty]) {
//        
//        [KeyWindow showTip:@"请输入验证码"];
//        return;
//    }
    if ([self.txtPwd.text isNullOrEmpty]) {
        
        [KeyWindow showTip:@"请输入密码"];
        return;
    }
    if ([self.txtPwd.text length] < 6 || [self.txtPwd.text length] > 16) {
        
        [KeyWindow showTip:@"密码必须在6～16位之间"];
        return;
    }
    if ([self.txtPwd2.text isNullOrEmpty]) {
        
        [KeyWindow showTip:@"请确认密码"];
        return;
    }
    if (![self.txtPwd.text isEqualToString:self.txtPwd2.text]) {
        
        [KeyWindow showTip:@"两次密码不一致"];
        return;
    }
    
    [self.view endEditing:YES];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setObject:self.txtPhone.text forKey:@"uname"];
    [param setObject:self.txtPwd.text forKey:@"password"];
    [param setObject:self.txtPwd2.text forKey:@"repassword"];

    [KeyWindow showNormalLoadingWithTip:@"正在注册"];
    [APPRequest POST:@"/register" parameters:param finished:^(AjaxResult *result) {

        [KeyWindow hiddenLoading];
        
        if (result.code == AjaxResultStateSuccess) {

                     [KeyWindow showSuccessTip:@"注册成功"];
            
             [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

////获取验证码
//- (IBAction)btnCodeClick:(id)sender {
//
//    if([self.txtPhone.text isNullOrEmpty]){
//
//        [KeyWindow showTip:@"请输入手机号码"];
//        return;
//    }
//    if (![self.txtPhone.text isMobileNumber]) {
//
//        [KeyWindow showTip:@"手机号码格式不正确"];
//        return;
//    }
////    [KeyWindow showNormalLoadingWithTip:@"获取验证码"];
//    self.btnCode.enabled = NO;
//
////    [APPRequest GET:@"/sendcode" parameters:@{@"phone":self.txtPhone.text} finished:^(AjaxResult *result) {
////
////        [KeyWindow hiddenLoading];
////        if (result.code == AjaxResultStateSuccess) {
////
//            [self settime];
////        }
////    }];
//}

//返回
- (IBAction)btnBackClick:(id)sender {
    //placeholder_method_call//

    [self dismissViewControllerAnimated:YES completion:nil];
}
//placeholder_method_impl//

#pragma mark - 公开方法

#pragma mark - 私有方法

//- (void)settime{
//
//    countTimer = 60;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
//
//    [self timeFireMethod];
//    self.btnCode.enabled = NO;
//}
//
//-(void)timeFireMethod{
//
//    countTimer--;
//    if (countTimer == 0) {
//        [timer invalidate];
//        [self.btnCode setTitle:@"  获取验证码  " forState:UIControlStateNormal];
//        self.btnCode.enabled = YES;
//    }
//    else
//    {
//        [self.btnCode setTitle:[NSString stringWithFormat:@"  %lds后获取  ",countTimer] forState:UIControlStateNormal];
//    }
//}
//placeholder_method_impl//

#pragma mark - get set

@end

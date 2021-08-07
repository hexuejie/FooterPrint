//
//  BindVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BindVC.h"
#import "NSString+RegexCategory.h"
#import "JPushNotification.h"
#import "OpenShare.h"
@interface BindVC ()<UITextFieldDelegate>{
    
    NSTimer *timer;
    NSInteger countTimer;
}

@end

@implementation BindVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self judgeBindStatus];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.txtPhone.delegate = self;
    self.txtCode.delegate = self;
    self.btnCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    //placeholder_method_call//

    [self.txtPhone addTarget:self action:@selector(textPhoneTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.txtCode addTarget:self action:@selector(textCodeTextChange:) forControlEvents:UIControlEventEditingChanged];
}
//placeholder_method_impl//


- (void)judgeBindStatus{
    
    if (self.bindStatus == 0) {
        self.navigationItem.title = @"手机号认证";
        self.title1.text = @"请绑定您的手机号";
        self.title2.text = @"此手机号码可用来联系客户找回您的账号与订单";
        [self.bindBtn setImage:[UIImage imageNamed:@"mine_bind_phone"] forState:UIControlStateNormal];
    } else if (self.bindStatus == 1) {
        self.navigationItem.title = @"手机号认证";
//        self.phone =
       NSString *newSt = [self.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.title1.text = [NSString stringWithFormat:@"更换绑定手机号(%@)",newSt];
        self.title2.text = @"此手机号码可用来联系客户找回您的账号与订单";
        [self.bindBtn setImage:[UIImage imageNamed:@"mine_change_mobile"] forState:UIControlStateNormal];
    } else if (self.bindStatus == 2) {
        self.phoneBgView.hidden = YES;
        self.codeBgView.hidden = YES;
        self.navigationItem.title = @"微信号认证";
        
//        self.phone =
      
        self.title1.text = [NSString stringWithFormat:@"更换绑定微信(%@)",self.nickname];
        self.title2.text = @"此微信号可用来快捷登录脚印云课APP";
        [self.bindBtn setImage:[UIImage imageNamed:@"mine_change_wechat"] forState:UIControlStateNormal];
    }
    
    
    
}
//placeholder_method_impl//
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
- (IBAction)btnSubmitClick:(id)sender {
    
    if (self.bindStatus == 2) {
        WS(weakself)
        [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
            if([[message allKeys] containsObject:@"code"]){
                [KeyWindow showLoadingHUD];
                [APPRequest POST:@"/rebindWechat" parameters:@{@"code":message[@"code"]} finished:^(AjaxResult *result) {
                    [KeyWindow hiddenLoading];
                    if (result.code == AjaxResultStateSuccess) {
                        [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {

                            if (result.code == AjaxResultStateSuccess) {

                                UserModel *user = [UserModel mj_objectWithKeyValues:result.data];
                                [[JPushNotification shareJPushNotification] loginJPush:user.user.uid];
                            }
                        }];
                     [weakself.navigationController popViewControllerAnimated:true];

                    }
                }];
            }
        } Fail:^(NSDictionary *message, NSError *error) {
            
            [KeyWindow showTip:@"认证失败"];
        }];
        return;
    }
    
    
    
    
    
    
    if([self.txtPhone.text isNilOrEmpty]){
        
        [KeyWindow showTip:@"手机号码不能为空"];
        return;
    }
    //placeholder_method_call//

    if (self.txtPhone.text.length != 11) {
        
        [KeyWindow showTip:@"请输入正确的手机号"];
        self.viewPhoneError.hidden = NO;
        return;
    }
    if ([self.txtCode.text isNilOrEmpty]) {
        
        [KeyWindow showTip:@"请输入验证码"];
        return;
    }
    self.viewPhoneError.hidden = YES;
    [KeyWindow showLoadingHUD];
    if (self.bindStatus == 0) {
        
        NSDictionary *param = @{
            @"code":self.txtCode.text,
            @"phone":self.txtPhone.text,
            @"jwt_token":self.jwt_token
        };
        WS(weakself)
        [APPRequest POST:@"/bindMobile" parameters:param finished:^(AjaxResult *result) {
            
            [KeyWindow hiddenLoading];
            if (result.code == AjaxResultStateSuccess) {
                
                [KeyWindow showTip:@"绑定成功"];
                self.viewCodeError.hidden = YES;
                if (self.BlockBackClick) {
                    self.BlockBackClick();
                }
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:weakself.jwt_token forKey:@"token"];
//                [user setObject:result.data[@"uname"]  forKey:@"uname"];
                [user synchronize];
                
                [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {

                    if (result.code == AjaxResultStateSuccess) {

                        UserModel *user = [UserModel mj_objectWithKeyValues:result.data];
                        [[JPushNotification shareJPushNotification] loginJPush:user.user.uid];
                    }
                }];
                
                [weakself addPush];

               NSArray *arr = [self.navigationController viewControllers];
             UIViewController *contro =  arr[arr.count - 2];
                [self.navigationController popToRootViewControllerAnimated:NO];
            }
            else{
                
                self.viewCodeError.hidden = NO;
            }
        }];
    }
    if (self.bindStatus == 1) {
        
        NSDictionary *param = @{
            @"code":self.txtCode.text,
            @"phone":self.txtPhone.text,
        };
        WS(weakself)
        [APPRequest POST:@"/rebindMobile" parameters:param finished:^(AjaxResult *result) {
            
            [KeyWindow hiddenLoading];
            if (result.code == AjaxResultStateSuccess) {
                
                [KeyWindow showTip:@"换绑成功"];
                if (self.BlockBackClick) {
                    self.BlockBackClick();
                }
                [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {

                    if (result.code == AjaxResultStateSuccess) {

                        UserModel *user = [UserModel mj_objectWithKeyValues:result.data];
                        [[JPushNotification shareJPushNotification] loginJPush:user.user.uid];
                    }
                }];
                [weakself.navigationController popViewControllerAnimated:YES];
            }
          
        }];
    }
  
    
    
    
    
//    if (self.isBind == 1) { //已绑定 解绑
//        NSDictionary *param = @{@"code":self.txtCode.text,@"phone":self.txtPhone.text};
//
//        [APPRequest POST:@"/untyingMobile" parameters:param finished:^(AjaxResult *result) {
//
//            [KeyWindow hiddenLoading];
//            if (result.code == AjaxResultStateSuccess) { //解绑成功
//
//                [KeyWindow showTip:@"解绑成功"];
//                self.viewCodeError.hidden = YES;
//                self.isBind = 0;
//                [self judgeBindStatus]; //更新视图
//
//                [timer invalidate];
//                [self.btnCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
//                self.btnCode.enabled = YES;
//            }else{
//
//                self.viewCodeError.hidden = NO;
//            }
//        }];
//
//    }else{ //绑定
//
//    }
}
//placeholder_method_impl//

- (IBAction)btnCodeClick:(id)sender {
 
    if ([self.txtPhone.text isNilOrEmpty]) {
        
        [KeyWindow showTip:@"手机号码不能为空"];
        return;
    }
    //placeholder_method_call//

    if (self.txtPhone.text.length != 11) {
        
        [KeyWindow showTip:@"请输入正确的手机号"];
        self.viewPhoneError.hidden = NO;
        return;
    }
    self.viewPhoneError.hidden = YES;
     //  @"jwt_token":self.jwt_token
    NSMutableDictionary *params = @{
        @"phone":self.txtPhone.text
    }.mutableCopy;
    if (self.jwt_token) {
        [params setObject:self.jwt_token forKey:@"jwt_token"];
    }
        
    
    [KeyWindow showLoadingHUD];
    [APPRequest GET:@"/sendcode" parameters:params finished:^(AjaxResult *result) {
       
        [KeyWindow hiddenLoading];
        if (result.code == AjaxResultStateSuccess) {
            
            [self settime];
        }
    }];
}
//placeholder_method_impl//

//进入编辑模式
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.txtPhone) {
        //placeholder_method_call//

        self.viewPhone.backgroundColor = RGB(4, 134, 254);
    }
    if (textField == self.txtCode) {
        
        self.viewCode.backgroundColor = RGB(4, 134, 254);
    }
}
//placeholder_method_impl//

//退出编辑模式
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.txtPhone) {
        //placeholder_method_call//

        self.viewPhone.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    if (textField == self.txtCode) {
        
        self.viewCode.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}
//placeholder_method_impl//

-(void)textPhoneTextChange:(UITextField *)textField{
    
    if (textField.text.length >0 && self.txtCode.text.length >0) {
        //placeholder_method_call//

//        self.btnSubmit.backgroundColor = RGB(4, 134, 254);
    }else{
        
//        self.btnSubmit.backgroundColor = RGB(131, 193, 254);
    }
}
//placeholder_method_impl//

- (void)textCodeTextChange:(UITextField *)textField{
    
    if (textField.text.length >0 && self.txtPhone.text.length >0) {
        
//        self.btnSubmit.backgroundColor = RGB(4, 134, 254);
    }else{
        
//        self.btnSubmit.backgroundColor = RGB(131, 193, 254);
    }
}

- (void)settime{
    
    countTimer = 120;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    [self timeFireMethod];
    self.btnCode.enabled = NO;
}

-(void)timeFireMethod{
    
    countTimer--;
    if (countTimer == 0) {
        //placeholder_method_call//

        [timer invalidate];
        [self.btnCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.btnCode.enabled = YES;
    }else{
        
        [self.btnCode setTitle:[NSString stringWithFormat:@"%lds",countTimer] forState:UIControlStateNormal];
    }
}

@end

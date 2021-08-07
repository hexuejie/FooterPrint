//
//  LoginVC.h
//  Zhongsheng
//
//  Created by 陈小卫 on 17/6/6.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "BaseVC.h"

@interface LoginVC : BaseVC

typedef void (^loginSuccess)(void);

+(void) logout;

@property (strong, nonatomic) loginSuccess loginSeccessback;//分享成功后的回调
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
- (IBAction)tourAction:(UIButton *)sender;

- (IBAction)btnLoginClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UIButton *tourBtn;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
//placeholder_property//
- (IBAction)btnRegistClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnArragement;

@property (weak, nonatomic) IBOutlet UIButton *btnarragement2;



- (IBAction)selectAction:(UIButton *)sender;



- (IBAction)goingToProtocolAction:(UIButton *)sender;

















@end

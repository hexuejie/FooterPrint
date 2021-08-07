//
//  BindVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindVC : BaseVC

@property (nonatomic, assign) NSInteger bindStatus; // 0 绑定手机号 ，1,换绑手机号， 2，换绑微信
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@property (nonatomic, strong) NSString *phone;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtCode;

@property (weak, nonatomic) IBOutlet UIButton *btnCode;
//placeholder_property//
- (IBAction)btnSubmitClick:(id)sender;

//@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (weak, nonatomic) IBOutlet UIView *phoneBgView;
@property (weak, nonatomic) IBOutlet UIView *codeBgView;



- (IBAction)btnCodeClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewPhone;

@property (weak, nonatomic) IBOutlet UIView *viewCode;

@property (nonatomic, strong) NSString *jwt_token;

//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewPhoneError;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewCodeError;
@property (nonatomic,strong)NSString *uname;
@property (nonatomic,strong)NSString *nickname;

//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

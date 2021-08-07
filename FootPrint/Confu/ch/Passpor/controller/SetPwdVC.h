//
//  GetPwdVC.h
//  Zhongsheng
//
//  Created by YyMacBookPro on 2017/6/15.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "BaseVC.h"

@interface SetPwdVC : BaseVC

@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd2;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UIButton *btnCode;

- (IBAction)btnCodeClick:(id)sender;
//placeholder_property//
- (IBAction)btnSubmitClick:(id)sender;

@end

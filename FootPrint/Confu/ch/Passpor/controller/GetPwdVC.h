//
//  GetPwdVC.h
//  YXGJ
//
//  Created by YyMacBookPro on 2018/8/4.
//  Copyright © 2018年 cscs. All rights reserved.
//

#import "BaseVC.h"

@interface GetPwdVC : BaseVC

- (IBAction)btnBackClick:(id)sender;
//placeholder_property//
- (IBAction)btnSubmitClick:(id)sender;

- (IBAction)btnCodeClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@property (weak, nonatomic) IBOutlet UIButton *btnCode;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPwd2;
//placeholder_property//
@end

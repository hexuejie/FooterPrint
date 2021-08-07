//
//  RegisterVC.h
//  Zhongsheng
//
//  Created by YyMacBookPro on 2017/6/12.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "BaseVC.h"

@protocol RegisterSuccessDelegate <NSObject>
-(void) registerSuccess;
@end

@interface RegisterVC : BaseVC

@property (nonatomic, weak) id<RegisterSuccessDelegate> delegate;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

//@property (weak, nonatomic) IBOutlet UITextField *txtCode;

//@property (weak, nonatomic) IBOutlet UIButton *btnCode;

- (IBAction)btnRegisterClick:(id)sender;
//placeholder_property//
//- (IBAction)btnCodeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPwd2;

- (IBAction)btnBackClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewTop;
//placeholder_property//
@end

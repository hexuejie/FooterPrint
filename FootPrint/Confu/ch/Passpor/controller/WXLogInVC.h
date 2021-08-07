//
//  WXLoginVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/20.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXLogInVC : BaseVC

- (IBAction)btnWXLoginClick:(id)sender;
//placeholder_property//
- (IBAction)btnTouristsClick:(id)sender;
//placeholder_property//
//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocalBtn;

- (IBAction)protocalActionClick:(UIButton *)sender;
- (IBAction)seletAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END

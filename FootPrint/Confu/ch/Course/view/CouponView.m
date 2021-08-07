//
//  CouponView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CouponView.h"

@implementation CouponView
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)awakeFromNib{
    
    [super awakeFromNib];
    //placeholder_method_call//

    [self.txtCode addTarget:self action:@selector(textCodeTextChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textCodeTextChange:(UITextField *)textField{
    
    if (textField.text.length >0 && self.txtCode.text.length >0) {
        
        self.btnSubmit.backgroundColor = RGB(4, 134, 254);
    }else{
        //placeholder_method_call//

        self.btnSubmit.backgroundColor = RGB(131, 193, 254);
    }
}

- (IBAction)btnCloseClick:(id)sender {
    //placeholder_method_call//

    [self removeFromSuperview];
}

- (IBAction)btnSubmitClick:(id)sender {

    if (self.txtCode.text.length == 0) {
        //placeholder_method_call//

        [KeyWindow showTip:@"请输入优惠券码"];
        return;
    }
    if (self.BlockSubmitClick) {
        self.BlockSubmitClick(self.txtCode.text);
    }
}
//placeholder_method_impl//

@end

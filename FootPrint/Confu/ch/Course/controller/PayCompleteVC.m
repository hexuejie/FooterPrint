//
//  PayCompleteVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/9.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "PayCompleteVC.h"
#import "OrderDetailVC.h"

@interface PayCompleteVC ()<UIScrollViewDelegate>

@end

@implementation PayCompleteVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付完成";
    self.leftButton.hidden = YES;
    //placeholder_method_call//

    self.view.backgroundColor = [UIColor whiteColor];
}
//placeholder_method_impl//

- (IBAction)btnSuccessClick:(id)sender {
    
    if (self.order_sn.length != 0) {
        //placeholder_method_call//

        [APPRequest GET:@"/orderStatus" parameters:@{@"order_sn":self.order_sn} finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
                
                NSInteger status = [result.data integerValue];
                
                if (status == 1 || status == 2) { //成功
                
                    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                    if (index>2) {
                        
                        OrderDetailVC *next = [self.navigationController.viewControllers objectAtIndex:(index-2)];
                        [next loadData];
                        [self.navigationController popToViewController:next animated:YES];
                    }else{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }
                }else{ //未付款

                    [KeyWindow showTip:@"订单还没有付款！"];
                }
            }
        }];
    }
}
//placeholder_method_impl//

- (IBAction)btnAgainClick:(id)sender {
    //placeholder_method_call//

    [self.navigationController popViewControllerAnimated:YES];
}

@end

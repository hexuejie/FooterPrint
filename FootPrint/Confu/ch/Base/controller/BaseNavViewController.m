//
//  BaseNavViewController.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/12.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController
//placeholder_method_impl//
- (void)viewDidLoad {
    [super viewDidLoad];
    //placeholder_method_call//


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 自动加入隐藏bar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



//
//// 是否支持自动转屏
//- (BOOL)shouldAutorotate
//{
//    if ([self.visibleViewController isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//
//        return YES;
//    }
//    return NO;
//}
//// 支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    if ([self.visibleViewController isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}

@end

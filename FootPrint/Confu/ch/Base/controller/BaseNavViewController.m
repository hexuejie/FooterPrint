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



@end

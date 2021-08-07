//
//  MainTabBarController.m
//  Yizhen
//
//  Created by Silence on 2017/1/12.
//  Copyright © 2017年 Yizhen. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavViewController.h"
#import "LoginVC.h"
#import "CourseVC.h"
#import "HomePageSegmentVC.h"
#import "NeMneVC.h"
#import "InformationVC.h"
@interface MainTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@property (nonatomic, strong) NSMutableArray *childs;

@property (nonatomic, assign) NSInteger selectIdx;

@end

@implementation MainTabBarController
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]]; // 文字
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];//背景
    //placeholder_method_call//

    self.delegate = self;

    [self setupChild];
}
//placeholder_method_impl//

-(void)setupChild{
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x979797]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x479298]} forState:UIControlStateSelected];
    
    
    // tab栏配置
    NSArray *datas = [NSArray array];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger is_show = [[user objectForKey:@"is_info_mobile"] integerValue];
    
//    if (is_show == 1) {
//
//        datas = @[
//                  @{@"TabName":@"首页"},
//                  @{@"TabName":@"课程"},
//                  @{@"TabName":@"资讯"},
//                  @{@"TabName":@"我的"}
//                  ];
//    }else
    
//    {
        
        datas = @[
                  @{@"TabName":@"首页"},
                  @{@"TabName":@"课程"},
                  @{@"TabName":@"我的"}
                  ];
//    }
    
    _childs = [NSMutableArray array];
    for (int i=0; i<datas.count; i++) {
        NSDictionary *data = datas[i];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",data[@"Image"]]];
        UIImage * selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",data[@"Image"]]]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
         UIViewController *vc;
        if (i == 0) {
            vc = [[HomePageSegmentVC alloc] init];
            image = [[UIImage imageNamed:@"icon_home_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selectImage = [[UIImage imageNamed:@"icon_home_p"]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        if (i == 1) {
                  vc = [[CourseVC alloc] init];
            image = [[UIImage imageNamed:@"icon_course_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                     selectImage = [[UIImage imageNamed:@"icon_course_p"]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
              }
        if (datas.count == 3 && i == 2) {
            vc = [[NeMneVC alloc] init];
            image = [[UIImage imageNamed:@"icon_my_n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                               selectImage = [[UIImage imageNamed:@"icon_my_p"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
        }
        
//        if (datas.count == 4 ) {
//            if (i == 2) {
//                vc = [[InformationVC alloc] init];
//                image = [UIImage imageNamed:@"icon_information_n"];
//                                   selectImage = [[UIImage imageNamed:@"icon_information_p"]
//                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            }
//            if (i == 3) {
//                vc = [[NeMneVC alloc] init];
//                image = [UIImage imageNamed:@"icon_my_n"];
//                                   selectImage = [[UIImage imageNamed:@"icon_my_p"]
//                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            }
//
//            }
        
        //placeholder_method_call//

      
        vc.tabBarItem.title = data[@"TabName"];
        vc.tabBarItem.image = image;
        vc.tabBarItem.selectedImage = selectImage;
        
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
        nav.tabBarItem.tag = i;
        
        [_childs addObject:nav];
    }
    self.viewControllers = _childs;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    if (self.selectIdx == item.tag) {
        //placeholder_method_call//

        if (self.selectIdx == 1) { //课程
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewTop" object:nil];
        }
    }
    self.selectIdx = item.tag;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//placeholder_method_call//

//    if (viewController.tabBarItem.tag == 1 ||viewController.tabBarItem.tag == 2) {
//        if (!KUserId) {
//
//            return NO;
//        }
//    }
    return YES;
}
//placeholder_method_impl//

//-(BOOL)shouldAutorotate{
//    BaseNavViewController *nav = (BaseNavViewController *)self.selectedViewController;
//    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//        return YES;
//    }
//    return NO;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    BaseNavViewController *nav = (BaseNavViewController *)self.selectedViewController;
//    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
//placeholder_method_impl//

@end

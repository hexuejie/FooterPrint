//
//  BuyPageVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyPageVC.h"
#import "BuypackageVC.h"
#import "BuyCourseVC.h"
@interface BuyPageVC ()

@property (strong, nonatomic) NSMutableArray<NSString *> *labels;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@end

@implementation BuyPageVC
//placeholder_method_impl//


- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.showOnNavigationBar = NO;     //在导航栏上展示
        self.automaticallyCalculatesItemWidths = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.scrollEnable = YES;
        self.titleSizeSelected = 16;
        self.titleSizeNormal = 16;
        //placeholder_method_call//

        self.progressColor = RGB(4, 134, 254);
        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = [UIColor blackColor];
        self.itemMargin = 0;
        self.progressWidth = 25;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"已购买";
    
    self.views = [NSMutableArray array];
    //添加标签
    self.labels = @[@"课程",@"套餐"].mutableCopy;
    //初始化View
    //placeholder_method_call//

    BuyCourseVC *view1 = [[BuyCourseVC alloc] init];
    [self.views addObject:view1];
    
    BuypackageVC *view2 = [[BuypackageVC alloc] init];
    [self.views addObject:view2];
    
    [self reloadData];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.labels.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    
    return self.labels[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return self.views[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    menuView.backgroundColor = [UIColor whiteColor];
    //placeholder_method_call//

    return CGRectMake(0, 0, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //placeholder_method_call//

    //    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
    //    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end

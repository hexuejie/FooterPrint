//
//  LivePageVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LivePageVC.h"
#import "LiveListVC.h"
@interface LivePageVC ()

@property (strong, nonatomic) NSMutableArray<NSString *> *labels;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@end

@implementation LivePageVC
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.showOnNavigationBar = NO;     //在导航栏上展示
        self.automaticallyCalculatesItemWidths = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.scrollEnable = YES;
        self.titleSizeSelected = 16;
        //placeholder_method_call//

        self.titleSizeNormal = 16;
        self.progressColor = RGB(4, 134, 254);
        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = RGB(4, 134, 254);
        self.itemMargin = 0;
        self.progressWidth = 25;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播列表";
    
    self.views = [NSMutableArray array];
    //添加标签
    self.labels = @[@"全部直播",@"即将直播",@"正在直播",@"直播回放"].mutableCopy;
    //placeholder_method_call//

//    0-全部 1-直播中 2-待直播 3-已结束 4. 可回放
    for (int i=0; i<self.labels.count; i++) {
        
        LiveListVC *view =  [[LiveListVC alloc] init];
        view.type = i;
        if (i == 1) {

            view.type = 2;
        }else if (i == 2){

            view.type = 1;
        }
        [self.views addObject:view];
    }
    
    [self reloadData];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    //placeholder_method_call//

    return self.labels.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    //placeholder_method_call//

    return self.labels[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    //placeholder_method_call//

    return self.views[index];
}
//placeholder_method_impl//
//placeholder_method_impl//


- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    //placeholder_method_call//

    return width;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    //placeholder_method_call//

    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, 0, self.view.frame.size.width, 44);
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //placeholder_method_call//

    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end

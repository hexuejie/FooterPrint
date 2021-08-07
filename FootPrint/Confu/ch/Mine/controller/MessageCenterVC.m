//
//  MessageCenterVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MessageCenterVC.h"
#import "ShopMessageVC.h"
#import "ReplyMessageVC.h"

@interface MessageCenterVC ()

@property (strong, nonatomic) NSMutableArray<NSString *> *labels;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@property (nonatomic, strong) UILabel *lblShopNum;

@property (nonatomic, strong) UILabel *lblReplyNum;

@end

@implementation MessageCenterVC

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.showOnNavigationBar = NO;     //在导航栏上展示
//        self.automaticallyCalculatesItemWidths = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.scrollEnable = YES;
        self.titleSizeSelected = 16;
        self.titleSizeNormal = 16;
        //placeholder_method_call//
//placeholder_method_call//
        
        self.progressColor = RGB(4, 134, 254);
        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = [UIColor blackColor];
        self.itemMargin = 0;
        self.progressWidth = 25;
        self.menuItemWidth = 85;
        //placeholder_method_call//
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    }
    return self;
}
//placeholder_method_impl//

- (void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    
    self.views = [NSMutableArray array];
    //添加标签
    self.labels = @[@"店铺公告",@"回复我的"].mutableCopy;
    //placeholder_method_call//

    //初始化View
    ShopMessageVC *view1 = [[ShopMessageVC alloc] init];
    [self.views addObject:view1];
    
    ReplyMessageVC *view2 = [[ReplyMessageVC alloc] init];
    [self.views addObject:view2];
    
//    [self reloadData];
    
    CGFloat spacing = (SCREEN_WIDTH-170)/3;
    self.lblShopNum = [[UILabel alloc] initWithFrame:CGRectMake(spacing+85, 12, 20, 20)];
    self.lblShopNum.layer.masksToBounds = YES;
    self.lblShopNum.layer.cornerRadius = 10;
    self.lblShopNum.backgroundColor = RGB(245, 108, 108);
    self.lblShopNum.textAlignment = NSTextAlignmentCenter;
    self.lblShopNum.textColor = [UIColor whiteColor];
    self.lblShopNum.font = [UIFont systemFontOfSize:13.0];
    self.lblShopNum.hidden = YES;
    [self.view addSubview:self.lblShopNum];
    
    self.lblReplyNum = [[UILabel alloc] initWithFrame:CGRectMake((spacing+85)*2, 12, 20, 20)];
    self.lblReplyNum.layer.masksToBounds = YES;
    self.lblReplyNum.layer.cornerRadius = 10;
    self.lblReplyNum.backgroundColor = RGB(245, 108, 108);
    self.lblReplyNum.textAlignment = NSTextAlignmentCenter;
    self.lblReplyNum.textColor = [UIColor whiteColor];
    self.lblReplyNum.font = [UIFont systemFontOfSize:13.0];
    self.lblReplyNum.hidden = YES;
    [self.view addSubview:self.lblReplyNum];
}
//placeholder_method_impl//

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.labels.count;
}
//placeholder_method_impl//

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    
    return self.labels[index];
}
//placeholder_method_impl//

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return self.views[index];
}
//placeholder_method_impl//

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    //placeholder_method_call//

    return width;
}
//placeholder_method_impl//

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, 0, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //placeholder_method_call//

    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)loadData{
    //placeholder_method_call//

    [APPRequest GET:@"/user/message" parameters:nil finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            NSInteger replay = [result.data[@"replay"] integerValue];
            NSInteger notice = [result.data[@"notice"] integerValue];
            if (replay != 0) {
                self.lblReplyNum.text = [NSString stringWithFormat:@"%ld",replay];
                self.lblReplyNum.hidden = NO;
            }else{
                self.lblReplyNum.hidden = YES;
            }
            if (notice != 0) {
                self.lblShopNum.text = [NSString stringWithFormat:@"%ld",notice];
                self.lblShopNum.hidden = NO;
            }else{
                self.lblShopNum.hidden = YES;
            }
        }
    }];
}

@end

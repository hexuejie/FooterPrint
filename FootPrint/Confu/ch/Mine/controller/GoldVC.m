//
//  GoldVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/7.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "GoldVC.h"
#import "IntegralListVC.h"
#import "BuyGoldVC.h"

@interface GoldVC ()

@property (strong, nonatomic) NSMutableArray<NSString *> *labels;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@property (nonatomic, strong) UILabel *lblGold;

@end

@implementation GoldVC
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
        self.progressColor = RGB(4, 134, 254);
        //placeholder_method_call//

        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = [UIColor blackColor];
        self.itemMargin = 0;
        self.progressWidth = 25;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    }
    return self;
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的学习金";

    self.view.backgroundColor = kColor_BG;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textColor = RGB(144, 147, 153);
    lbl.font = [UIFont systemFontOfSize:12.0];
    lbl.text = @"剩余学习金";
    [headView addSubview:lbl];
    //placeholder_method_call//

    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(12);
        make.leading.mas_equalTo(16);
    }];
    
    self.lblGold = [[UILabel alloc] init];
    self.lblGold.textColor = [UIColor blackColor];
    self.lblGold.font = [UIFont boldSystemFontOfSize:30.0];
    [headView addSubview:self.lblGold];
    //placeholder_method_call//

    [self.lblGold mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(headView).offset(-25);
        make.centerX.mas_equalTo(headView).offset(-10);
    }];
    
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.text = @"学习金";
    lbl1.textColor = RGB(144, 147, 153);
    lbl1.font = [UIFont systemFontOfSize:12.0];;
    [headView addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.lblGold.mas_trailing).offset(4);
        make.bottom.mas_equalTo(self.lblGold.mas_bottom).offset(-6);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"去充值" forState:UIControlStateNormal];
    [headView addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    btn.backgroundColor = RGB(255, 164, 0);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 14;
    [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        BuyGoldVC *next = [[BuyGoldVC alloc] init];
        next.BlockBackClick = ^{
          
            [self loadData];
            IntegralListVC *next = (IntegralListVC *)self.views[self.selectIndex];
            [next reloadData];
        };
        [self.navigationController pushViewController:next animated:YES];
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.lblGold.mas_bottom).offset(6);
        make.centerX.mas_equalTo(headView);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(100);
    }];
    //placeholder_method_call//

    self.views = [NSMutableArray array];
    //添加标签
    self.labels = @[@"全部",@"使用",@"充值"].mutableCopy;
    
    for (int i=0; i<self.labels.count; i++) {
        
        IntegralListVC *view =  [[IntegralListVC alloc] init];
        view.type = i;
        view.isGold = YES;
        [self.views addObject:view];
    }
    
    [self reloadData];
    [self loadData];
}
//placeholder_method_impl//

- (void)loadData{
    
    //获取全部积分数
    [APPRequest GET:@"/myGold" parameters:@{@"type":@"0"} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {

            self.lblGold.text = [NSString stringWithFormat:@"%@",result.data[@"gold"]];
        }
    }];
}
//placeholder_method_impl//

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.labels.count;
}

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
    return width;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    //placeholder_method_call//

    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, 120, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //placeholder_method_call//

    return CGRectMake(0, originY+10, self.view.frame.size.width, self.view.frame.size.height - originY-10);
}

@end

//
//  IntegralVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "IntegralVC.h"
#import "IntegralListVC.h"

@interface IntegralVC ()

@property (strong, nonatomic) NSMutableArray<NSString *> *labels;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@property (nonatomic, strong) UILabel *lblAll;

@property (nonatomic, strong) UILabel *lblRemaining;

@end

@implementation IntegralVC
//placeholder_method_impl//
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
        self.titleSizeNormal = 16;
        self.progressColor = RGB(4, 134, 254);
        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = [UIColor blackColor];
        self.itemMargin = 0;
        self.progressWidth = 25;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    }
    return self;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"积分详情";
    
    self.view.backgroundColor = kColor_BG;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [self.view addSubview:headView];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:headView.bounds];
    bgView.image = [UIImage imageNamed:@"mine_IntegralBg"];
    [headView addSubview:bgView];
    
    self.lblAll = [[UILabel alloc] init];
    self.lblAll.textColor = [UIColor whiteColor];
    self.lblAll.font = [UIFont systemFontOfSize:12.0];
    //placeholder_method_call//

    [headView addSubview:self.lblAll];
    [self.lblAll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(12);
        make.leading.mas_equalTo(16);
    }];
    
    self.lblRemaining = [[UILabel alloc] init];
    self.lblRemaining.textColor = [UIColor whiteColor];
    self.lblRemaining.font = [UIFont boldSystemFontOfSize:30.0];
    [headView addSubview:self.lblRemaining];
    [self.lblRemaining mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(headView).offset(-10);
        make.centerX.mas_equalTo(headView);
    }];
    
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.text = @"剩余积分";
    lbl1.textColor = [UIColor whiteColor];
    lbl1.font = [UIFont systemFontOfSize:12.0];;
    [headView addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(headView);
        make.top.mas_equalTo(self.lblRemaining.mas_bottom).offset(4);
    }];
    
    self.views = [NSMutableArray array];
    //添加标签
    self.labels = @[@"全部",@"获取",@"使用"].mutableCopy;
    
    for (int i=0; i<self.labels.count; i++) {
        
        IntegralListVC *view =  [[IntegralListVC alloc] init];
        view.type = i;
        [self.views addObject:view];
    }
    
    [self reloadData];
    [self loadData];
}

- (void)loadData{
    //placeholder_method_call//

    //获取全部积分数
    [APPRequest GET:@"/integralList" parameters:@{@"type":@"0"} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.lblAll.text = [NSString stringWithFormat:@"总积分: %@",result.data[@"integral_count"]];
            self.lblRemaining.text = [NSString stringWithFormat:@"%@",result.data[@"now_integral"]];
        }
    }];
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

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    //placeholder_method_call//

    return width;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    menuView.backgroundColor = [UIColor whiteColor];
    //placeholder_method_call//

    return CGRectMake(0, 120, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);

    return CGRectMake(0, originY+10, self.view.frame.size.width, self.view.frame.size.height - originY-10);
}

@end

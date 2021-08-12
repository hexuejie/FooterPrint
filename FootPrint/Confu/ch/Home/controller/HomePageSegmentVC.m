//
//  WMHomeViewController.m
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "HomePageSegmentVC.h"
//#import "WMPanGestureRecognizer.h"
//#import "NewCustomBanner.h"
//#import "SearchHouseListViewController.h"
//#import "BannerModel.h"
#import "HomeVC.h"
#import "HomeTipBgView.h"
#import "HomeCourseListVC.h"
#import "WebsVC.h"
#import "HomeSearchCell.h"
#import "ShopMessageModel.h"
#import "SearchVC.h"
#import "ShopMessageVC.h"
#import "HomePageListTipView.h"


@interface HomePageSegmentVC () <UIGestureRecognizerDelegate,WMPageControllerDelegate>

@property (nonatomic, strong) NSMutableArray *musicCategories;
//@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
//@property (nonatomic, assign) CGPoint lastPoint;
//
//@property (nonatomic,strong) NewCustomBanner *icarouselView;
@property (nonatomic,strong) NSArray *instItems;

@property (nonatomic,strong) UIButton *chatButton;

@property (nonatomic,assign) NSInteger requestTimes;


@property (nonatomic, strong) HomeSearchCell *searchView;
@property (nonatomic, strong) UIButton *messageBtn;

@property (nonatomic, strong) UIButton *signBtn;
@property (nonatomic, strong) UIView *redView;
@end

@implementation HomePageSegmentVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (NSMutableArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = [NSMutableArray new];
        [_musicCategories addObject:@{@"id":@"-1",@"cate_name":@"首页"}];
    }
    return _musicCategories;
}

- (void)pageController:(WMPageController *)pageController scrollViewDidScroll:(UIScrollView *)scrollView{

}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.showOnNavigationBar = NO;     //在导航栏上展示
        self.automaticallyCalculatesItemWidths = YES;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.scrollEnable = YES;
        self.titleSizeSelected = 18;
        self.titleSizeNormal = 15;
        self.progressColor = UIColorFromRGB(0x4B8096);
        self.progressViewCornerRadius = 2.0;
        self.progressHeight = 4.0;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected = UIColorFromRGB(0x111111);//333333
        self.itemMargin = 12;
        self.progressWidth = 20;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;//WMMenuViewLayoutModeLeft
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    self.requestTimes = 3;
    [super viewDidLoad];
    self.leftButton.hidden = YES;

    
    _kWMHeaderViewHeight = 1;
//    self.viewTop = (KNavAndStatusHight-44) + _kWMHeaderViewHeight;
    self.viewTop = 1;
    
    self.menuView.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
    
    _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _chatButton.backgroundColor = [UIColor clearColor];
    [_chatButton setImage:[UIImage imageNamed:@"home_chatIcon"] forState:UIControlStateNormal];
    _chatButton.frame = CGRectMake(SCREEN_WIDTH-70,SCREEN_HEIGHT*3/4-70, 70, 70);
    [self.view addSubview:_chatButton];
    [_chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.navigationController.navigationBar addSubview:self.searchView];
//
//    // home_message
//    [self.navigationController.navigationBar addSubview:self.messageBtn];
//
//    [self.navigationController.navigationBar addSubview:self.signBtn];
//
    
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 36)];
//    titleview.backgroundColor = [UIColor yellowColor];
    [titleview addSubview:self.searchView];
    self.searchView.frame = CGRectMake(-50, -8, SCREEN_WIDTH - 102, 60);
    [self.navigationItem setTitleView:titleview];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.signBtn],
                                                [[UIBarButtonItem alloc]initWithCustomView:self.messageBtn]];
    
    
    if (!Ktoken) {
        self.signBtn.selected = NO;
    } else {
       UserModel *user = [APPUserDefault getCurrentUserFromLocal];
        if (user && [user.is_sign integerValue] == 1) {
            self.signBtn.selected = YES;

//            [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        } else {
            self.signBtn.selected = NO;

//            [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
        }
    }
    
    [self judgeMessageReadStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideEmptyView];
    
    if (!Ktoken) {
        self.signBtn.selected = NO;
    } else {
       UserModel *user = [APPUserDefault getCurrentUserFromLocal];
        if (user && [user.is_sign integerValue] == 1) {
            self.signBtn.selected = YES;

//            [self.signBtn setTitle:@"已签到" forState:UIControlStateNormal];
        } else {
            self.signBtn.selected = NO;

//            [self.signBtn setTitle:@"签到" forState:UIControlStateNormal];
        }
    }
}

- (void)homeTabbarMoreClick{
    HomePageListTipView *_tipView1 = [[HomePageListTipView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_tipView1];
    _tipView1.dataArray = self.musicCategories;
    _tipView1.BlockItemClick = ^(NSInteger index) {
        self.selectIndex = index;
    };
}
- (void)chatButtonClick{
    WebsVC *w = [[WebsVC alloc] init];
     w.index = 3;
     [self.navigationController pushViewController:w animated:YES];
}

- (void)topRequest{

    _musicCategories = nil;
    WS(weakSelf)
    [APPRequest GET:@"/courseHomeCate" parameters:nil finished:^(AjaxResult *result) {
        if (result.code == AjaxResultStateSuccess) {
            
            [weakSelf.musicCategories addObjectsFromArray:result.data];
            [weakSelf reloadData];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            [btn setImage:[UIImage imageNamed:@"home_tabbar_more"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(0,0, 50, 50);
            [btn addTarget:self action:@selector(homeTabbarMoreClick) forControlEvents:UIControlEventTouchUpInside];
            weakSelf.menuView.rightView = btn;
            
            [weakSelf.view bringSubviewToFront:weakSelf.chatButton];
        }
    }];
}
- (void)loadNewData{
    [self topRequest];
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        HomeVC *vc = [[HomeVC alloc] init];
        vc.category = self.musicCategories[index][@"id"];
        return vc;
    }
    HomeCourseListVC *vc = [[HomeCourseListVC alloc] init];
    vc.category = self.musicCategories[index][@"id"];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index][@"cate_name"];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, _viewTop, self.view.frame.size.width, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = _viewTop + 50;
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}



- (void)judgeMessageReadStatus {
    if (!Ktoken) {
        _messageBtn.selected = NO;
//        _redView.hidden = YES;
            return;
    }
         WS(weakself)
    [APPRequest GET:@"/user/message" parameters:@{@"type":@"2"} finished:^(AjaxResult *result) {
             
             if (result.code == AjaxResultStateSuccess) {
                 
                 NSArray *arr = [ShopMessageModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
                 bool unread = false;
                 for (ShopMessageModel *model in arr) {
                     if ([model.isread intValue] == 0 ) {
                         unread = true;
                         break;
                     }
                 }
                 if (unread) {
                     _messageBtn.selected = YES;
//                     weakself.redView.hidden = NO;
                 } else {
                     _messageBtn.selected = NO;

//                     weakself.redView.hidden = YES;

                 }
                 
                 
             }
         }];
     

}
#pragma mark - get set
    - (HomeSearchCell *)searchView{
        
        if (_searchView == nil) {
            
            WS(weakself);
            _searchView = [[[NSBundle mainBundle] loadNibNamed:@"HomeSearchCell" owner:nil options:nil] lastObject];
            //placeholder_method_call//
           
            
            _searchView.frame = CGRectMake(0, -3, SCREEN_WIDTH - 101, 60);
            _searchView.searchBtn.layer.cornerRadius = 16.0;
            _searchView.viewbg.backgroundColor = [UIColor clearColor];
            _searchView.BlockSearchClick = ^{
                
                SearchVC *next = [[SearchVC alloc] init];
                BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
                [weakself presentViewController:nav animated:YES completion:nil];
            };
        }

        return _searchView;
    }

- (UIButton *)messageBtn {
    if (_messageBtn == nil) {
       _messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 103.0, 10, 24.0, 24.0)];
    //    b.backgroundColor = [UIColor yellowColor];
        [_messageBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
        [_messageBtn setImage:[UIImage imageNamed:@"home_message_gray"] forState:UIControlStateSelected];

//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(12.8, 3.3, 8, 8)];
//        v.layer.cornerRadius = 4.0;
////        v.hidden = YES;
//        self.redView = v;
//        v.backgroundColor = [UIColor colorWithHex:0xFF5656];
//        [_messageBtn addSubview:v];
            [_messageBtn addTarget:self action:@selector(messageclickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}
- (UIButton *)signBtn {
    if (_signBtn== nil) {
        _signBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 68, 10, 58, 24.0)];
    //    b.backgroundColor = [UIColor yellowColor];
        
        [_signBtn setImage:[UIImage imageNamed:@"home_sign"] forState:UIControlStateNormal];
        [_signBtn setImage:[UIImage imageNamed:@"home_sign_gray"] forState:UIControlStateSelected];

        _signBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_signBtn setTitleColor:[UIColor colorWithHex:0x323233] forState:UIControlStateNormal];
//        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn addTarget:self action:@selector(SignClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return   _signBtn;
}


- (void)messageclickAction:(UIButton *)b {
    if (!Ktoken) {
           [self loginAction];
           return;
       }
    ShopMessageVC *next = [[ShopMessageVC alloc] init];
                   [self.navigationController pushViewController:next animated:YES];


  
}
- (void)SignClick:(UIButton *)b {
//    PLPlayerViewController *vc = [[PLPlayerViewController alloc] initWithURL:[NSURL URLWithString:@"https://20200901164030.grazy.cn/oa_0ec879b7aea9e60ee22d36c0411a3d2f.mp3"]];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
    
    
    
    
    
    if (!Ktoken) {
           [self loginAction];
           return;
       }
//   NSString *title = [b titleForState:UIControlStateNormal];
    if (!b.selected) {
//        if ([self.model.is_sign integerValue] == 1) { //已签到
//
//            [self.view showTip:@"已签到"];
//            return;
//        }
        //placeholder_method_call//
        WS(weakself)
        [APPRequest GET:@"/sign" parameters:nil finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
            
                weakself.signBtn.selected = YES;

                [KeyWindow showTip:result.data[@"msg"]];
                UserModel *user = [APPUserDefault getCurrentUserFromLocal];
                user.is_sign = @"1";
                [APPUserDefault saveUserToLocal:user];
            }
        }];
    }
   

  
}
@end

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


@interface HomePageSegmentVC () <UIGestureRecognizerDelegate,WMPageControllerDelegate>

@property (nonatomic, strong) NSMutableArray *musicCategories;
//@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
//@property (nonatomic, assign) CGPoint lastPoint;
//
//@property (nonatomic,strong) NewCustomBanner *icarouselView;
@property (nonatomic,strong) NSArray *instItems;

@property (nonatomic,strong) UIImageView *tagImgView;

@property (nonatomic,assign) NSInteger requestTimes;
@end

@implementation HomePageSegmentVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (NSMutableArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = [NSMutableArray new];
//        [_musicCategories addObject:@{@"id":@"8",@"name":@"全部"}];
    }
    return _musicCategories;
}

- (void)pageController:(WMPageController *)pageController scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat widoffset = scrollView.contentOffset.x/SCREEN_WIDTH;
//
//    CGRect frame = [pageController.menuView.frames.firstObject CGRectValue];
//    CGFloat fff = frame.size.width+frame.origin.x;
//    if (SCREEN_WIDTH>375) {
//        self.tagImgView.center = CGPointMake(self.tagImgView.bounds.size.width/2*CustomScreenFit+(fff)*widoffset , 40);
//    }else{
//        self.tagImgView.center = CGPointMake(self.tagImgView.bounds.size.width/2+(fff+1)*widoffset , 40);
//    }
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
    

    
    _kWMHeaderViewHeight = 1;
//    self.viewTop = (KNavAndStatusHight-44) + _kWMHeaderViewHeight;
    self.viewTop = 1;
    
    self.menuView.backgroundColor = [UIColor whiteColor];
    [self loadNewData];
}


- (void)topRequest{

    
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    HomeTipBgView *_tipView1 = [[HomeTipBgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [[UIApplication sharedApplication].keyWindow addSubview:_tipView1];
//
//    UIView *showView = [[UIView alloc]init];
//    [_tipView1.allBgView addSubview:showView];
//    showView.backgroundColor = [UIColor redColor];
//    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.equalTo(_tipView1.allBgView);
//        make.top.equalTo(_tipView1.allBgView).offset(50);
//        make.bottom.equalTo(_tipView1.allBgView).offset(-90);
//        make.height.mas_equalTo(400);
//    }];
//});
    _musicCategories = nil;
    WS(weakSelf)
    [APPRequest GET:@"/courseHomeCate" parameters:nil finished:^(AjaxResult *result) {
        if (result.code == AjaxResultStateSuccess) {
            
            [weakSelf.musicCategories addObjectsFromArray:result.data];
            [weakSelf reloadData];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor greenColor];
            btn.frame = CGRectMake(0,0, 50, 50);
            weakSelf.menuView.rightView = btn;
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
    HomeVC *vc = [[HomeVC alloc] init];
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

@end

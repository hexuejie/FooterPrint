//
//  HomeVC.m
//  Zhongsheng
//
//  Created by 陈小卫 on 17/6/6.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "HomeCourseListVC.h"
#import "HomeCell.h"
#import "PackageVC.h"
#import "SearchVC.h"
#import "PackageDetailVC.h"
#import "CourseDetailVC.h"
//#import "HomelModel.h"
#import "HomeSearchCell.h"
#import "HomeBannerCell.h"
#import "HomeRichTexCell.h"
#import "HomePackageCell.h"
#import "HomeCourseCell.h"
#import "CourseVC.h"
#import "MJRefresh.h"
#import "MessageDetailVC.h"
#import "BuyVipVC.h"
#import "LivePageVC.h"
#import "LiveDetaileVC.h"
#import "LearnRecordVC.h"
#import "WebsVC.h"
#import "HotCourVC.h"
#import "PictureAndTextCell.h"
#import "CourseListCell.h"
#import "ShopMessageVC.h"
#import "PLPlayerViewController.h"
#import "ShopMessageModel.h"
#import "SaleSuperCell.h"
#import "SaleModel.h"
#import "GroupVC.h"
#import "HomeCourseHorizontalCell.h"
#import "LearnRecordModel.h"

@interface HomeCourseListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<CourslModel *> *dataSource;

@property (nonatomic, strong) NSMutableArray<HomeBannelModel *> *bannerArray;
@end

@implementation HomeCourseListVC

#pragma mark - 星链类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//
- (void)viewDidLoad{
    [super viewDidLoad];
    //placeholder_method_call//
    self.navigationItem.title = @"脚印云课";
    self.leftButton.hidden = YES;
    
    self.dataSource = [NSMutableArray array];
    

    if (@available(iOS 11.0, *)) {
        if (is_iPhoneXSerious) {
            self.additionalHeight = 20.0;

    }
        
        
    }
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, KViewHeight)];

    
    [self addDefaultFootView];
    self.BlockscrollViewClick = ^(UIScrollView * _Nonnull scrollView) {
        //去掉tableviewf悬浮
        CGFloat sectionHeaderHeight = 40;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    };
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeSearchCell" bundle:nil] forCellReuseIdentifier:@"HomeSearchCell"];
    [self.tableView registerClass:[HomeBannerCell class] forCellReuseIdentifier:@"HomeBannerCell"];
    [self.tableView registerClass:[HomeRichTexCell class] forCellReuseIdentifier:@"HomeRichTexCell"];
    [self.tableView registerClass:[HomePackageCell class] forCellReuseIdentifier:@"HomePackageCell"];
    [self.tableView registerClass:[HomeCourseCell class] forCellReuseIdentifier:@"HomeCourseCell"];
    [self.tableView registerClass:[HomeCourseHorizontalCell class] forCellReuseIdentifier:@"HomeCourseHorizontalCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SaleSuperCell" bundle:nil] forCellReuseIdentifier:@"SaleSuperCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
//    [self loadData];
    
//    [UIApplication sharedApplication].delegate.window.safeAreaInsets;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理
//placeholder_method_impl//
#pragma mark 系统代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.bannerArray.count) {
            return 1;
        }
        return 0;
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.bannerArray.count) {
            return SCREEN_WIDTH*140/345.0 +5;
        }
        return 0.0;
    }
    return 120.0 +5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBannerCell"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.dataSource = self.bannerArray;
        cell.BlockBannerClick = ^(HomeBannelModel * _Nonnull model) { //banner点击
            
            [self goingToTheControllerWith:model];
        };
        return cell;
    }
    
    
    
    CourslModel *model = self.dataSource[indexPath.row];
//    NSInteger type = [model.type integerValue];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseListCell" bundle:nil] forCellReuseIdentifier:@"CourseListCell"];
    CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseListCell" forIndexPath:indexPath];
    cell.topLineView.hidden = YES;
    cell.courseModel = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    if (indexPath.section) {
        CourslModel *model = self.dataSource[indexPath.row];
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.courseId = model.cid;
        next.goodsType = 1;
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadNewData{
    //placeholder_method_call//
    self.dataSource = [NSMutableArray array];
    [self loadData];
}

- (void)loadData{
   //placeholder_method_call//
    if (!_category) {
        _category = @"";
    }
    
    WS(weakself)
    [APPRequest GET:@"/bannerList" parameters:nil finished:^(AjaxResult *result) {

        [self.tableView.mj_header endRefreshing];
        if (result.code == AjaxResultStateSuccess) {
            weakself.bannerArray = [HomeBannelModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            
            [weakself.tableView reloadData];
        }
        
        if (self.dataSource && self.dataSource.count > 0) {
            [self performSelector:@selector(hideEmptyView) withObject:nil afterDelay:1];
        }
    }];
    
    
    [APPRequest GET:@"/searchHomeCourse" parameters:@{@"category":_category} finished:^(AjaxResult *result) {

        [self.tableView.mj_header endRefreshing];
        if (result.code == AjaxResultStateSuccess) {
            NSLog(@"result.data %@",result.data[@"list"]);
            NSArray *array = [CourslModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            [weakself.dataSource addObjectsFromArray:array];
            [weakself.tableView reloadData];
        }
        
        if (self.dataSource && self.dataSource.count > 0) {
            [self performSelector:@selector(hideEmptyView) withObject:nil afterDelay:1];
        }
    }];
}


- (void)goingToTheControllerWith:(HomeBannelModel *)model {
    if ([model.type isEqualToString:@"link"]) {
        if ([model.link containsString:@"service-page"]) {
            WebsVC *w = [[WebsVC alloc] init];
             w.index = 3;
             [self.navigationController pushViewController:w animated:YES];
        } else {
            MessageDetailVC *next = [[MessageDetailVC alloc] init];
            next.requsetUrl = model.link;
            [self.navigationController pushViewController:next animated:YES];
        }
       
        
       
        
    }else if ([model.type isEqualToString:@"package"]){
        
        PackageDetailVC *next = [[PackageDetailVC alloc] init];
        next.packId = model.id;
        [self.navigationController pushViewController:next animated:YES];
    }else if ([model.type isEqualToString:@"audio"]){
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.courseId = model.id;
        next.goodsType = 2;
        [self.navigationController pushViewController:next animated:YES];
    }else if ([model.type isEqualToString:@"course"]){
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.courseId = model.id;
        next.goodsType = 1;
        [self.navigationController pushViewController:next animated:YES];
    }else if ([model.type isEqualToString:@"allcourse"]){
        
        CourseVC *next = [[CourseVC alloc] init];
        next.isList = YES;
        [self.navigationController pushViewController:next animated:YES];
    }else if ([model.type isEqualToString:@"allpackage"]){
        
        PackageVC *next = [[PackageVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }else if ([model.type isEqualToString:@"vip"]){
        if (!Ktoken) {
            [self loginAction];
            return;
        }
        
        BuyVipVC *next = [[BuyVipVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    } else if ([model.type isEqualToString:@"group"]){
        
        GroupVC *next = [[GroupVC alloc] init];
//            next.navigationItem.title = model.link;
        next.id = model.id;
        [self.navigationController pushViewController:next animated:YES];
    }
}
@end

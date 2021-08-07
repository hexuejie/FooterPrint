//
//  HotCourseVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/1/23.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "HotCourVC.h"
#import "HomeCell.h"
#import "CourseDetailVC.h"
@interface HotCourVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<HomelModel *> *dataSource;
@end

@implementation HotCourVC

#pragma mark - 星链类注释逻辑

#pragma mark - 生命周期

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐课程";
    NSMutableArray *arr = @[].mutableCopy;
    
    self.dataSource = [NSArray array];
    
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

    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.content.count;

   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    HomelModel *model = self.dataSource[section];
//    NSInteger type = [model.type integerValue];
//
//    if (type == 3 || type == 6 || type == 7) {
//
//        return 45;
//    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    HomelModel *model = self.dataSource[section];
//
//
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
//
//    UILabel *title = [[UILabel alloc] init];
//    title.font = [UIFont boldSystemFontOfSize:16.0];
//    title.text = self.dataSource[section].type_name;
//    [view addSubview:title];
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.leading.mas_equalTo(12);
//        make.centerY.mas_equalTo(view).offset(8);
//    }];
//
//    UIImageView *img = [[UIImageView alloc] init];
//    img.image = [UIImage imageNamed:@"mine_arrow"];
//    [view addSubview:img];
//    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.trailing.mas_equalTo(view).offset(-12);
//        make.centerY.mas_equalTo(view).offset(8);
//    }];
//    img.hidden = [model.show_more integerValue] == 1?NO:YES;
//
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
//    [view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.left.trailing.bottom.mas_equalTo(view);
//    }];
//    [btn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//
//        if ([model.show_more integerValue] == 1) {
//
//            if ([model.type integerValue] == 3) { //课程列表
//
//                CourseVC *next = [[CourseVC alloc] init];
//                next.isList = YES;
//                [self.navigationController pushViewController:next animated:YES];
//
//            }else if ([model.type integerValue] == 6){ // 套餐列表
//
//                PackageVC *next = [[PackageVC alloc] init];
//                [self.navigationController pushViewController:next animated:YES];
//            }else if ([model.type integerValue] == 7){ //直播列表
//
//                LivePageVC *next = [[LivePageVC alloc] init];
//                [self.navigationController pushViewController:next animated:YES];
//            }
//        }
//    }];
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.model.content[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
    
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = [self.model.content[indexPath.row][@"goods_type"] integerValue];
        next.courseId = self.model.content[indexPath.row][@"cid"];
    if (self.model.content[indexPath.row][@"is_buy"]) {
        next.is_buy = [self.model.content[indexPath.row][@"is_buy"] longValue];

    }
        [self.navigationController pushViewController:next animated:YES];
    
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法




#pragma mark - 私有方法

#pragma mark - get set


@end

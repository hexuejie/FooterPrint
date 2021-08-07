//
//  OrderListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "OrderListVC.h"
#import "SilencePageView.h"
#import "SilenceAutoHeightTableViewUtil.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "OrderDetailVC.h"
#import "CourseDetailVC.h"

@interface OrderListVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSMutableArray<OrderModel *> *dataSource;

@property (nonatomic, strong) SilenceAutoHeightTableViewUtil *tableUtil;

@end

@implementation OrderListVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    self.dataSource = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    //placeholder_method_call//

    self.tableUtil = [[SilenceAutoHeightTableViewUtil alloc] initWithTableView:self.tableView dataSource:self.dataSource identifier:@"OrderCell" estimatedHeight:100 cellConfig:^(OrderCell *cell, NSIndexPath *indexPath, id data) {
        
        cell.model = self.dataSource[indexPath.row];
        [cell.btnLearn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            CourseDetailVC *next = [[CourseDetailVC alloc] init];
            next.goodsType = [self.dataSource[indexPath.row].c_type integerValue];
            next.courseId = self.dataSource[indexPath.row].type_id;
            [self.navigationController pushViewController:next animated:YES];
        }];
        
    } didSelectedRow:^(NSIndexPath *indexPath, id data) {
 
        OrderDetailVC *next = [[OrderDetailVC alloc] init];
        next.orderId = self.dataSource[indexPath.row].id;
        next.goodsType = [self.dataSource[indexPath.row].c_type integerValue];
        [self.navigationController pushViewController:next animated:YES];
    }];
    WS(weakself);
    self.tableUtil.scrollViewDidScrollBlock = ^(UIScrollView *scrollView) {
        
        [weakself setFootViewoffset:scrollView];
    };
    self.additionalHeight = -50;
    [self addDefaultFootView];
    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/myOrderList" parameters:nil pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeShop eventBlock:^(EmptyViewEventType eventType) {
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:[OrderModel mj_objectArrayWithKeyValuesArray:datas]];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}

- (void)loadData{
    
    [self.pageView downRefresh];
}

@end

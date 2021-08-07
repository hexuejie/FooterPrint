//
//  EnterpriseLisrVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "EnterpriseLisrVC.h"
#import "SilencePageView.h"
#import "SilenceAutoHeightTableViewUtil.h"
#import "OrderCell.h"
#import "EnterpriseModel.h"
#import "CourseDetailVC.h"
#import "EnterpriseDetailVC.h"

@interface EnterpriseLisrVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSMutableArray<EnterpriseModel *> *dataSource;

@property (nonatomic, strong) SilenceAutoHeightTableViewUtil *tableUtil;

@end

@implementation EnterpriseLisrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"企业开通";
    
    self.dataSource = [NSMutableArray array];
    //placeholder_method_call//

    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    
    self.tableUtil = [[SilenceAutoHeightTableViewUtil alloc] initWithTableView:self.tableView dataSource:self.dataSource identifier:@"OrderCell" estimatedHeight:100 cellConfig:^(OrderCell *cell, NSIndexPath *indexPath, id data) {
        
        //企业订单
        cell.enterModel = self.dataSource[indexPath.row];
        [cell.btnLearn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           
            CourseDetailVC *next = [[CourseDetailVC alloc] init];
            next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
            next.courseId = self.dataSource[indexPath.row].cid;
            [self.navigationController pushViewController:next animated:YES];
        }];
        
    } didSelectedRow:^(NSIndexPath *indexPath, id data) {
        
        EnterpriseDetailVC *next = [[EnterpriseDetailVC alloc] init];
        next.sid = self.dataSource[indexPath.row].sid;
        next.cid = self.dataSource[indexPath.row].cid;
        [self.navigationController pushViewController:next animated:YES];
    }];
    WS(weakself);
    self.tableUtil.scrollViewDidScrollBlock = ^(UIScrollView *scrollView) {
        
        [weakself setFootViewoffset:scrollView];
    };
    self.additionalHeight = -50;
    [self addDefaultFootView];
    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/user/agencyCourse" parameters:nil pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeEnterprise eventBlock:^(EmptyViewEventType eventType) {
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:[EnterpriseModel mj_objectArrayWithKeyValuesArray:datas]];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}
//placeholder_method_impl//

- (void)loadData{
    //placeholder_method_call//

    [self.pageView downRefresh];
}
//placeholder_method_impl//


@end

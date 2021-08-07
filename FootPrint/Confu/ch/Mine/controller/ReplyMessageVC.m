//
//  ReplyMessageVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "ReplyMessageVC.h"
#import "ReplyMessageCell.h"
#import "SilenceAutoHeightTableViewUtil.h"
#import "SilencePageView.h"
#import "ShopMessageModel.h"

@interface ReplyMessageVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSMutableArray<ShopMessageModel *> *dataSource;

@property (nonatomic, strong) SilenceAutoHeightTableViewUtil *tableUtil;

@end

@implementation ReplyMessageVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-45-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyMessageCell" bundle:nil] forCellReuseIdentifier:@"ReplyMessageCell"];
    
    self.tableUtil = [[SilenceAutoHeightTableViewUtil alloc] initWithTableView:self.tableView dataSource:self.dataSource identifier:@"ReplyMessageCell" estimatedHeight:100 cellConfig:^(ReplyMessageCell *cell, NSIndexPath *indexPath, id data) {
        
        cell.model = self.dataSource[indexPath.row];
        
    } didSelectedRow:^(NSIndexPath *indexPath, id data) {
        
    }];
    WS(weakself);
    self.tableUtil.scrollViewDidScrollBlock = ^(UIScrollView *scrollView) {
      
        [weakself setFootViewoffset:scrollView];
    };
    self.additionalHeight = -50;
    [self addDefaultFootView];
    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/user/message" parameters:@{@"type":@"1",} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeMessage eventBlock:^(EmptyViewEventType eventType) {
                    
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:[ShopMessageModel mj_objectArrayWithKeyValuesArray:datas]];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    
    [self.pageView downRefresh];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

//
//  CompleteCouseVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CompleteCouseVC.h"
#import "SilencePageView.h"
#import "HomeCell.h"
#import "AddOrderFooterModel.h"
#import "CourseDetailVC.h"

@interface CompleteCouseVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSMutableArray<OrderInfoFootModel *> *dataSource;

@end

@implementation CompleteCouseVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"完成课程";
    
    self.dataSource = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    self.additionalHeight = -50;
    [self addDefaultFootView];
    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/myFinishCourse" parameters:nil pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeComplete eventBlock:^(EmptyViewEventType eventType) {
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            self.dataSource = [OrderInfoFootModel mj_objectArrayWithKeyValuesArray:datas];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}
//placeholder_method_impl//

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    //placeholder_method_call//

    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.infoModel = self.dataSource[indexPath.row];
    
    return cell;
}
//placeholder_method_impl//


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.courseId = self.dataSource[indexPath.row].cid;
    //placeholder_method_call//

    next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    //placeholder_method_call//

    [self.pageView downRefresh];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

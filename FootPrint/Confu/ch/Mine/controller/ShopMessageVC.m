//
//  ShopMessageVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "ShopMessageVC.h"
#import "ShopMessageCell.h"
#import "SilencePageView.h"
#import "ShopMessageModel.h"
#import "MessageDetailVC.h"

@interface ShopMessageVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<ShopMessageModel *> *dataSource;

@end

@implementation ShopMessageVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    
    self.dataSource = [NSArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopMessageCell" bundle:nil] forCellReuseIdentifier:@"ShopMessageCell"];
    self.additionalHeight = -50;
    [self addDefaultFootView];
    //placeholder_method_call//

    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/user/message" parameters:@{@"type":@"2",} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.dataSource = [ShopMessageModel mj_objectArrayWithKeyValuesArray:datas];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}
//placeholder_method_impl//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopMessageCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
  //placeholder_method_call//

    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageDetailVC *next = [[MessageDetailVC alloc] init];
    next.messageId = self.dataSource[indexPath.row].id;
    [self.navigationController pushViewController:next animated:YES];
   //placeholder_method_call//

    self.dataSource[indexPath.row].isread = @"1";
    [self.tableView reloadData];
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    
    [self.pageView downRefresh];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

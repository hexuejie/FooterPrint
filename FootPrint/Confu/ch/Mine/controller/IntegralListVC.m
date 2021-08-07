//
//  IntegralListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "IntegralListVC.h"
#import "IntegralCell.h"
#import "SilencePageView.h"
#import "IntegralModel.h"
#import "GoldModel.h"

@interface IntegralListVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<IntegralModel *> *dataSource;

@property (nonatomic, strong) NSArray<GoldModel *> *goldDataSource;

@end

@implementation IntegralListVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.goldDataSource = [NSArray array];
    self.dataSource = [NSArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-55-120-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"IntegralCell" bundle:nil] forCellReuseIdentifier:@"IntegralCell"];
    self.additionalHeight = -50;
    [self addDefaultFootView];
    //placeholder_method_call//

    NSString *url = self.isGold?@"/myGold":@"/integralList";
    self.pageView = [[SilencePageView alloc] get:self.tableView url:url parameters:@{@"type":[NSString stringWithFormat:@"%ld",self.type]} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            if (self.isGold) {
                
                self.goldDataSource = [GoldModel mj_objectArrayWithKeyValuesArray:datas];
            }else{
             
                self.dataSource = [IntegralModel mj_objectArrayWithKeyValuesArray:datas];
            }
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}

#pragma mark - 代理
//placeholder_method_impl//

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.isGold?self.goldDataSource.count:self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    //placeholder_method_call//

    if (self.isGold) {
        
        cell.goldModel = self.goldDataSource[indexPath.row];
    }else{
        cell.model = self.dataSource[indexPath.row];
    }
    
    return cell;
}
//placeholder_method_impl//

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)reloadData{
    
    [self.pageView downRefresh];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)loadData{
    //placeholder_method_call//

    [self.pageView downRefresh];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

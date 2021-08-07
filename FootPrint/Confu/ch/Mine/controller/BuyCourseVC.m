//
//  CourseListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyCourseVC.h"
#import "HomeCell.h"
#import "PackageModel.h"
#import "CourseDetailVC.h"
@interface BuyCourseVC ()

@property (nonatomic, strong) PackageModel *model;

@end

@implementation BuyCourseVC

#pragma mark - yy类注释逻辑
//placeholder_method_impl//

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"套餐名称";
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    //placeholder_method_call//

    [self addDefaultFootView];
    self.additionalHeight = 50;
    //placeholder_method_call//
    [self loadData];
}
//placeholder_method_impl//


#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //placeholder_method_call//

    return self.model.course_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 115;
}
//placeholder_method_impl//


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    cell.orderModel = self.model.course_list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [self.model.course_list[indexPath.row].goods_type integerValue];
    //placeholder_method_call//

    next.courseId = self.model.course_list[indexPath.row].cid;
    [self.navigationController pushViewController:next animated:YES];
}
//placeholder_method_impl//

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    
    [APPRequest GET:@"/packageDetail" parameters:@{@"id":self.packId} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [PackageModel mj_objectWithKeyValues:result.data];
            [self.tableView reloadData];
        }
    }];
    //placeholder_method_call//

}
//placeholder_method_impl//

#pragma mark - 私有方法

#pragma mark - get set

@end

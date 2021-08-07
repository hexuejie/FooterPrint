//
//  MoreSaleVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/7.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "MoreSaleVC.h"
#import "SaleListCell.h"
#import "CourslModel.h"
#import "CourseDetailVC.h"
@interface MoreSaleVC ()
@property (nonatomic,strong) NSArray<CourslModel *> *content;

@end

@implementation MoreSaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"限时优惠";
    [self setTableViewFram:CGRectMake(27, 0, SCREEN_WIDTH - 27, SCREEN_HEIGHT - KNavAndStatusHight- KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"SaleListCell" bundle:nil] forCellReuseIdentifier:@"SaleListCell"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadData{
   //placeholder_method_call//

    
    WS(weakself)
    [APPRequest GET:@"/goodsDiscountList" parameters:@{@"size":@1000} finished:^(AjaxResult *result) {

//        [self.tableView.mj_header endRefreshing];
        if (result.code == AjaxResultStateSuccess) {

       
             
//            NSMutableArray *mutableArr = [NSMutableArray array];
//            self.dataSource = mutableArr;
//
//            [self.tableView reloadData];
//
//            HomelModel *model = [[HomelModel alloc] init];
            weakself.content = [CourslModel mj_objectArrayWithKeyValuesArray:result.data[@"data"]];
            [weakself.tableView reloadData];
   
        }
        
        

       
        
    }];
    
    
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.content.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.content[indexPath.row].is_buy == 1) {
        return 135;
    }
    return 162.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SaleListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SaleListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.courseModel = self.content[indexPath.row];
    cell.csrightConst.constant = 27.0;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CourslModel *courseModel = self.content[indexPath.row];
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.end_time = courseModel.end_time;
    next.goodsType = [courseModel.goods_type intValue];
    next.courseId = courseModel.course_id;
    [self.navigationController pushViewController:next animated:YES];
}

@end

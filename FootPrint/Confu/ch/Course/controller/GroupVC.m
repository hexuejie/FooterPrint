//
//  MoreSaleVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/7.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "GroupVC.h"
//#import "SaleListCell.h"
#import "CourseListCell.h"
#import "CourslModel.h"
#import "CourseDetailVC.h"
@interface GroupVC ()
@property (nonatomic,strong) NSArray<CourslModel *> *content;

@end

@implementation GroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"课程组";
//    [self setTableViewFram:CGRectMake(, 0, SCREEN_WIDTH - 27, SCREEN_HEIGHT)];
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseListCell" bundle:nil] forCellReuseIdentifier:@"CourseListCell"];
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

    NSMutableDictionary *param = @{
        @"gid": self.id
    };
    WS(weakself)
    [APPRequest GET:@"/courseGroupList" parameters:param finished:^(AjaxResult *result) {

//        [self.tableView.mj_header endRefreshing];
        if (result.code == AjaxResultStateSuccess) {

       
             
//            NSMutableArray *mutableArr = [NSMutableArray array];
//            self.dataSource = mutableArr;
//
//            [self.tableView reloadData];
//
//            HomelModel *model = [[HomelModel alloc] init];
           weakself.content = [CourslModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            weakself.navigationItem.title = result.data[@"group_title"];
            [weakself.tableView reloadData];
   
        }
        
        

       
        
    }];
    
    
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.content.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"CourseListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.courseModel = self.content[indexPath.row];
//    cell.csrightConst.constant = 27.0;
    cell.csTopConstraint.constant = 25.0;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CourslModel *courseModel = self.content[indexPath.row];
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [courseModel.goods_type intValue];
    next.courseId = courseModel.cid;
    [self.navigationController pushViewController:next animated:YES];
}

@end

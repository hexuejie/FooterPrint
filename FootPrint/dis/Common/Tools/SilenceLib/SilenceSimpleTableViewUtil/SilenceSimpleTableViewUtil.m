//
//  SilenceSimpleTableViewUtil.m
//  SilenceIOS_OC
//
//  Created by SilenceMac on 15/12/25.
//  Copyright © 2015年 SilenceMac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SilenceSimpleTableViewUtil.h"
@interface SilenceSimpleTableViewUtil()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) void(^cellConfigBlock)(id cell, NSIndexPath *indexPath, id data);
@property(strong,nonatomic) void(^didSelectedRowBlock)(NSIndexPath *indexPath, id data);
@property(strong,nonatomic)  CGFloat(^cellHeightBlock)(NSIndexPath *indexPath);
@property(strong,nonatomic) NSString *identifier;
@property(weak,nonatomic) UITableView *tableView;
@property(weak,nonatomic) NSArray *dataSource;
@end
@implementation SilenceSimpleTableViewUtil



-(instancetype)initWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource identifier:(NSString *)identifier cellHeight:(CGFloat(^)(NSIndexPath *indexPath))cellHeightBlock cellConfig:(void(^)(id cell, NSIndexPath *indexPath, id data))cellConfigBlock didSelectedRow:(void(^)(NSIndexPath *indexPath, id data))didSelectedRowBlock {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.dataSource = dataSource;
        self.identifier = identifier;
        self.cellHeightBlock =cellHeightBlock;
        self.cellConfigBlock = cellConfigBlock;
        self.didSelectedRowBlock = didSelectedRowBlock;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.01)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.01)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (![NSString isEmpty:nibPath]) {
            [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
        }else{
            [self.tableView registerClass:NSClassFromString(self.identifier) forCellReuseIdentifier:self.identifier];
        }
//        [self.tableView registerClass:NSClassFromString(self.identifier) forCellReuseIdentifier:self.identifier];
//        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellHeightBlock) {
        return _cellHeightBlock(indexPath);
    }else{
        return 44;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (cell == nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellConfigBlock) {
        self.cellConfigBlock(cell,indexPath,self.dataSource[indexPath.row]);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectedRowBlock) {
        self.didSelectedRowBlock(indexPath,self.dataSource[indexPath.row]);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollViewDidScrollBlock != nil) {
        self.scrollViewDidScrollBlock(scrollView);
    }
}
@end

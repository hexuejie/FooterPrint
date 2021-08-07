//
//  SilenceAutoHeightTableViewUtil.m
//
//  表格自动行高工具
//  Created by Silence on 2017/3/1.
//  Copyright © 2017年 陈小卫. All rights reserved.
//

#import "SilenceAutoHeightTableViewUtil.h"

@interface SilenceAutoHeightTableViewUtil()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) void(^cellConfigBlock)(id cell, NSIndexPath *indexPath, id data);
@property(strong,nonatomic) void(^didSelectedRowBlock)(NSIndexPath *indexPath, id data);
@property(nonatomic, assign) CGFloat estimatedHeight;
@property(strong,nonatomic) NSString *identifier;
@property(weak,nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度所用字典

@property (nonatomic, strong) UIView *footerView;

@end

@implementation SilenceAutoHeightTableViewUtil

-(instancetype)initWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource identifier:(NSString *)identifier estimatedHeight:(CGFloat)estimatedHeight cellConfig:(void (^)(id, NSIndexPath *, id))cellConfigBlock didSelectedRow:(void (^)(NSIndexPath *, id))didSelectedRowBlock{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.dataSource = dataSource;
        self.identifier = identifier;
        self.estimatedHeight = estimatedHeight;
        self.cellConfigBlock = cellConfigBlock;
        self.didSelectedRowBlock = didSelectedRowBlock;
//        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.01)];
//        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.01)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = estimatedHeight;
        self.heightAtIndexPath = @{}.mutableCopy;
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (![NSString isEmpty:nibPath]) {
            [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
        }else{
            [self.tableView registerClass:NSClassFromString(self.identifier) forCellReuseIdentifier:self.identifier];
        }
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return self.estimatedHeight;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        dispatch_async(dispatch_get_main_queue(),^{
            NSLog(@"加载完成！！！");
            if (!self.isGetheight) {
                if (self.BlockGetHeight) {
                    self.BlockGetHeight(self.heightAtIndexPath);
                    self.isGetheight = YES;
                }
            }
        });
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

-(void)clearHeightCache{
    [self.heightAtIndexPath removeAllObjects];
}

@end

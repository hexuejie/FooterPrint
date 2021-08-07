//
//  SilenceAutoHeightTableViewUtil.h
//
//  表格自动行高工具
//  Created by Silence on 2017/3/1.
//  Copyright © 2017年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SilenceAutoHeightTableViewUtil : NSObject
@property (nonatomic, strong) void(^scrollViewDidScrollBlock)(UIScrollView *scrollView);
-(instancetype)initWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource identifier:(NSString *)identifier estimatedHeight:(CGFloat)estimatedHeight cellConfig:(void(^)(id cell, NSIndexPath *indexPath, id data))cellConfigBlock didSelectedRow:(void(^)(NSIndexPath *indexPath, id data))didSelectedRowBlock;

-(void)clearHeightCache;
@property(weak,nonatomic) NSArray *dataSource;

@property (nonatomic, copy) void (^BlockGetHeight)(NSMutableDictionary *heightCache);

@property(nonatomic,assign) BOOL isGetheight;

@end

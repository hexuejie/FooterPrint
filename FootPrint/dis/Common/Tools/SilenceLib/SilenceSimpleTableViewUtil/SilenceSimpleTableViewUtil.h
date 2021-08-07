//
//  SilenceSimpleTableViewUtil.h
//  SilenceIOS_OC
//  表格工具类
//  Created by SilenceMac on 15/12/25.
//  Copyright © 2015年 SilenceMac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SilenceSimpleTableViewUtil : NSObject
@property (nonatomic, strong) void(^scrollViewDidScrollBlock)(UIScrollView *scrollView);
-(instancetype)initWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource identifier:(NSString *)identifier cellHeight:(CGFloat(^)(NSIndexPath *indexPath))cellHeightBlock cellConfig:(void(^)(id cell, NSIndexPath *indexPath, id data))cellConfigBlock didSelectedRow:(void(^)(NSIndexPath *indexPath, id data))didSelectedRowBlock;
@end

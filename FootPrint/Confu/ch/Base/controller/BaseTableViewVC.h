//
//  BaseTableViewVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/26.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewVC : BaseVC

@property (nonatomic, strong) UITableView *tableView;
//placeholder_property//
//先设置tableviewFram
- (void)setTableViewFram:(CGRect)fram;
//placeholder_property//
//在根据需求是否添加尾部视图  最后根据需求添加刷新方法 ！！！！按照顺序调用方法
- (void)addDefaultFootView;

- (void)reloadFootViewLayout;
//placeholder_property//
//额外高度，个别特殊页面需要添加高度
@property (nonatomic, assign) CGFloat additionalHeight;
//placeholder_property//
@property (nonatomic, copy) void (^BlockscrollViewClick)(UIScrollView *scrollView);
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
- (void)setFootViewoffset:(UIScrollView *)scrollView;
//placeholder_property//
@property (nonatomic, strong) UIView *footerView;
//placeholder_method_declare//
//placeholder_method_declare//
@end

NS_ASSUME_NONNULL_END

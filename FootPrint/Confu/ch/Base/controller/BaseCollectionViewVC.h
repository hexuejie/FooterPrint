//
//  BaseCollectionViewVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewVC : BaseVC

@property (nonatomic, strong) UICollectionView *collectionView;
//placeholder_property//
//先设置tableviewFram
- (void)setCollectionViewFram:(CGRect)fram Layout:(UICollectionViewFlowLayout *)layout;
//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//在根据需求是否添加尾部视图  最后根据需求添加刷新方法 ！！！！按照顺序调用方法
- (void)addDefaultFootView;
//placeholder_property//
- (void)reloadFootViewLayout;

//额外高度，个别特殊页面需要添加高度
@property (nonatomic, assign) CGFloat additionalHeight;
//placeholder_property//
@property (nonatomic, copy) void (^BlockscrollViewClick)(UIScrollView *scrollView);
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

//
//  SilenceAutoHeightScrollView.h
//  FzShop
//  用于填充内容后自动撑开高度
//  Created by Silence on 2016/11/9.
//  Copyright © 2016年 FzShop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SilenceAutoHeightScrollViewModel.h"

typedef void (^ConfigViewBlock)(UIView *v,id data,NSInteger index);

@interface SilenceAutoHeightScrollView : UIScrollView

// 装视图的主View
@property (nonatomic , strong) UIView *contentView;



/**
 初始化视图
 */
@property (nonatomic , strong) ConfigViewBlock configViewBlock;

/**
 设置视图内容，传入数组
 */
@property (nonatomic , weak) NSArray<SilenceAutoHeightScrollViewModel *> *childs;


/**
 重新加载所有视图
 */
-(void)reload;


/**
 便捷初始化方法

 @param childs SilenceAutoHeightScrollViewModel 数组
 @param configViewBlock 初始化block
 @return 返回 初始化完成的SilenceAutoHeightScrollView
 */
-(instancetype)initWithChilds:(NSArray<SilenceAutoHeightScrollViewModel *> *)childs configViewBlock:(ConfigViewBlock)configViewBlock;

@end

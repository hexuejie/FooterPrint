//
//  MJCustomFooter.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/6.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MJRefreshAutoFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJCustomFooter : MJRefreshAutoFooter

/** 显示刷新状态的label */
@property (nonatomic, strong) UILabel *stateLabel;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 隐藏刷新状态的文字 */
@property (assign, nonatomic, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;

@end

NS_ASSUME_NONNULL_END

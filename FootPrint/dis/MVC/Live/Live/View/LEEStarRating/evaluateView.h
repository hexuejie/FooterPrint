//
//  evaluateController.h
//  LEEStarRating
//

//  Created by 莫瑞权 on 2018/8/14.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface evaluateView : UIView

@property(nonatomic,assign)CGRect evaluateFrame;


/**
 当前分数变更Block
 */
@property (nonatomic , copy ) void (^currentScoreChangeBlock)(NSMutableDictionary*cict);
@property (nonatomic , copy ) void (^exitBlock)(NSDictionary*cict);
+ (id)initView;


//得分配置
- (void)setScoreConfig:(NSDictionary*)config;
@end

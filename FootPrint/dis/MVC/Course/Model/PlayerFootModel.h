//
//  PlayerModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/16.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerFootModel : JKDBModel

//播放视频课程id
@property (nonatomic, strong) NSString *playerId;

//课程id
@property (nonatomic, strong) NSString *courseId;

//播放时长
@property (nonatomic, assign) NSInteger playerTime;

@end

NS_ASSUME_NONNULL_END

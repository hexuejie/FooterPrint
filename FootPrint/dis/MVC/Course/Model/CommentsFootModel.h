//
//  CommentsModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsFootModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *footCreate_time;

@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_like;

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *reply;
@property (nonatomic, strong) NSString *footreply;

@property (nonatomic, strong) NSString *supnum;

@end

NS_ASSUME_NONNULL_END

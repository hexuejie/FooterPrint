//
//  APPCache.h
//  VegetableBasket
//
//  Created by Silence on 2017/1/20.
//  Copyright © 2017年 YHS. All rights reserved.
//

/**
 缓存类型类型
 */
typedef enum : NSUInteger {
    CacheTypeArea, // 地区缓存
    CacheTypeStore, // 店铺信息缓存
    CacheTypeUser, // 用户缓存
    CacheTypeCourse, // 下载课程缓存
    CacheTypeLocation, // 当前位置缓存
} CacheType;

#import "JKDBModel.h"

@interface APPCache : JKDBModel

@property (assign, nonatomic) CacheType cacheType;
@property (strong, nonatomic) NSString *cacheJson;
@property (strong, nonatomic) NSDictionary *cacheDic;
@property (strong, nonatomic) NSArray *cacheAry;

@end

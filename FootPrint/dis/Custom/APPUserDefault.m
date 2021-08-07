//
//  APPUserDefault.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/14.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "APPUserDefault.h"
#import "APPCache.h"

@implementation APPUserDefault

#pragma mark 本地用户信息

//保存用户到本地
+(void)saveUserToLocal:(UserModel *)user{

    [self removeCurrentUserFromLocal];
    APPCache *cache = [[APPCache alloc] init];
    cache.cacheType = CacheTypeUser;
    
    cache.cacheJson = user.mj_JSONString;
    [cache saveOrUpdate];
}

//从本地获取用户
+(UserModel *)getCurrentUserFromLocal{
    NSString *where = [NSString stringWithFormat:@"where cacheType=%ld",CacheTypeUser];
    APPCache *cache = [APPCache findFirstWithFormat:where];
    
    if (cache != nil) {
        return [UserModel mj_objectWithKeyValues:cache.cacheJson];
    }
    return nil;
}

+(void)removeCurrentUserFromLocal{
    NSString *where = [NSString stringWithFormat:@"where cacheType=%ld",CacheTypeUser];
    [APPCache deleteObjectsWithFormat:where];
}


/** 保存用户位置信息到本地 */
+(void) saveUserLocation:(UserLocation *)location{
   
    [self removeCurrentUserLocatino];
    APPCache *cache = [[APPCache alloc] init];
    cache.cacheType = CacheTypeLocation;
    cache.cacheJson = location.mj_JSONString;
    [cache saveOrUpdate];
}

/** 获取用户位置信息 */
+(UserLocation *) getCurrentUserLocation{
    NSString *where = [NSString stringWithFormat:@"where cacheType=%ld",CacheTypeLocation];
    APPCache *cache = [APPCache findFirstWithFormat:where];
    if (cache != nil) {
        return [UserLocation mj_objectWithKeyValues:cache.cacheJson];
    }
    return nil;
}

/** 退出登录，清空本地用户位置信息 */
+(void) removeCurrentUserLocatino{
    NSString *where = [NSString stringWithFormat:@"where cacheType=%ld",CacheTypeLocation];
    [APPCache deleteObjectsWithFormat:where];
}

@end

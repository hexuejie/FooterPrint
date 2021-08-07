//
//  APPUserDefault.h
//  VegetableBasket
//  沙盒储存管理类
//  Created by Silence on 2017/1/14.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "UserLocation.h"
#import "CourseDetailModel.h"

@interface APPUserDefault : NSObject

/** 保存用户信息到本地 */
+(void) saveUserToLocal:(UserModel *) u;

/** 获取本地登录的用户信息 */
+(UserModel *) getCurrentUserFromLocal;

/** 退出登录，清空本地用户信息 */
+(void) removeCurrentUserFromLocal;


/** 保存用户位置信息到本地 */
+(void) saveUserLocation:(UserLocation *) location;

/** 获取用户位置信息 */
+(UserLocation *) getCurrentUserLocation;

/** 退出登录，清空本地用户位置信息 */
+(void) removeCurrentUserLocatino;

@end

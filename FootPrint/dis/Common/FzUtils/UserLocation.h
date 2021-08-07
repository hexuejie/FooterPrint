//
//  UserLocation.h
//  BetterLife
//
//  Created by feizhuo on 14/12/6.
//  Copyright (c) 2014年 feizhuo. All rights reserved.
//

#import "JKDBModel.h"

@interface UserLocation : JKDBModel

/**
 纬度
 */
@property (nonatomic, assign)CGFloat latitude;

/**
 经度
 */
@property (nonatomic, assign)CGFloat longitude;



/**
 省份
 */
@property (nonatomic, strong)NSString *province;

/**
 城市
 */
@property (nonatomic, strong)NSString *city;

/**
 区
 */
@property (nonatomic, strong)NSString *area;

/**
 地址
 */
@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *locationTime;


// 冗余，用于做POI搜索的时候
//@property (strong, nonatomic) NSString *poiInfoName;

// 冗余，用于做当前城市的筛选
//@property (strong, nonatomic) NSString *cityID;

@end

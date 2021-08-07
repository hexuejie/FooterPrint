//
//  UserModel.m
//  VegetableBasket
//
//  Created by 陈小卫 on 17/1/16.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "UserModel.h"

@implementation UserInfoModel

@end

@implementation WeekModel

@end

@implementation UserModel
+ (NSDictionary *)mj_objectClassInArray{
    
  return @{@"user":[UserInfoModel class],
           @"week":[WeekModel class]};
}
@end

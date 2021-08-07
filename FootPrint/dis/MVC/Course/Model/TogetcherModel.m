//
//  TogetcherModel.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/10.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "TogetcherModel.h"
@implementation ShopModel

@end
@implementation TogetcherModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"shop":[ShopModel class],
             @"user":[GroupUserModel class]
             };
}


@end

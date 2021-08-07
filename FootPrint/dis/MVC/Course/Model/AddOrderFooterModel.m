//
//  AddOrderModel.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "AddOrderFooterModel.h"

@implementation OrderInfoFootModel

@end

@implementation OrderIntegralFooterModel

@end

@implementation AddOrderFooterModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"integral_data":[OrderIntegralFooterModel class],
             @"orderInfo":[OrderInfoFootModel class]
             };
}

@end

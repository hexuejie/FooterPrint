//
//  BuyVipModel.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyVipModel.h"

@implementation VipModel

@end

@implementation BuyVipModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"card_list":[VipModel class]};
}
@end

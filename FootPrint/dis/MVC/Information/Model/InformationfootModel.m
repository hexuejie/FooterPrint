
//
//  InformationModel.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "InformationfootModel.h"

@implementation InformationScreeninmodel

@end

@implementation InformationfootModel

@end

@implementation InformationDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"prev_article":[InformationfootModel class],
             @"next_article":[InformationfootModel class],
             };
}

@end

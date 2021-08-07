//
//  PackageModel.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/13.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "PackageModel.h"

@implementation PackageInflModel

@end

@implementation PackageModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"package_info":[PackageInflModel class],
             @"course_list":[CourslModel class]
             };
}

@end

//
//  PackageModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/13.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourslModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PackageInflModel : NSObject

@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *closed;
@property (nonatomic, strong) NSString *footClosed;

@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderby;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *footTitle;
@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, strong) NSString *wxminicode;
@property (nonatomic, strong) NSString *desc;

@end

@interface PackageModel : NSObject

@property (nonatomic, strong) NSString *vip_switch;
@property (nonatomic, strong) NSString *isBuy;
@property (nonatomic, strong) NSString *footisBuy;
@property (nonatomic, strong) NSArray<CourslModel *> *course_list;
@property (nonatomic, strong) NSString *is_vip;
@property (nonatomic, strong) PackageInflModel *package_info;

@end

NS_ASSUME_NONNULL_END

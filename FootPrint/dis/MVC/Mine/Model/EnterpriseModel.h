//
//  EnterpriseModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnterpriseModel : NSObject

@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *cid;

@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *expire_time;

@end

NS_ASSUME_NONNULL_END

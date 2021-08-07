//
//  BuyVipModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isSelect;

@end

@interface BuyVipModel : NSObject

@property (nonatomic, strong) NSString *vip;
@property (nonatomic, strong) NSArray<VipModel *> *card_list;
@property (nonatomic, strong) NSString *expire_time;
@property (nonatomic, strong) NSString *explain;
@property (nonatomic, strong) NSDictionary *user;

@end

NS_ASSUME_NONNULL_END

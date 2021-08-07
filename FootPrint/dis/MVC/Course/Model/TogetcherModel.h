//
//  TogetcherModel.h
//  FootPrint
//
//  Created by 胡翔 on 2021/5/10.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface ShopModel : NSObject
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, assign) long commander;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, assign) long end_time;
@property (nonatomic, assign) long goods_type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSString *items_sn;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *shop_id;
@property (nonatomic, assign) long spell_endTime;
@property (nonatomic, assign) long spell_num;
@property (nonatomic, strong) NSString *spell_price;
@property (nonatomic, assign) long status;
@property (nonatomic, strong) NSString *title;
@end

@interface TogetcherModel : NSObject
@property (nonatomic, assign) long end;
@property (nonatomic, assign) long missing;
@property (nonatomic, assign) long now;
@property (nonatomic, assign) long see;
@property (nonatomic, strong) ShopModel *shop;
@property (nonatomic, strong) NSString *succcess_time;
@property (nonatomic, assign) long u_isitem;
@property (nonatomic, strong) NSString *u_isitem_msg;
@property (nonatomic, strong) NSArray<GroupUserModel *> *user;
@property (nonatomic, strong) NSString *share_url;

@end

NS_ASSUME_NONNULL_END

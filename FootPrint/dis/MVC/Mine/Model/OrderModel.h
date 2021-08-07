//
//  OrderModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *c_type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_spell;
@property (nonatomic, strong) NSString *old_price;

@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *pay_price;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type_id;

@property (nonatomic, strong) NSString *cash_deducted;
@property (nonatomic, strong) NSString *coupon_deducted;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *expire_show;

@property (nonatomic, strong) NSString *expire_time;
@property (nonatomic, strong) NSString *live_state;
@property (nonatomic, strong) NSString *live_title;
@property (nonatomic, strong) NSString *order_sn;

@property (nonatomic, strong) NSString *rebate_deducted;
@property (nonatomic, strong) NSString *spell_state;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *t_id;
@property (nonatomic, strong) NSString *course_counts;

@property (nonatomic, strong) NSString *course_count;
@property (nonatomic, strong) NSString *totality;
@property (nonatomic, strong) NSString *pay_status;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *spell_refund_state;

@end

NS_ASSUME_NONNULL_END

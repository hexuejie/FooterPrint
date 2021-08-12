//
//  AddOrderModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoFootModel : NSObject

@property (nonatomic, strong) NSString *vip_price_text;
@property (nonatomic, strong) NSString *vip_text;
@property (nonatomic, strong) NSString *vip_price;
@property (nonatomic, strong) NSString *is_discount_vip;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *discount_price;
@property (nonatomic, strong) NSString *expire_month;
@property (nonatomic, strong) NSString *virtual_amount;

@property (nonatomic, strong) NSString *expire_time_str;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *is_group;
@property (nonatomic, strong) NSString *footIs_group;

@property (nonatomic, strong) NSString *poster_audit;
@property (nonatomic, strong) NSString *footPoster_audit;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *footprice;

@property (nonatomic, strong) NSString *rebate_status;
@property (nonatomic, strong) NSString *studyUser;
@property (nonatomic, strong) NSString *footstudyUser;

@property (nonatomic, strong) NSString *study_count;
@property (nonatomic, strong) NSString *FootStudy_count;

@property (nonatomic, strong) NSString *title;

@end

@interface OrderIntegralFooterModel : NSObject

@property (nonatomic, strong) NSString *consume_integral;
@property (nonatomic, strong) NSString *deducted_integral;
@property (nonatomic, strong) NSString *footorder_price;

@property (nonatomic, strong) NSString *deducted_money;
@property (nonatomic, strong) NSString *order_price;
@property (nonatomic, strong) NSString *status;

@end

@interface AddOrderFooterModel : NSObject


@property (nonatomic, strong) NSString *is_bind;
@property (nonatomic, strong) OrderInfoFootModel *orderInfo;
@property (nonatomic, strong) OrderIntegralFooterModel *integral_data;

@end

NS_ASSUME_NONNULL_END

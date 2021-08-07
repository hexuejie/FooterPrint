//
//  CouponModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponFootModel : NSObject

@property (nonatomic, strong) NSString *coupon_code;
@property (nonatomic, strong) NSString *coupon_minus;
@property (nonatomic, strong) NSString *footcoupon_minus;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *minus;
@property (nonatomic, strong) NSString *minus_name;

@property (nonatomic, strong) NSString *order_price;
@property (nonatomic, strong) NSString *footorder_price;




@property (nonatomic, strong) NSString *order_price2;
@property (nonatomic, strong) NSString *tip;

@end

NS_ASSUME_NONNULL_END

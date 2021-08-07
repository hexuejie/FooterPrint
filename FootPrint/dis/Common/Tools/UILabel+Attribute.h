//
//  UILabel+Attribute.h
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/29.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Attribute)
- (void)addAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont withAttrColor:(UIColor *)attrTextColor;
- (void)addAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont;
- (void)fontwithFontSize:(CGFloat )fontSize withPingFang:(NSString *)PingFangSC  WithHexString:(NSString *)colorStr;
- (void)dealPriceWithPriceStr:(NSString *)priceStr;
- (void)addBodyAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont withAttrColor:(UIColor *)attrTextColor;
- (void)addAttrbuteColorWithAttributeText:(NSArray<NSString *> *)arr  withAttrArrayColor:(NSArray<UIColor *> *)colorArr;

- (void)addAttrbuteWithLineSpace:(CGFloat)lineSpece;

@end

NS_ASSUME_NONNULL_END

//
//  UILabel+Attribute.m
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/29.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)
- (void)addAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont withAttrColor:(UIColor *)attrTextColor{
    NSString *text = self.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    [attr addAttribute:NSFontAttributeName value:self.font range:[text rangeOfString:text]];
    for (NSString *attrText in arr) {
        [attr addAttribute:NSForegroundColorAttributeName value:attrTextColor range:[text rangeOfString:attrText]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attrFont] range:[text rangeOfString:attrText]];
    }
    
    self.attributedText = attr;

}
- (void)addAttrbuteColorWithAttributeText:(NSArray<NSString *> *)arr  withAttrArrayColor:(NSArray<UIColor *> *)colorArr{
    NSString *text = self.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    [attr addAttribute:NSFontAttributeName value:self.font range:[text rangeOfString:text]];
    for (int i = 0; i < arr.count; i ++) {
        [attr addAttribute:NSForegroundColorAttributeName value:colorArr[i] range:[text rangeOfString:arr[i]]];
    }
    
    
    self.attributedText = attr;

}

- (void)addBodyAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont withAttrColor:(UIColor *)attrTextColor{
    NSString *text = self.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    [attr addAttribute:NSFontAttributeName value:self.font range:[text rangeOfString:text]];
    for (NSString *attrText in arr) {
        [attr addAttribute:NSForegroundColorAttributeName value:attrTextColor range:[text rangeOfString:attrText]];
        [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:attrFont] range:[text rangeOfString:attrText]];
    }
    
    self.attributedText = attr;

}
- (void)addAttrbuteWithAttributeText:(NSArray *)arr  withAttributeFont:(NSInteger)attrFont{
    NSString *text = self.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    [attr addAttribute:NSFontAttributeName value:self.font range:[text rangeOfString:text]];
    for (NSString *attrText in arr) {
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attrFont] range:[text rangeOfString:attrText]];
    }
    
    self.attributedText = attr;

}

- (void)fontwithFontSize:(CGFloat )fontSize withPingFang:(NSString *)PingFangSC  WithHexString:(NSString *)colorStr {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.text attributes: @{NSFontAttributeName: [UIFont fontWithName:PingFangSC size:fontSize ],NSForegroundColorAttributeName: [UIColor colorWithHexString:colorStr]}];
                self.attributedText = string;
    
}

- (void)addAttrbuteWithLineSpace:(CGFloat)lineSpece {
    NSString *text = self.text;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpece];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    self.attributedText = attr;
}
@end

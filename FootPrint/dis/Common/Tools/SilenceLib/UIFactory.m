//
//  UIFactory.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory


/**
 单例模式实例化自身
 
 @return 返回自身实例化对象
 */
+(UIFactory *)sharedSelf{
    static dispatch_once_t predicate;
    static UIFactory * ins;
    dispatch_once(&predicate, ^{
        ins=[[UIFactory alloc] init];
    });
    return ins;
}


#pragma mark - UIFont
+(UIFont *)fontMakeWithSize: (CGFloat)fontSize{
    return FONT_Fit(fontSize);
}

+(UIFont *)fontBoldMakeWithSize: (CGFloat)fontSize{

    return FONT_Bold_Fit(fontSize);
}



#pragma mark - UIButton
+(UIButton *)btnMakeWithFrame: (CGRect)frame
                        title: (NSString *)title
                   titleColor: (UIColor *)titleColor
                 cornerRadius: (CGFloat)radius
                   strokeSize: (CGFloat)strokeSize
                  strokeColor: (UIColor *)strokeColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block
{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn cornerRadius:radius strokeSize:strokeSize color:strokeColor];
    if (isBold) {
        btn.titleLabel.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        btn.titleLabel.font = [self fontMakeWithSize:fontSize];
    }
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    return btn;
    
}

+(UIButton *)btnMakeWithFrame: (CGRect)frame
                        title: (NSString *)title
                   titleColor: (UIColor *)titleColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block
{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (isBold) {
        btn.titleLabel.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        btn.titleLabel.font = [self fontMakeWithSize:fontSize];
    }
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    return btn;
    
}

+(UIButton *)btnMakeWithTitle: (NSString *)title
                   titleColor: (UIColor *)titleColor
                 cornerRadius: (CGFloat)radius
                   strokeSize: (CGFloat)strokeSize
                  strokeColor: (UIColor *)strokeColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block
{
    
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn cornerRadius:radius strokeSize:strokeSize color:strokeColor];
    if (isBold) {
        btn.titleLabel.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        btn.titleLabel.font = [self fontMakeWithSize:fontSize];
    }
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    return btn;
    
}

+(UIButton *)btnMakeWithTitle: (NSString *)title
                   titleColor: (UIColor *)titleColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn sizeToFit];
    if (isBold) {
        btn.titleLabel.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        btn.titleLabel.font = [self fontMakeWithSize:fontSize];
    }
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    return btn;
}

+ (UIButton *)btnMakeWithTitle:(NSString *)title
                     imageName:(NSString *)image
                    titleColor:(UIColor *)titleColor
                      fontSize:(CGFloat)fontSize
                        isBold:(BOOL)isBold
                         event:(BarButtonItemClick)block
{
    
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn sizeToFit];
    if (isBold) {
        btn.titleLabel.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        btn.titleLabel.font = [self fontMakeWithSize:fontSize];
    }
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    return btn;
}

#pragma mark - UILabel

+(UILabel *)labelMakeWithFrame: (CGRect)frame
                         title: (NSString *)title
                    titleColor: (UIColor *)titleColor
                      fontSize: (CGFloat)fontSize
                        isBold: (BOOL)isBold
                         align: (NSTextAlignment)align
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    if (isBold) {
        label.font = [self fontBoldMakeWithSize:fontSize];
    }else{
        label.font = [self fontMakeWithSize:fontSize];
    }
    label.font = [self fontMakeWithSize:fontSize];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = align;
    return label;
    
}


+(UILabel *)labelMakeWithTitle: (NSString *)title
                    titleColor: (UIColor *)titleColor
                      fontSize: (CGFloat)fontSize
                        isBold: (BOOL)isBold
                         align: (NSTextAlignment)align
{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = titleColor;
    if (isBold) {
        label.font = [self fontBoldMakeWithSize:fontSize];
//        [self fontBoldMakeWithSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
//        [self fontMakeWithSize:fontSize];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = align;
    return label;
}

#pragma mark - UITextField

#pragma mark - UIView
+(UIView *)splitLineMake{
    UIView *v = [UIView new];
    v.backgroundColor = kColor_Split;
    return v;
}


#pragma mark - UIBarButtonItem
+(UIBarButtonItem *)barBtnMakeWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor
                               fontSize:(CGFloat)fontSize
                                 isBold:(BOOL)isBold
                                  event:(BarButtonItemClick)block
{
    UIButton *btn = [UIFactory btnMakeWithTitle:title titleColor:titleColor fontSize:fontSize isBold:isBold event:block];
    [btn sizeToFit];
//    [btn addActionHandler:^(NSInteger tag) {
//        block();
//    }];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

+(UIBarButtonItem *)barBtnMakeWithTitle: (NSString *)title
                             titleColor: (UIColor *)titleColor
                               fontSize: (CGFloat)fontSize
                                 isBold: (BOOL)isBold
                                 btnImg: (UIImage *)btnImg
                                  event:(BarButtonItemClick)block
{
    UIButton *btn = [UIFactory btnMakeWithTitle:title titleColor:titleColor fontSize:fontSize isBold:isBold event:block];
    [btn setImage:btnImg forState:UIControlStateNormal];
    [btn sizeToFit];
//    [btn addActionHandler:^(NSInteger tag) {
//        block();
//    }];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

+(UIBarButtonItem *)barBtnMakeWithImage:(UIImage *)image event:(BarButtonItemClick)block{
    UIButton *btn = [UIButton new];
    [btn setImage:image forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addActionHandler:^(NSInteger tag) {
        block();
    }];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}


#pragma mark - UIImage
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end

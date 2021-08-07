//
//  UIFactory.h
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void(^BarButtonItemClick)();
@interface UIFactory : NSObject

/**
 单例模式实例化自身
 
 @return 返回自身实例化对象
 */
+(UIFactory *)sharedSelf;

#pragma mark - UIFont

/**
 根据字体大小生成UIFont
 
 @param fontSize 字体尺寸
 @return UIFont
 */
+(UIFont *)fontMakeWithSize: (CGFloat)fontSize;

/**
 根据字体大小生成 粗体UIFont
 
 @param fontSize 字体尺寸
 @return UIFont
 */
+(UIFont *)fontBoldMakeWithSize: (CGFloat)fontSize;


#pragma mark - UIButton


/**
 生成UIButton
 
 @param frame frame
 @param title 标题
 @param titleColor 文本颜色
 @param radius 圆角大小
 @param strokeSize 边框尺寸
 @param strokeColor 边框颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIButton *)btnMakeWithFrame: (CGRect)frame
                        title: (NSString *)title
                   titleColor: (UIColor *)titleColor
                 cornerRadius: (CGFloat)radius
                   strokeSize: (CGFloat)strokeSize
                  strokeColor: (UIColor *)strokeColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block;

/**
 生成UIButton
 
 @param frame frame
 @param title 标题
 @param titleColor 文本颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIButton *)btnMakeWithFrame: (CGRect)frame
                        title: (NSString *)title
                   titleColor: (UIColor *)titleColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block;

/**
 生成UIButton
 
 @param title 标题
 @param titleColor 文本颜色
 @param radius 圆角大小
 @param strokeSize 边框尺寸
 @param strokeColor 边框颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIButton *)btnMakeWithTitle: (NSString *)title
                   titleColor: (UIColor *)titleColor
                 cornerRadius: (CGFloat)radius
                   strokeSize: (CGFloat)strokeSize
                  strokeColor: (UIColor *)strokeColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block;

/**
 生成UIButton
 
 @param title 标题
 @param titleColor 文本颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIButton *)btnMakeWithTitle: (NSString *)title
                   titleColor: (UIColor *)titleColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block;


/**
 生成UIButton
 
 @param title 标题
 @param titleColor 文本颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIButton *)btnMakeWithTitle: (NSString *)title
                    imageName: (NSString *)image
                   titleColor: (UIColor *)titleColor
                     fontSize: (CGFloat)fontSize
                       isBold: (BOOL)isBold
                        event:(BarButtonItemClick)block;

#pragma mark - UILabel

+(UILabel *)labelMakeWithFrame: (CGRect)frame
                         title: (NSString *)title
                    titleColor: (UIColor *)titleColor
                      fontSize: (CGFloat)fontSize
                        isBold: (BOOL)isBold
                         align: (NSTextAlignment)align;


+(UILabel *)labelMakeWithTitle: (NSString *)title
                    titleColor: (UIColor *)titleColor
                      fontSize: (CGFloat)fontSize
                        isBold: (BOOL)isBold
                         align: (NSTextAlignment)align;


#pragma mark - UITextField

#pragma mark - UIView

/**
 生成一条分割线
 
 @return 生成一条分割线
 */
+(UIView *)splitLineMake;

#pragma mark - UIBarButtonItem
/**
 生成UIBarButtonItem
 
 @param title 标题
 @param titleColor 文本颜色
 @param fontSize 字体大小
 @return 返回生成的按钮
 */
+(UIBarButtonItem *)barBtnMakeWithTitle: (NSString *)title
                             titleColor: (UIColor *)titleColor
                               fontSize: (CGFloat)fontSize
                                 isBold: (BOOL)isBold
                                  event:(BarButtonItemClick)block;

+(UIBarButtonItem *)barBtnMakeWithTitle: (NSString *)title
                             titleColor: (UIColor *)titleColor
                               fontSize: (CGFloat)fontSize
                                 isBold: (BOOL)isBold
                                 btnImg: (UIImage *)btnImg
                                  event:(BarButtonItemClick)block;


/**
 生成UIBarButtonItem
 
 @param image 图片
 @return 返回生成的按钮
 */
+(UIBarButtonItem *)barBtnMakeWithImage: (UIImage *)image event:(BarButtonItemClick)block;


#pragma mark - UIImage
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height;

@end

//
//  SilenceAutoHeightScrollViewModel.h
//  FzShop
//  配合 SilenceAutoHeightScrollView 使用
//  Created by Silence on 2016/11/9.
//  Copyright © 2016年 FzShop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SilenceAutoHeightScrollViewModel : NSObject


// 上下左右间距，默认为0
@property (nonatomic , assign) CGFloat top;
@property (nonatomic , assign) CGFloat left;
@property (nonatomic , assign) CGFloat bottom;
@property (nonatomic , assign) CGFloat right;

/**
 view 的类名
 */
@property (nonatomic , strong) NSString *viewClassName;


/**
 view所需要的数据 (一般用这个)
 */
@property (nonatomic , weak) id viewData;

/**
 view所需要的数据 (需要强引用的时候用这个)
 */
@property (nonatomic , strong) id strong_viewData;


-(instancetype)initWithViewClassName:(NSString *)viewClassName
                    viewData:(id)viewData
                         top:(CGFloat)top
                         left:(CGFloat)left
                         bottom:(CGFloat)bottom
                         right:(CGFloat)right;

-(instancetype)initWithViewClassName:(NSString *)viewClassName
                            strongViewData:(id)viewData
                                 top:(CGFloat)top
                                left:(CGFloat)left
                              bottom:(CGFloat)bottom
                               right:(CGFloat)right;

@end

//
//  BaseCollectionViewCell.h
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

/**
 设置数据 weak 一般情况下使用这个就够了 给子类实现
 */
@property (nonatomic , weak) id data;
//placeholder_property//
//placeholder_method_declare//
/**
 初始化UI 给子类去实现
 */
-(void)setupUI;
//placeholder_method_declare//
@end

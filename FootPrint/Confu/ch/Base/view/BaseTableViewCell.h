//
//  BaseTableViewCell.h
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/**
 设置数据 weak 一般情况下使用这个就够了 给子类实现
 */
@property (nonatomic , weak) id data;
//placeholder_property//
//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//


/**
 初始化UI 给子类去实现
 */
-(void)setupUI;



/**
 计算高度
 
 @param data 有可能要根据数据计算高度
 @return 返回高度
 */
+(CGFloat)countHeight:(id)data;


@end

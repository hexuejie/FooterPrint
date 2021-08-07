//
//  IntegralListVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseTableViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegralListVC : BaseTableViewVC

@property (nonatomic, assign) NSInteger type;
//placeholder_property//
@property (nonatomic, assign) BOOL isGold;
//placeholder_property//
//placeholder_property//
- (void)reloadData;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

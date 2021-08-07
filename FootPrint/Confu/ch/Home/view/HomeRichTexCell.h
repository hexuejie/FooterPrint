//
//  HomeRichTexCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRichTexCell : UITableViewCell
//placeholder_property//
@property (nonatomic, strong)HomelModel *model;
//placeholder_property//
@property (nonatomic, copy) void (^BlocHeightkClick)(CGFloat height);
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

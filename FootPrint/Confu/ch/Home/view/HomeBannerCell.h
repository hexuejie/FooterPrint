//
//  HomeBannerCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeBannerCell : UITableViewCell
//placeholder_property//
@property (nonatomic, strong) NSArray<HomeBannelModel *> *dataSource;
//placeholder_property//
@property (nonatomic, copy) void (^BlockBannerClick)(HomeBannelModel *model);
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

//placeholder_method_declare//
//placeholder_method_declare//

//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

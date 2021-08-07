//
//  IntegralCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralModel.h"
#import "GoldModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegralCell : UITableViewCell

@property (nonatomic, strong) IntegralModel *model;
//placeholder_property//
@property (nonatomic, strong) GoldModel *goldModel;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//


@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

//
//  HomeCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
#import "AddOrderFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) CourslModel *model;
//placeholder_property//
@property (nonatomic, strong) CourslModel *orderModel;
//placeholder_property//
@property (nonatomic, strong) OrderInfoFootModel *infoModel;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

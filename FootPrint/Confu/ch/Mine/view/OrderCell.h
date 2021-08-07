//
//  OrderCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "EnterpriseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) OrderModel *model;
//placeholder_property//
@property (nonatomic, strong) EnterpriseModel *enterModel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblOldPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//placeholder_method_declare//

//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UIImageView *imgSpell;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnLearn;

@end

NS_ASSUME_NONNULL_END

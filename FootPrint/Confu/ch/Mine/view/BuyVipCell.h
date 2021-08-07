//
//  BuyVipCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyVipModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyVipCell : UICollectionViewCell

@property (nonatomic, strong) VipModel *model;
//placeholder_property//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblName;
//placeholder_method_declare//

//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewBg;

@end

NS_ASSUME_NONNULL_END

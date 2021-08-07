//
//  OrderDetailVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : BaseVC

@property (nonatomic, strong) NSString *orderId;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblOldPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UILabel *lbl6;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lbl7;

@property (weak, nonatomic) IBOutlet UILabel *lbl8;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewDue;
@property (weak, nonatomic) IBOutlet UIImageView *arrawImgView;

@property (weak, nonatomic) IBOutlet UIView *viewSpell;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewDueHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewSpellHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgSpell;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UIView *viewHead;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPayStatus;

@property (nonatomic, assign) NSInteger goodsType;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

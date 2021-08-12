//
//  AddOrderVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddOrderVC : BaseVC

@property (nonatomic, strong) NSString *order_sn;
//placeholder_property//
@property (nonatomic, strong) NSString *goodsId;
//placeholder_property//
@property (nonatomic, strong) NSString *goodsType;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblIntegral;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblObtainInterfral;
//placeholder_property//
- (IBAction)btntypeClick:(id)sender;

- (IBAction)btnBuyClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UISwitch *btnSwitch;
//placeholder_property//
- (IBAction)btnAddCoupons:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCoupons;

@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblCouponMoney;

@property (weak, nonatomic) IBOutlet UILabel *lblIntegralMoeny;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewIntegra;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewIntegraHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewZFB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewZFBHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewWX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewWXHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewGold;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csviewGoldHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewCoupons;

@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *group_join_id;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csviewCouponsHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLblInfoHeight;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLblInterfralHeight;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;


@property (weak, nonatomic) IBOutlet UILabel *discountTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *disContentLabel;//479297  14 不是会员
@property (weak, nonatomic) IBOutlet UIView *discountBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csDiscountBgViewHeight;

@end

NS_ASSUME_NONNULL_END

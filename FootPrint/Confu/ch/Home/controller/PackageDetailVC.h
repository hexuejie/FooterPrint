//
//  PackageDetailVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/6.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PackageDetailVC : BaseVC

@property (nonatomic, strong) NSString *packId;

@property (nonatomic, strong) NSString *banner;

//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblCourseNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionViewHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//placeholder_property//
- (IBAction)btnGoHomeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBuyVip;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnBuyPack;

@property (weak, nonatomic) IBOutlet UILabel *lblIsFree;
//placeholder_property//
- (IBAction)btnBuyPackClick:(id)sender;

- (IBAction)btnBuyVipClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnBuyVipWidth;
//placeholder_property//
- (IBAction)btnShareClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@end

NS_ASSUME_NONNULL_END

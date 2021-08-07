//
//  BuyGoldVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyGoldVC : BaseVC

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionViewHeight;

- (IBAction)btnBuyGoldClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblGold;

@property (weak, nonatomic) IBOutlet UIImageView *viewHead;
//placeholder_property//

@property (weak, nonatomic) IBOutlet UILabel *lblName;
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
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

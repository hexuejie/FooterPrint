//
//  NewMineVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface NeMneVC : BaseVC

@property (weak, nonatomic) IBOutlet UIView *headBGView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csHeadBgViewHeight;
//placeholder_property//
- (IBAction)btnGoDetailClick:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView1;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionViewHeight1;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView2;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionViewHeight2;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView3;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionViewHeight3;
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

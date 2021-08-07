//
//  PictureAndTextCollectViewCell.h
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/14.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PictureAndTextCollectViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *gapView;
//placeholder_property//
@property (nonatomic,strong) HomeBannelModel *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *withConstraint;

//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@end

NS_ASSUME_NONNULL_END

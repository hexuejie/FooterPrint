//
//  PackageCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePackaglModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PackageCell : UICollectionViewCell

@property (nonatomic, strong) HomePackaglModel *model;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
//placeholder_property//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

//
//  HotCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/3/17.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImgView;

@end

NS_ASSUME_NONNULL_END

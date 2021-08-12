//
//  HomeHeadSecondCell.h
//  FootPrint
//
//  Created by 何学杰 on 2021/8/9.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeadSecondCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottom;

@end

NS_ASSUME_NONNULL_END

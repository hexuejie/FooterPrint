//
//  HomeHeadCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
#import "LiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeadCell : UICollectionViewCell
//placeholder_property//
@property (nonatomic, strong) CourslModel *courseModel;
//placeholder_property//
@property (nonatomic, strong) LiveModel *liveModel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblLiveStatus;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblLiveTime;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@end

NS_ASSUME_NONNULL_END

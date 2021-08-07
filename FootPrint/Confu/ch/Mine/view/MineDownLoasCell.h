//
//  MineDownLoadCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import "LearnRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineDownLoasCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;

@property (weak, nonatomic) IBOutlet UIView *viewProgress;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblSize;

@property (weak, nonatomic) IBOutlet UIView *viewDownProgress;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewDownProgressHeight;

@property (weak, nonatomic) IBOutlet UIView *viewHazy;
//placeholder_property//
@property (nonatomic, strong) CourseDetailModel *DownModel;

@property (nonatomic, strong) LearnRecordModel *learnModel;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewBg;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

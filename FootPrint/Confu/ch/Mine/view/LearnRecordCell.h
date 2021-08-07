//
//  LearnRecordCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnRecordModel.h"
#import "MGSwipeTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LearnRecordCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIView *progressView;
//placeholder_property//
@property (nonatomic, strong) LearnRecordModel *model;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgType;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblContent;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnSelectWidth;

@property (nonatomic, assign) BOOL isEdit;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

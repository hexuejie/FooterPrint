//
//  DownLoadCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/20.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import "MGSwipeTableCell.h"
#import "YCDownloadSession.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownLoadCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *lblNumBer;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UILabel *lblNew;

@property (weak, nonatomic) IBOutlet UILabel *lblMemory;

@property (weak, nonatomic) IBOutlet UIView *viewProgress;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewProgressWidth;

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnSelectWidth;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) YCDownloadItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblSpeed;

@end

NS_ASSUME_NONNULL_END

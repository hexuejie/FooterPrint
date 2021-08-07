//
//  SelectCacheCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/16.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import "YCDownloadItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectCacheCell : UITableViewCell

@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgDownStatus;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, strong) YCDownloadItem *item;
//placeholder_property//
- (void)setDownloadStatus:(YCDownloadStatus)status;

@end

NS_ASSUME_NONNULL_END

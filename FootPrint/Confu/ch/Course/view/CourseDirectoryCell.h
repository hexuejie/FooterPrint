//
//  CourseDirectoryCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDirectoryCell : UITableViewCell
//placeholder_property//
@property (nonatomic, assign) NSInteger goodsType;
//placeholder_property//
@property (nonatomic, strong) CoursePlayerFootModel *playerModel;

@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgMp3;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblLiveStatus;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

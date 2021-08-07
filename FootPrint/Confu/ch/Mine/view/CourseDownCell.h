//
//  CourseDownCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/17.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import "MGSwipeTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseDownCell : MGSwipeTableCell

@property (nonatomic, strong) CourseDetailModel *model;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblCount;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnSelectWidth;

@property (weak, nonatomic) IBOutlet UIImageView *imgDownStatus;
//placeholder_property//
@property (nonatomic, assign) BOOL isEdit;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

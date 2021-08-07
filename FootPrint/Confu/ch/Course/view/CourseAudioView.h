//
//  CourseAudioView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/21.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseAudioView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgBg;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblName;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIButton *btnConment;
//placeholder_property//
@property (nonatomic, strong) CourseDetailModel *model;
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

//
//  CourseFootView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import "MyButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourseFootView : UIView

- (IBAction)btnGoHomeClick:(id)sender;
//placeholder_property//
- (IBAction)btnBuyCourseClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet MyButton *btnBuyCourse;

- (IBAction)btnBuyVipClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnBuyVip;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnIsVip;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnBuyVipWidth;
//placeholder_property//
@property (nonatomic, strong) CourseDetailModel *model;

@property (nonatomic, strong) CoursePlayerFootModel *playModel;
//placeholder_property//
@property (nonatomic, copy) void (^BlockOperationClick)(NSInteger type);
//placeholder_property//
- (IBAction)btnShareClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UIView *groupBgView;
@property (weak, nonatomic) IBOutlet UIButton *aloneBtn;
@property (weak, nonatomic) IBOutlet UIButton *groupBtn;
- (IBAction)aloneAction:(UIButton *)sender;
- (IBAction)groupAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aloneBgView;
@property (weak, nonatomic) IBOutlet UIView *groupsView;





@end

NS_ASSUME_NONNULL_END

//
//  MineHeadView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineHeadView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)IntegralClick:(id)sender;
//placeholder_property//
- (IBAction)btnCompleteClick:(id)sender;
//placeholder_property//
@property (nonatomic, copy) void (^BlockOperationClick)(NSInteger type);

@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblCourseNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblIntegral;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//


//placeholder_property//
@property (nonatomic, strong) UserModel *model;
- (IBAction)clickToLoginAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imgAgent;
//placeholder_property//


@property (weak, nonatomic) IBOutlet UILabel *vipTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *vipArrowButton;

@end

NS_ASSUME_NONNULL_END

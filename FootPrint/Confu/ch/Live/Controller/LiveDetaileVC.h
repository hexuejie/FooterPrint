//
//  LiveDetaileVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveDetaileVC : BaseVC

@property (nonatomic, strong) NSString *liveId;

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *ImgHead;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblIntroduce;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTableViewHeight;

@property (weak, nonatomic) IBOutlet UIView *webBGView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csWebViewHeight;

- (IBAction)btnGoHomeClick:(id)sender;
//placeholder_property//
- (IBAction)btnSharClick:(id)sender;

- (IBAction)btnBuyCourseClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnBuyCourse;

- (IBAction)btnBuyVipClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnBuyVip;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBtnBuyVipWidth;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewTeacher;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewTeacherHeight;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

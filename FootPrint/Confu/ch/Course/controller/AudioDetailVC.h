//
//  AudioDetailVC.h
//  FootPrint
//
//  Created by 胡翔 on 2021/3/19.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "BaseVC.h"
#import "CourseDetailModel.h"
#import "BigSlider.h"
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailVC : BaseVC

@property (weak, nonatomic) IBOutlet UIButton *enterBtn;


@property (weak, nonatomic) IBOutlet UIView *bannerBgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIView *enterBgView;
- (IBAction)enterAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBannerStraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csWebHeight;
@property (nonatomic, copy) void (^BlockSwitchAdudioClick)(CoursePlayerFootModel *playerModel, NSInteger playerRow);
@property (weak, nonatomic) IBOutlet JsWKWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *webBgView;

@property (weak, nonatomic) IBOutlet UILabel *lbVideoTitle;

@property (nonatomic, assign) long is_buy;

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIView *audioBgView;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayTime;

@property (weak, nonatomic) IBOutlet UILabel *lblDuraTime;

@property (weak, nonatomic) IBOutlet BigSlider *slider;

- (void)nextPlayerModel;
- (void)lastPlayerModel;
@property (weak, nonatomic) IBOutlet UILabel *lblSpeed;

@property (weak, nonatomic) IBOutlet UIView *playBgView;

@property (nonatomic, assign) BOOL last_click_play;//
//@property (weak, nonatomic) IBOutlet BaseScrolllview *baseScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;


- (IBAction)btnNextClick:(id)sender;

- (IBAction)btnLastClick:(id)sender;

- (IBAction)btnSpeedClick:(id)sender;

@property (nonatomic, strong) CourseDetailModel *model;

@property (nonatomic, assign) NSInteger playerRow;

@end

NS_ASSUME_NONNULL_END

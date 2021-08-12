//
//  CourseHeadView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CourseHeadView;
@protocol CourseHeadViewCellDelegate <NSObject>

- (void)tableViewWillPlay:(CourseHeadView *)view;

- (void)tableViewCellEnterFullScreen:(CourseHeadView *)view;

- (void)tableViewCellExitFullScreen:(CourseHeadView *)view;

@end

@interface CourseHeadView : UIView

@property (nonatomic, copy) void (^BlokGroupDetailClick)();



@property (nonatomic, weak) id<CourseHeadViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (weak, nonatomic) IBOutlet UIView *headTopBgView;

@property (weak, nonatomic) IBOutlet UIButton *btnConment;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnDownLoad;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewAudio;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblAudioTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblPlayTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblDuraTime;

@property (weak, nonatomic) IBOutlet UISlider *slider;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgMp3;

@property (weak, nonatomic) IBOutlet UILabel *lblSpeed;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csAudioViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *playBgView;

@property (weak, nonatomic) IBOutlet UIImageView *playBtn;

- (IBAction)btnNextClick:(id)sender;
//placeholder_property//
- (IBAction)btnLastClick:(id)sender;

- (IBAction)btnSpeedClick:(id)sender;

@property (nonatomic, copy) void (^BlockSwitchAdudioClick)(CoursePlayerFootModel *playerModel, NSInteger playerRow);
// BlockJoinClick
@property (nonatomic, copy) void (^BlockJoinClick)(GroupingModel *model);

@property (nonatomic, copy) void (^BlockSwitchVideoClick)(CoursePlayerFootModel *playerModel, NSInteger playerSection ,NSInteger playerRow);
//placeholder_property//
@property (nonatomic, strong) CourseDetailModel *model;
@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
@property (nonatomic, assign) NSInteger PlayerType;
//placeholder_property//
- (void)setPlayerSection:(NSInteger)section PlayerRow:(NSInteger)row;
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
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

- (void)setPlayModel:(CoursePlayerFootModel *)playerModel isPlay:(BOOL)play;
@property (weak, nonatomic) IBOutlet UIView *gainBgView;
@property (weak, nonatomic) IBOutlet UILabel *precetageLabel;

- (void)addPlayerView;

- (void)beginPlayVideo;

@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *separLine;
@property (weak, nonatomic) IBOutlet UIView *peopleBgView;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *purchaseShowBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLastTimeBgView;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csPurchaseShowBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csInviteBtn;
- (IBAction)inviteAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csPeopleBgView;
@property (weak, nonatomic) IBOutlet UIView *incomeShowView;
@property (weak, nonatomic) IBOutlet UILabel *currentPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPeopleLabel;
@property (weak, nonatomic) IBOutlet UIView *joinListBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csJoinListBgView;
@property (weak, nonatomic) IBOutlet UITableView *joinTableView;

- (IBAction)goingToDetail:(UIButton *)sender;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipBgWifht;
@property (weak, nonatomic) IBOutlet UIView *vipBgview;
@property (weak, nonatomic) IBOutlet UILabel *vipTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;//6   60
@property (weak, nonatomic) IBOutlet UIButton *cardButton;


@end

NS_ASSUME_NONNULL_END

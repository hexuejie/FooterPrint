//
//  PLPlayerView.h
//  NiuPlayer
//
//  Created by hxiongan on 2018/3/7.
//  Copyright © 2018年 hxiongan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailModel.h"
#import <PLPlayerKit/PLPlayerKit.h>

@class PLPlayerView;
@class PlayerVideoView;
@class PlayerAudioView;
@protocol PLPlayerViewDelegate <NSObject>

- (void)playerViewEnterFullScreen:(PLPlayerView *)playerView;

- (void)playerViewExitFullScreen:(PLPlayerView *)playerView;

- (void)playerViewWillPlay:(PLPlayerView *)playerView;

@end

@interface PLPlayerView : UIView

@property (nonatomic, weak) id<PLPlayerViewDelegate> delegate;
@property (nonatomic ,strong) PlayerAudioView *audioView;

@property (nonatomic ,strong) PlayerVideoView *videoView;

@property (nonatomic, strong) PLPlayer *player;
@property (nonatomic, strong) CourseDetailModel *model;
@property (nonatomic) BOOL isWindowsView;  //是否存在于windowsView上
@property (nonatomic) BOOL dragEnable;  //是否可拖动

@property (nonatomic, strong) CoursePlayerFootModel *playerModel;

@property (nonatomic, assign) NSInteger playerRow;

@property (nonatomic, assign) BOOL isPlayUrlNil; //播放器url是否为空

@property (nonatomic, assign) int currentIsFullScreen; // 0,竖屏 1，左，2右
@property (nonatomic, assign) NSInteger timelong; // record actual playtime

@property (nonatomic, assign) NSInteger PlaylongTime; //播放时长

@property (nonatomic, assign) NSInteger PlayerType; //播放类型 1：视频 2：音频
//播放状态改变
@property (nonatomic, copy) void (^BlockViewPlayerStatus)(PLPlayerStatus status);

@property (nonatomic, copy) void (^BlockAdudioVCPlayerStatus)(PLPlayerStatus status);

@property (nonatomic, copy) void (^BlockVideoVCPlayerStatus)(PLPlayerStatus status);
//@property (nonatomic, copy) void (^BlockAudeoVCPlayRow)(NSInteger playRow);


@property (nonatomic, strong) NSString *defaultImg;  //默认图
@property (nonatomic, strong) UIImageView *thumbImageView;
- (void)transformWithOrientation:(UIDeviceOrientation)or;

- (void)play;

- (void)stop;

- (void)pause;

- (void)resume;

- (void)configureVideo:(BOOL)enableRender;

- (void)showPlayerInView:(UIView *)view;

- (void)studyUpdate:(BOOL)clear;

- (void)hideControlView;

@property (nonatomic, copy) void (^BlockCloseClick)(void);

@property (nonatomic, copy) void (^BlockTimerClick)(NSString *time,CGFloat progress);

@end


typedef enum : NSUInteger {
    PLPlayerRatioDefault,
    PLPlayerRatioFullScreen,
    PLPlayerRatio16x9,
    PLPlayerRatio4x3,
} PLPlayerRatio;


@class PLControlView;
@protocol PLControlViewDelegate <NSObject>

- (void)controlViewClose:(PLControlView *)controlView;

- (void)controlView:(PLControlView *)controlView speedChange:(CGFloat)speed;

- (void)controlView:(PLControlView *)controlView ratioChange:(PLPlayerRatio)ratio;

- (void)controlView:(PLControlView *)controlView backgroundPlayChange:(BOOL)isBackgroundPlay;

- (void)controlViewMirror:(PLControlView *)controlView;

- (void)controlViewRotate:(PLControlView *)controlView;

- (BOOL)controlViewCache:(PLControlView *)controlView;

@end

@interface PLControlView : UIView

@property (nonatomic, weak) id<PLControlViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISegmentedControl *speedControl;
@property (nonatomic, strong) UISegmentedControl *ratioControl;
@property (nonatomic, strong) UILabel *speedValueLabel;
@property (nonatomic, strong) UILabel *speedTitleLabel;

@property (nonatomic, strong) UIButton *playBackgroundButton;
@property (nonatomic, strong) UIButton *mirrorButton;
@property (nonatomic, strong) UIButton *rotateButton;
@property (nonatomic, strong) UIButton *cacheButton;

- (void)resetStatus;
#import "CBAutoScrollLabel.h"
//音频小窗口视图
@interface PlayerAudioView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *runImgView;

@property (nonatomic, strong) UIButton *btnPlay;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic,strong)NSData *imgData;

@property (nonatomic, strong) CBAutoScrollLabel *autoScrollLabel;
@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
@property (nonatomic, strong) CourseDetailModel *model;
@property (nonatomic, assign) NSInteger playerRow;

@property (nonatomic, assign) NSInteger PlayerType; //播放类型 1：视频 2：音频

@end

//视频小窗口视图
@interface PlayerVideoView : UIView

@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic) BOOL dragEnable;  //是否可拖动

@property (nonatomic) CGFloat edgeMargin;  //距离边缘的空白间隔
@property (nonatomic) CGPoint beginPoint;

@end



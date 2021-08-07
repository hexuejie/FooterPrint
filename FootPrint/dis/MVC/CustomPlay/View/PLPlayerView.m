//
//  PLPlayerView.m
//  NiuPlayer
//
//  Created by hxiongan on 2018/3/7.
//  Copyright © 2018年 hxiongan. All rights reserved.
//

#import "PLPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Alert.h"
#import "UIButton+Animate.h"
#import "PlayerFootModel.h"
#import "ImportHeader.h"
#import "YCDownloadManager.h"
#import "CoreStatus.h"
#import "UIAlertController+Blocks.h"
#import "WDAudioMuteSwitchManager.h"
#import "MySlider.h"
#import "UIImageView+GIF.h"
#import "ImportHeader.h"
@class PLControlView;

@interface PLPlayerView ()
<
PLPlayerDelegate,
PLControlViewDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *exitfullScreenButton;

@property (nonatomic, strong) UIView *bottomBarView;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) UIButton *retreatPlayImgView;
@property (nonatomic, strong) UIButton *advancePlayBtn;

@property (nonatomic, strong) UILabel *playTimeLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *multiLabel;

@property (nonatomic, strong) UIProgressView *bufferingView;
@property (nonatomic, strong) UIButton *enterFullScreenButton;

// 在bottomBarView上面的播放暂停按钮，全屏的时候，显示
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIView *TrafficHazyView;
@property (nonatomic, strong) UILabel *lblPrompt;
@property (nonatomic, strong) UIButton *btnContinue;


@property (nonatomic, assign) UIDeviceOrientation deviceOrientation;

@property (nonatomic, strong) PLPlayerOption *playerOption;
@property (nonatomic, assign) BOOL isNeedSetupPlayer;

@property (nonatomic, strong) NSTimer *playTimer;

// 在屏幕中间的播放和暂停按钮，全屏的时候，隐藏
@property (nonatomic, strong) UIButton *centerPlayButton;
@property (nonatomic, strong) UIButton *centerPauseButton;

@property (nonatomic, strong) UIButton *snapshotButton;

@property (nonatomic, assign) NSInteger speedIdx;
@property (nonatomic, strong) NSArray *speedAry;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) PLControlView *controlView;

// 很多时候调用stop之后，播放器可能还会返回请他状态，导致逻辑混乱，记录一下，只要调用了播放器的 stop 方法，就将 isStop 置为 YES 做标记
@property (nonatomic, assign) BOOL isStop;

// 当底部的 bottomBarView 因隐藏的时候，提供两个 progrssview 在最底部，随时能看到播放进度和缓冲进度
@property (nonatomic, strong) UIProgressView *bottomPlayProgreeeView;
@property (nonatomic, strong) UIProgressView *bottomBufferingProgressView;

// 适配iPhone X
@property (nonatomic, assign) CGFloat edgeSpace;
@property (nonatomic, strong) UIView *shadowView;

//视频当前播放时长
@property (nonatomic, assign) NSInteger currentTime;

@property (nonatomic, assign) BOOL isRequest;
@property (nonatomic, strong) NSString *playerUrl;

@property (nonatomic, assign) BOOL videoBein;

@end

@implementation PLPlayerView

-(void)dealloc {
    [self unsetupPlayer];
}
- (void)judgeSilence {
    
//    [[WDAudioMuteSwitchManager sharedInstance] getAudioMuteSwitch:^(BOOL ismute) {
//        NSLog(@"getAudioMuteSwitch--%d",ismute?1:0);
//        if (ismute) {
//            [KeyWindow showTip:@"请关闭静音开关，不然会没声音哦！"];
//        }
//    }];
}

- (void)playUrl{
    // 判断音量
    [self judgeSilence];
    if (self.playerModel) {
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:self.playerModel.cid forKey:@"course_id"];
        [param setObject:self.playerModel.id forKey:@"type_id"];
        [param setObject:self.PlayerType == 1?@"video":@"audio" forKey:@"type"];
        
        if ([self.playerUrl containsString:@"http"]) { //播放线上地址
            
            // if user slide the slider ,it seems that user want to start with the slider value.
//            self.currentTime = CMTimeGetSeconds(self.player.currentTime);
          
            WS(weakself)
            [APPRequest POST:@"/timesWatched" parameters:param finished:^(AjaxResult *result) {
                
                if (result.code == AjaxResultStateSuccess) {
                    
                    NSInteger lastTime = [result.data[@"last_time"] integerValue];
                    long dur = 0;
                    if (weakself.PlayerType == 1) {
                        dur = weakself.playerModel.second;
                    } else {
                        dur = weakself.playerModel.duration;

                    }
                    if (lastTime + 10.0 >= dur) {
                        [weakself.player preStartPosTime:CMTimeMake(0 * 1000, 1000)];

//                        [KeyWindow showTip:@"已跳转到上次观看的时间"];
                        
                    }else {
                        if (lastTime > 0) {
                            [KeyWindow showTip:@"已载入上次播放进度"];

                        }

                        [weakself.player preStartPosTime:CMTimeMake(lastTime * 1000, 1000)];

                    }
                    
                    
                    weakself.isStop = NO;
                    
                    [weakself.delegate playerViewWillPlay:self];
                    [weakself addFullStreenNotify];
                    [weakself addTimer];
                    [weakself resetButton:YES];
                    
                    if (!(PLPlayerStatusReady == self.player.status ||
                          PLPlayerStatusOpen == self.player.status ||
                          PLPlayerStatusCaching == self.player.status ||
                          PLPlayerStatusPlaying == self.player.status ||
                          PLPlayerStatusPreparing == self.player.status)
                        ) {
                        NSDate *date = [NSDate date];
                        [weakself.player play];
                        
                        if (weakself.PlayerType == 2) {
                            [weakself setPlayingInfo];
                        }
                        
                        NSLog(@"play 耗时： %f s",[[NSDate date] timeIntervalSinceDate:date]);
                    }
                }
            }];
        }else{ //
            
            self.isStop = NO;
            
            [self.delegate playerViewWillPlay:self];
            [self addFullStreenNotify];
            [self addTimer];
            [self resetButton:YES];
            
            if (!(PLPlayerStatusReady == self.player.status ||
                  PLPlayerStatusOpen == self.player.status ||
                  PLPlayerStatusCaching == self.player.status ||
                  PLPlayerStatusPlaying == self.player.status ||
                  PLPlayerStatusPreparing == self.player.status)
                ) {
                NSDate *date = [NSDate date];
                [self.player play];
                NSLog(@"play 耗时： %f s",[[NSDate date] timeIntervalSinceDate:date]);
            }
        }
    }
}


- (void)configureVideo:(BOOL)enableRender {
    self.player.enableRender = enableRender;
    
    // 避免在未更新画面渲染的情况下，动态翻转移动画布 2020-02-13 hera
    if (!enableRender) {
        [self removeFullStreenNotify];
    } else{
        [self addFullStreenNotify];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.timelong = 0;
        self.backgroundColor = [UIColor blackColor];
       self.edgeSpace = [[UIApplication sharedApplication] statusBarFrame].size.height - 10;
//        if (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 375, 812))) {
//            // iPhone X
//            self.edgeSpace = ;
//        } else {
//            self.edgeSpace = 5;
//        }
        
        [self initTopBar];
        [self initBottomBar];
        [self initOtherUI];
        [self doStableConstraint];
        
        self.bottomBarView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.2];
        self.topBarView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.2];
        
        self.deviceOrientation = UIDeviceOrientationUnknown;
        [self transformWithOrientation:UIDeviceOrientationPortrait];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:self.tapGesture];
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        self.panGesture.delegate = self;

    }
    return self;
}

- (void)setModel:(CourseDetailModel *)model{
    
    _model = model;
}

- (void)setPlayerType:(NSInteger)PlayerType{
    
    
    _PlayerType = PlayerType;

    if (PlayerType == 1) { //视频

        [self addGestureRecognizer:self.tapGesture];
        if (self.player.status != PLPlayerStatusPlaying) {
            
            self.shadowView.hidden = NO;
            [self addSubview:self.shadowView];
        }
        [self addSubview:self.centerPauseButton];
        [self addSubview:self.centerPlayButton];
        [self doStableConstraint];
//        [self.audioView removeFromSuperview];

    }else{ //音频
        
        [self.centerPlayButton removeFromSuperview];
        [self.centerPauseButton removeFromSuperview];
        [self removeGestureRecognizer:self.tapGesture];
        [self hideBar];
        [self hideBottomProgressView];
        [self.shadowView removeFromSuperview];
    }
}

- (void)setPlayerModel:(CoursePlayerFootModel *)playerModel {
    
    [self hideTrafficView];
    
    if (self.player.status != PLPlayerStatusPlaying || ![playerModel.cid isEqualToString:self.playerModel.cid] || ![playerModel.id isEqualToString:self.playerModel.id]) { //不在播放中 或者 要播放的课程id 和之前播放的课程id不一样
        
        if (self.playerModel) {
            
            if (self.PlaylongTime > 0 && self.timelong > 0) {
               
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setObject:self.playerModel.cid forKey:@"course_id"];
                
                [param setObject:[NSString stringWithFormat:@"%ld",self.PlaylongTime] forKey:@"study_time"]; //视频播放时长
                [param setObject:[NSString stringWithFormat:@"%.f",self.timelong ] forKey:@"long_time"];
                if (self.PlayerType == 1) { //视频
                    
                    [param setObject:self.playerModel.id forKey:@"vid"];
                    [param setObject:@"video" forKey:@"type"];
                }else { //音频
                    
                    [param setObject:self.playerModel.id forKey:@"aid"];
                    [param setObject:@"audio" forKey:@"type"];
                }
                NSLog(@"记录一下");
                self.timelong = 0;
                [APPRequest POST:@"/updateCourseRecord" parameters:param finished:^(AjaxResult *result) {

                    if (result.code == AjaxResultStateSuccess) {

                    }
                }];
            }
        }
        
        _playerModel = playerModel;
        
        self.isNeedSetupPlayer = YES; //初始化
//        [self setupPlayer];
        
    }
    
    
//    if (self.PlayerType == 1) {
//        [self.player setBackgroundPlayEnable:NO];
//    } else {
//        [self.player setBackgroundPlayEnable:YES];
//
//    }
    
    _playerModel = playerModel;
    
    self.titleLabel.text = playerModel.title;
}

- (void)setDefaultImg:(NSString *)defaultImg{
    
    _defaultImg = defaultImg;
    
    [self.thumbImageView sd_setImageWithURL:APP_IMG(defaultImg) placeholderImage:[UIImage imageNamed:@"mydefault"]];
}

- (void)showPlayerInView:(UIView *)view{
    
    self.hidden = NO;
    self.dragEnable = NO;
    self.isWindowsView = NO;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*14/25);
//    [self.audioView removeFromSuperview];
    [self.videoView removeFromSuperview];
    
    WS(weakself);
    if (view == KeyWindow) {
        
        self.isWindowsView = YES;
        
        if (self.PlayerType == 1) { //视频
        
            self.dragEnable = YES;
            CGFloat width = SCREEN_WIDTH*0.6;
            
            self.videoView = [[PlayerVideoView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width-20, SCREEN_HEIGHT-300, width+20, width*14/24)];
            self.videoView.dragEnable = YES;
            [self.videoView.btnClose addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                if (!Ktoken) {
                    [weakself gotoLogin];
                    return;
                }
                
                if (weakself.BlockCloseClick) {
                    weakself.BlockCloseClick();
                }
            }];
            [self removeFromSuperview];
            [self.videoView insertSubview:self belowSubview:self.videoView.btnClose];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.leading.mas_equalTo(0);
                            make.trailing.mas_equalTo(-12);
                            make.top.mas_equalTo(12);
                            make.height.mas_equalTo(self.videoView.height);
            }];
//            self.frame = CGRectMake(0, 12, self.videoView.width-12, self.videoView.height);
         
            
            [view addSubview:self.videoView];
        }else{ //音频
            self.audioView = [[PlayerAudioView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-139.5, SCREEN_HEIGHT-106.5 - KSafeAreaHeight -KStatusHight, 184, 67)];
          
            self.audioView.PlayerType = self.PlayerType;
            self.audioView.playerModel = self.playerModel;
            [self.audioView.imgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
            [self.audioView.btnClose addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
               if (!Ktoken) {
                   [weakself gotoLogin];
                                  return;
                              }
                [weakself.player stop];
                if (weakself.BlockCloseClick) {
                    weakself.BlockCloseClick();
                }
            }];
            if (self.player.status == PLPlayerStatusPlaying) {
                
                self.audioView.btnPlay.selected = YES;
            }else{
                
                self.audioView.btnPlay.selected = NO;
            }
            [self.audioView.btnPlay addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
               if (!Ktoken) {
                   [weakself gotoLogin];
                                  return;
                              }
                if (weakself.player.status == PLPlayerStatusPlaying) { //正在播放
                    
                    weakself.audioView.btnPlay.selected = NO;
                    [weakself pause];
                }else if (weakself.player.status == PLPlayerStatusPaused){
                    
                    weakself.audioView.btnPlay.selected = YES;
                    [weakself resume];
                }else{
                    
                    weakself.audioView.btnPlay.selected = NO;
                    [weakself play];
                }
            }];
            [view addSubview:self.audioView];
        }
    }else{
        [view addSubview:self];

        if ([view isKindOfClass:[CourseHeadView class]]) {
            CourseHeadView *headV = (CourseHeadView *)view;
            [headV.headTopBgView  insertSubview:self belowSubview:headV.topImgView];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.leading.trailing.mas_equalTo(headV.headTopBgView);
            }];
        }
        
    }
}
- (void)hideTrafficView{
    
    self.TrafficHazyView.hidden = YES;
    self.lblPrompt.hidden = YES;
    self.btnContinue.hidden = YES;
    
    self.shadowView.hidden = NO;
    self.centerPlayButton.hidden = NO;
//    self.centerPauseButton.hidden = NO;
    
    [self addGestureRecognizer:self.tapGesture];
}
- (void)gotoLogin {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取当前导航控制器
    UITabBarController  *tableBar = (UITabBarController *)app.window.rootViewController;
    UINavigationController *currentNav = tableBar.selectedViewController;
    BaseVC *bs = (BaseVC *)currentNav.visibleViewController;
    [bs loginAction];
    
}



- (BOOL)isFullScreen {
    return UIDeviceOrientationPortrait != self.deviceOrientation;
}

- (void)initTopBar {
    self.topBarView = [[UIView alloc] init];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.exitfullScreenButton = [[UIButton alloc] init];
    [self.exitfullScreenButton setImage:[UIImage imageNamed:@"pllayer_back"] forState:(UIControlStateNormal)];
    [self.exitfullScreenButton addTarget:self action:@selector(clickExitFullScreenButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.moreButton = [[UIButton alloc] init];
    self.moreButton.hidden = YES;
    [self.moreButton setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
    [self.moreButton addTarget:self action:@selector(clickMoreButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.topBarView addSubview:self.titleLabel];
    [self.topBarView addSubview:self.exitfullScreenButton];
    [self.topBarView addSubview:self.moreButton];
    
    [self addSubview:self.topBarView];
}

- (void)initBottomBar {
    
    self.bottomBarView = [[UIView alloc] init];
    
    self.playTimeLabel = [[UILabel alloc] init];
    self.playTimeLabel.font = [UIFont systemFontOfSize:12];
    if (@available(iOS 9, *)) {
        self.playTimeLabel.font= [UIFont monospacedDigitSystemFontOfSize:12 weight:(UIFontWeightRegular)];
    }
    self.playTimeLabel.textColor = [UIColor whiteColor];
    self.playTimeLabel.text = @"0:00:00";
    [self.playTimeLabel sizeToFit];
    
    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.font = [UIFont systemFontOfSize:12];
    if (@available(iOS 9.0, *)) {
        self.durationLabel.font= [UIFont monospacedDigitSystemFontOfSize:12 weight:(UIFontWeightRegular)];
    }
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.text = @"0:00:00";
    [self.durationLabel sizeToFit];
    
    self.multiLabel = [[UILabel alloc] init];
    self.multiLabel.font = [UIFont systemFontOfSize:12];
    if (@available(iOS 9.0, *)) {
        self.multiLabel.font= [UIFont monospacedDigitSystemFontOfSize:12 weight:(UIFontWeightRegular)];
    }
    self.multiLabel.textColor = [UIColor whiteColor];
    self.multiLabel.text = @"X1.00";
    self.multiLabel.userInteractionEnabled = YES;
    WS(weakself)
    [self.multiLabel addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.player.status == PLPlayerStatusPlaying) {
               //placeholder_method_call//

               weakself.speedIdx ++;
               if (weakself.speedIdx >= self.speedAry.count) {
                   
                   weakself.speedIdx = 0;
               }
            
               [weakself.player setPlaySpeed:[weakself.speedAry[weakself.speedIdx] floatValue]];
            
            weakself.multiLabel.text = [NSString stringWithFormat:@"X%.2f",[weakself.speedAry[weakself.speedIdx] doubleValue]];
           }
        
        
        }];
    [self.multiLabel sizeToFit];
    self.retreatPlayImgView = [[UIButton alloc] init];
    [self.retreatPlayImgView setImage:[UIImage imageNamed:@"course_retreat"] forState:UIControlStateNormal];
    self.retreatPlayImgView.userInteractionEnabled = YES;
    [self.retreatPlayImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       Float64 f =  CMTimeGetSeconds(weakself.player.currentTime);
        if (f <= 15.0) {
            [weakself.player seekTo:CMTimeMake(0, 1000)];
        } else {
            [weakself.player seekTo:CMTimeMake((f - 15.0) * 1000.0, 1000)];

        }
        }];
    self.advancePlayBtn = [[UIButton alloc] init];
//    self.advancePlayBtn.image = [UIImage imageNamed:@"course_advance"];
    [self.advancePlayBtn setImage:[UIImage imageNamed:@"course_advance"] forState:UIControlStateNormal];
    self.advancePlayBtn.userInteractionEnabled = YES;
    [self.advancePlayBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        Float64 totalTime = CMTimeGetSeconds(weakself.player.totalDuration);
        
       Float64 f =  CMTimeGetSeconds(weakself.player.currentTime);
        if (f + 15.0 >= totalTime) {
            [weakself.player seekTo:CMTimeMake((totalTime) * 1000.0, 1000)];
           
        } else {
            [weakself.player seekTo:CMTimeMake((f + 15.0) * 1000.0, 1000)];

        }
        }];
    self.slider = [[MySlider alloc] init];
    self.slider.continuous = NO;
    [self.slider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:(UIControlStateNormal)];
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    self.slider.minimumTrackTintColor = [UIColor colorWithRed:.2 green:.2 blue:.8 alpha:1];
    [self.slider addTarget:self action:@selector(sliderValueChange) forControlEvents:(UIControlEventValueChanged)];
    
    self.bufferingView = [[UIProgressView alloc] init];
    self.bufferingView.progressTintColor = [UIColor colorWithWhite:1 alpha:1];
    self.bufferingView.trackTintColor = [UIColor colorWithWhite:1 alpha:.33];
    
    self.enterFullScreenButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.enterFullScreenButton setTintColor:[UIColor whiteColor]];
    [self.enterFullScreenButton setImage:[UIImage imageNamed:@"full-screen"] forState:(UIControlStateNormal)];
    [self.enterFullScreenButton addTarget:self action:@selector(clickEnterFullScreenButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.playButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.playButton setTintColor:[UIColor whiteColor]];
    [self.playButton setImage:[UIImage imageNamed:@"playe"] forState:(UIControlStateNormal)];
    [self.playButton addTarget:self action:@selector(clickPlayButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.pauseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.pauseButton setTintColor:[UIColor whiteColor]];
    [self.pauseButton setImage:[UIImage imageNamed:@"player-stop"] forState:(UIControlStateNormal)];
    [self.pauseButton addTarget:self action:@selector(clickPauseButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addSubview:self.bottomBarView];
    [self.bottomBarView addSubview:self.playButton];
    [self.bottomBarView addSubview:self.pauseButton];
    
    [self.bottomBarView addSubview:self.playTimeLabel];
    [self.bottomBarView addSubview:self.multiLabel];
    [self.bottomBarView addSubview:self.durationLabel];
    [self.bottomBarView addSubview:self.bufferingView];
    [self.bottomBarView addSubview:self.retreatPlayImgView];
    [self.bottomBarView addSubview:self.slider];
    [self.bottomBarView addSubview:self.advancePlayBtn];
    [self.bottomBarView addSubview:self.enterFullScreenButton];
}

- (void)initOtherUI {
    
    self.thumbImageView = [[UIImageView alloc] init];
    self.thumbImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
    self.controlView = [[PLControlView alloc] initWithFrame:self.bounds];
    self.controlView.hidden = YES;
    self.controlView.delegate = self;
    
    self.centerPlayButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.centerPlayButton setTintColor:[UIColor whiteColor]];
    [self.centerPlayButton setImage:[UIImage imageNamed:@"playe"] forState:(UIControlStateNormal)];
    [self.centerPlayButton addTarget:self action:@selector(clickPlayButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.centerPauseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.centerPauseButton setTintColor:[UIColor whiteColor]];
    [self.centerPauseButton setImage:[UIImage imageNamed:@"player-stop"] forState:(UIControlStateNormal)];
    [self.centerPauseButton addTarget:self action:@selector(clickPauseButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.snapshotButton = [[UIButton alloc] init];
    [self.snapshotButton addTarget:self action:@selector(clickSnapshotButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.snapshotButton setImage:[UIImage imageNamed:@"screen-cut"] forState:(UIControlStateNormal)];
    
    self.bottomPlayProgreeeView = [[UIProgressView alloc] init];
    self.bottomPlayProgreeeView.progressTintColor = [UIColor colorWithRed:.2 green:.2 blue:.8 alpha:1];
    self.bottomPlayProgreeeView.trackTintColor = [UIColor clearColor];
    
    self.bottomBufferingProgressView = [[UIProgressView alloc] init];
    self.bottomBufferingProgressView.progressTintColor = [UIColor colorWithWhite:1 alpha:1];
    self.bottomBufferingProgressView.trackTintColor = [UIColor colorWithWhite:1 alpha:.33];
    
    [self insertSubview:self.thumbImageView atIndex:0];
//    [self addSubview:self.snapshotButton];
    [self addSubview:self.centerPauseButton];
    [self addSubview:self.centerPlayButton];
    [self addSubview:self.controlView];
    [self addSubview:self.bottomBufferingProgressView];
    [self addSubview:self.bottomPlayProgreeeView];
    
    self.pauseButton.hidden = YES;
    self.centerPauseButton.hidden = YES;
}


// 这些控件的 Constraints 不会随着全屏和非全屏而需要做改变的
- (void)doStableConstraint {
    
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(44);
    }];
//    self.exitfullScreenButton.backgroundColor = [UIColor yellowColor];
    [self.exitfullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.topBarView);
        make.left.mas_equalTo(self.topBarView).offset(self.edgeSpace);
        make.width.mas_equalTo(self.exitfullScreenButton.mas_height);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.topBarView);
        make.right.mas_equalTo(self.topBarView).offset(-self.edgeSpace);
        make.width.mas_equalTo(self.moreButton.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.exitfullScreenButton.mas_right);
        make.right.mas_equalTo(self.moreButton.mas_left);
        make.centerY.mas_equalTo(self.topBarView);
    }];
    
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(44);
    }];
  
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomBarView);
        make.left.mas_equalTo(self.retreatPlayImgView.mas_right).offset(5);
        make.right.mas_equalTo(self.advancePlayBtn.mas_left).offset(-10);
    }];
    
    [self.advancePlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomBarView);
        make.left.mas_equalTo(self.slider.mas_right).offset(10);
        make.height.mas_equalTo(self.bottomBarView);
        make.right.mas_equalTo(self.multiLabel.mas_left).offset(-10);
    }];
    [self.multiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomBarView);
        make.left.mas_equalTo(self.advancePlayBtn.mas_right).offset(10);
        make.height.mas_equalTo(self.bottomBarView);
        make.right.mas_equalTo(self.durationLabel.mas_left).offset(-10);
    }];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.enterFullScreenButton.mas_left);
        make.centerY.mas_equalTo(self.bottomBarView);
        make.size.mas_equalTo(self.durationLabel.bounds.size);
    }];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.playButton);
    }];
    
    [self.centerPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [self.centerPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.centerPlayButton);
    }];
    
    [self.bufferingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.slider);
        make.centerY.mas_equalTo(self.slider).offset(.5);
    }];
    
    [self.playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playButton.mas_right);
        make.width.mas_equalTo(self.playTimeLabel.bounds.size.width);
        make.centerY.mas_equalTo(self.bottomBarView);
    }];
    
    [self.retreatPlayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomBarView);
        make.left.mas_equalTo(self.playTimeLabel.mas_right).offset(10);
        make.height.mas_equalTo(self.bottomBarView);
        make.right.mas_equalTo(self.slider.mas_left).offset(-10);
    }];
    
    
    
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
//    [self.snapshotButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(self).offset(-self.edgeSpace);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//    
    [self.bottomBufferingProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(3);
    }];
    
    [self.bottomPlayProgreeeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bottomBufferingProgressView);
    }];
    
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(290);
    }];
    self.controlView.hidden = YES;
}

- (void)addTimer {
    [self removeTimer];
    self.timelong = 0;
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

- (void)timerAction {
    
    self.slider.value = CMTimeGetSeconds(self.player.currentTime);
    NSLog(@"time = %f",CMTimeGetSeconds(self.player.totalDuration));
    
    if (self.player.status == PLPlayerStatusPlaying) {
        
        self.PlaylongTime = CMTimeGetSeconds(self.player.currentTime);
    } else {
        return;
    }
    self.timelong ++;
    if (CMTimeGetSeconds(self.player.totalDuration)) {
        int duration = self.slider.value + .5;
        int hour = duration / 3600;
        int min  = (duration % 3600) / 60;
        int sec  = duration % 60;
        self.playTimeLabel.text = [NSString stringWithFormat:@"%d:%02d:%02d", hour, min, sec];
        self.bottomPlayProgreeeView.progress = self.slider.value / CMTimeGetSeconds(self.player.totalDuration);
        NSString *time = [NSString stringWithFormat:@"%d:%02d:%02d", hour, min, sec];
        if (self.BlockTimerClick) {
            self.BlockTimerClick(time, CMTimeGetSeconds(self.player.currentTime));
        }
        
        if (self.timelong >= 20) {
            [self studyUpdate:NO];
        }
    
    
    }
}
- (void)studyUpdate:(BOOL)clear {
    NSString *sourceTypeId = @"";
    NSString *type = @"";
    if (self.PlayerType == 1) {
        type = @"video";
        sourceTypeId = @"vid";
    } else if (self.PlayerType == 2) {
        type = @"audio";
        sourceTypeId = @"aid";

    } else {
        // if there have to play the audio or video, I can't invoke the interface
        return;
    }
    if (self.timelong == 0 || CMTimeGetSeconds(self.player.currentTime) == 0.0 ) {
        // if current timelong is 0 ,I can't invoke the interface.
        return;
    }
   
    
    NSDictionary *params = @{
        @"course_id":self.playerModel.cid,
        @"type":type,
        sourceTypeId:self.playerModel.id,
        @"long_time":[NSString stringWithFormat:@"%ld",(long)self.timelong],     // 20秒上一次，退出，暂停的时候上一次，清0
        @"study_time":[NSString stringWithFormat:@"%ld",(long)self.PlaylongTime] //单个视频的观看时间记录
    };
    
    
        self.timelong = 0;
    
    NSLog(@"%@",params);
    
    [APPRequest POST:@"/updateCourseRecord" parameters:params finished:^(AjaxResult *result) {
        NSLog(@"%lu",(unsigned long)result.code);
        NSLog(@"%@",result.data);

        if (result.code == AjaxResultStateSuccess) {
            NSLog(@"The request is successful");
            

        }


    }];
}
- (void)panGesture:(UIPanGestureRecognizer *)panGesture {

    if (UIGestureRecognizerStateChanged == panGesture.state) {
        CGPoint location  = [panGesture locationInView:panGesture.view];
        CGPoint translation = [panGesture translationInView:panGesture.view];
        [panGesture setTranslation:CGPointZero inView:panGesture.view];

#define FULL_VALUE 200.0f
        CGFloat percent = translation.y / FULL_VALUE;
        if (location.x > self.bounds.size.width / 2) {// 调节音量
            
            CGFloat volume = [self.player getVolume];
            volume -= percent;
            if (volume < 0.01) {
                volume = 0.01;
            } else if (volume > 3) {
                volume = 3;
            }
            [self.player setVolume:volume];
        } else {// 调节亮度f
            CGFloat currentBrightness = [[UIScreen mainScreen] brightness];
            currentBrightness -= percent;
            if (currentBrightness < 0.1) {
                currentBrightness = 0.1;
            } else if (currentBrightness > 1) {
                currentBrightness = 1;
            }
            [[UIScreen mainScreen] setBrightness:currentBrightness];
        }
    }
}

- (void)singleTap:(UIGestureRecognizer *)gesture {
    
    // 如果还木有初始化，直接初始化播放
    if (self.isNeedSetupPlayer || PLPlayerStatusStopped == self.player.status) {
        [self play];
        return;
    }
    
    if (PLPlayerStatusPaused == self.player.status) {
        [self resume];
        return;
    }
    
    if (PLPlayerStatusPlaying == self.player.status) {
        if (self.bottomBarView.frame.origin.y >= self.bounds.size.height) {
            [self showBar];
        } else {
            [self hideBar];
        }
    }
}

- (void)hideBar {
    
    if (PLPlayerStatusPlaying != self.player.status) return;
    
    [self hideTopBar];
    [self hideBottomBar];
    self.centerPauseButton.hidden = YES;
    [self doConstraintAnimation];
    
}

- (void)showBar {
    
    [self showBottomBar];
    self.centerPauseButton.hidden = NO;
    if ([self isFullScreen]) {
        [self showTopBar];
    }
    [self doConstraintAnimation];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideBar) object:nil];
    [self performSelector:@selector(hideBar) withObject:nil afterDelay:6];
}

- (void)showControlView {
    
    [self hideBar];
    [self hideTopBar];
    self.centerPauseButton.hidden = YES;
    self.centerPlayButton.hidden = YES;
    
    self.controlView.hidden = NO;
    [self.controlView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self doConstraintAnimation];
}

- (void)hideControlView {
    
    [self.controlView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(290);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.controlView.hidden = YES;
    }];
}

- (void)clickExitFullScreenButton {
    self.currentIsFullScreen = 0;
    [self transformWithOrientation:UIDeviceOrientationPortrait];
}

- (void)clickEnterFullScreenButton {
    if (UIDeviceOrientationLandscapeRight == [[UIDevice currentDevice]orientation]) {
        [self transformWithOrientation:UIDeviceOrientationLandscapeRight];
        self.currentIsFullScreen = 2;
    } else {
        [self transformWithOrientation:UIDeviceOrientationLandscapeLeft];
        self.currentIsFullScreen = 1;
    }
}

- (void)clickMoreButton {
    [self removeGestureRecognizer:self.tapGesture];
    [self removeGestureRecognizer:self.panGesture];
    [self showControlView];
}

- (void)clickSnapshotButton {
    
    __weak typeof(self) wself = self;

//    [NSObject haveAlbumAccess:^(BOOL isAuth) {
//        if (!isAuth) return;
//
//        [wself.player getScreenShotWithCompletionHandler:^(UIImage * _Nullable image) {
//            if (image) {
//                [wself showTip:@"拍照成功"];
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//            }
//        }];
//    }];
}

- (void)sliderValueChange {
    [self.player seekTo:CMTimeMake(self.slider.value * 1000, 1000)];
}

- (void)doConstraintAnimation {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)hideTopBar {
    [self.topBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(44);
    }];
}

- (void)hideBottomBar {
    [self.bottomBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    self.snapshotButton.hidden = YES;
    
    if (PLPlayerStatusPlaying == self.player.status ||
        PLPlayerStatusPaused == self.player.status ||
        PLPlayerStatusCaching == self.player.status) {
        [self showBottomProgressView];
    }
}

- (void)showTopBar {
    [self.topBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    self.snapshotButton.hidden = NO;
}

- (void)showBottomBar {
    [self.bottomBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    [self hideBottomProgressView];
}

- (void)showBottomProgressView {
//    self.bottomBufferingProgressView.hidden = NO;
//    self.bottomPlayProgreeeView.hidden = NO;
}

- (void)hideBottomProgressView {
    self.bottomBufferingProgressView.hidden = YES;
    self.bottomPlayProgreeeView.hidden = YES;
}

- (void)transformWithOrientation:(UIDeviceOrientation)or {
    
    if (or == self.deviceOrientation) return;
    if (!(UIDeviceOrientationPortrait == or || UIDeviceOrientationLandscapeLeft == or || UIDeviceOrientationLandscapeRight == or)) return;
    
    BOOL isFirst = UIDeviceOrientationUnknown == self.deviceOrientation;
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_DirectionChange object:nil];
    
    if (or == UIDeviceOrientationPortrait) {
        
        [self removeGestureRecognizer:self.panGesture];
        self.snapshotButton.hidden = YES;
        
        [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.bottomBarView);
            make.left.mas_equalTo(self.bottomBarView).offset(5);
            make.width.mas_equalTo(0);
        }];
        
        [self.enterFullScreenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self.bottomBarView);
            make.width.mas_equalTo(self.enterFullScreenButton.mas_height);
        }];
        
        [self.centerPlayButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(64, 64));
        }];
        
        if (!isFirst) {
            [self hideTopBar];
            [self hideControlView];
            [self doConstraintAnimation];
            [self.delegate playerViewExitFullScreen:self];
            if (![self.gestureRecognizers containsObject:self.tapGesture]) {
                [self addGestureRecognizer:self.tapGesture];
            }
        }
        [UIView animateWithDuration:.3 animations:^{
            self.transform = CGAffineTransformMakeRotation(0);
        }];
        
    } else {
        
        if (![[self gestureRecognizers] containsObject:self.panGesture]) {
            [self addGestureRecognizer:self.panGesture];
        }
        
        CGFloat duration = .5;
        if (!UIDeviceOrientationIsLandscape(self.deviceOrientation)) {
            duration = .3;
            
            [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self.bottomBarView);
                make.left.mas_equalTo(self.bottomBarView).offset(self.edgeSpace);
                make.width.mas_equalTo(self.playButton.mas_height);
            }];
            
            [self.enterFullScreenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self.bottomBarView);
                make.right.mas_equalTo(self.bottomBarView).offset(-self.edgeSpace);
                make.width.mas_equalTo(0);
            }];
            
            [self.centerPlayButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self);
                make.size.mas_equalTo(CGSizeMake(0, 0));
            }];
            
            [self doConstraintAnimation];
        }
        
        [UIView animateWithDuration:duration animations:^{
            self.transform = UIDeviceOrientationLandscapeLeft == or ? CGAffineTransformMakeRotation(M_PI/2) : CGAffineTransformMakeRotation(3*M_PI/2);
        }];
        
        if (UIDeviceOrientationUnknown != self.deviceOrientation) {
            [self.delegate playerViewEnterFullScreen:self];
        }
    }
    
    self.deviceOrientation = or;
}

-(void)addFullStreenNotify{
    
    [self removeFullStreenNotify];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvDeviceOrientationChangeNotify:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)removeFullStreenNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)recvDeviceOrientationChangeNotify:(NSNotification*)info{
    UIDeviceOrientation or = [[UIDevice currentDevice]orientation];
    [self transformWithOrientation:or];
}

- (void)clickPauseButton {
    [self pause];
}

- (void)clickPlayButton {
    if (PLPlayerStatusPaused == self.player.status) {
        [self resume];
    } else {
        [self play];
    }
}
- (void)ContinuePlayClicl{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:@"isOneTrafficPlay"];
    [user synchronize];
    
    [self hideTrafficView];
    if (self.player.status == PLPlayerStatusPlaying) {
        
        [self resume];
    }else{
        [self playUrl];
    }
}
- (void)showTrafficView{
    
    if (self.player.status == PLPlayerStatusPlaying) {
        [self pause];
    }
    
    self.TrafficHazyView.hidden = NO;
    self.lblPrompt.hidden = NO;
    self.btnContinue.hidden = NO;
    
    self.shadowView.hidden = YES;
    self.centerPlayButton.hidden = YES;
    self.centerPauseButton.hidden = YES;
    
    [self removeGestureRecognizer:self.tapGesture];
}

- (void)judgeNetworkChange{
    
    YCDownloadItem *item = [YCDownloadManager itemWithFileId:self.playerModel.did];
    if (!item) { //没有缓存 需要网络播放 判断是否允许流量播放
        if ([CoreStatus isNetworkEnable]) {
            
            if (!KIsTrafficPlay) { //不允许流量播放
                if (!KIsOneTrafficPlay) { //每次打开app都为no 设置为yes后 就不会a弹出提示
                    if (![CoreStatus isWifiEnable]) { // 没在wifi状态
                        if (self.player.status == PLPlayerStatusPlaying) {
                            [self pause];
                        }
                        
                        UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
                        UITabBarController *tableBar = (UITabBarController *)window.rootViewController;
                        
                        //获取当前导航控制器
                        UINavigationController *currentNav = tableBar.selectedViewController;
                        UIViewController *currentController = currentNav.visibleViewController;
                        
                        [UIAlertController showAlertInViewController:currentController withTitle:@"当前无WiFi，播放将耗流量" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"继续播放" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                            
                            if (buttonIndex == 1) {
                                
                                if (self.player.status == PLPlayerStatusPlaying) {
                                    
                                    [self resume];
                                }else{
                                    [self playUrl];
                                }
                                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                [user setBool:YES forKey:@"isOneTrafficPlay"];
                                [user synchronize];
                            }
                        }];
                        
//                        if (self.PlayerType == 1) {
//
//                            [self showTrafficView];
//                        }else if (self.PlayerType == 2){
//
//
//                        }
                        
                        return;
                    }
                }
            }
        }
    }
    
    [self hideTrafficView];
    if (self.player.status == PLPlayerStatusPaused) {
        
        [self resume];
    }else if (self.player.status == PLPlayerStatusPlaying){
        
        [self pause];
    }else{
        
        [self playUrl];
    }
}

- (void)setupPlayer {
    [self unsetupPlayer];
    
    
    self.thumbImageView.hidden = NO;
//    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:self.playerModel.thumbURL]];
    if (self.playerModel.transcoding_path.length == 0 || self.playerModel.transcoding_path == nil) {
        
        self.isPlayUrlNil = YES;
        
        return;
    }
    NSURL *playUrl = [NSURL URLWithString:@""];
    YCDownloadItem *item = [YCDownloadManager itemWithFileId:self.playerModel.did];
    if (item) {
        
        if (item.downloadStatus == YCDownloadStatusFinished) { //下载完成才能播放本地
            
            self.playerUrl = item.savePath;
            playUrl = [NSURL URLWithString:self.playerUrl];
        }else{ //未完成 继续用网络播放
            
            self.playerUrl = self.playerModel.transcoding_path;
            playUrl = [NSURL URLWithString:self.playerUrl];
        }
    }else{
        
        self.playerUrl = self.playerModel.transcoding_path;
        playUrl = [NSURL URLWithString:self.playerUrl];
    }
    NSLog(@"%@",self.playerUrl);
    
    self.playerOption = [PLPlayerOption defaultOption];
    PLPlayFormat format = kPLPLAY_FORMAT_UnKnown;
    NSString *urlString = self.playerUrl.lowercaseString;
    if ([urlString hasSuffix:@"mp4"]) {
        format = kPLPLAY_FORMAT_MP4;
    } else if ([urlString hasPrefix:@"rtmp:"]) {
        format = kPLPLAY_FORMAT_FLV;
    } else if ([urlString hasSuffix:@".mp3"]) {
        format = kPLPLAY_FORMAT_MP3;
    } else if ([urlString hasSuffix:@".m3u8"]) {
        format = kPLPLAY_FORMAT_M3U8;
    }
    [self.playerOption setOptionValue:@(format) forKey:PLPlayerOptionKeyVideoPreferFormat];
    [self.playerOption setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    NSDate *date = [NSDate date];
    self.player = [PLPlayer playerWithURL:playUrl option:self.playerOption];
    
    NSLog(@"playerWithURL 耗时： %f s",[[NSDate date] timeIntervalSinceDate:date]);
    
    self.player.delegateQueue = dispatch_get_main_queue();
    self.player.playerView.contentMode = UIViewContentModeScaleAspectFit;
    self.player.delegate = self;
    self.player.loopPlay = NO;
    self.player.DRMKey = @"JK6mTLdtGcx8mbqg";

    [self insertSubview:self.player.playerView atIndex:0];
    self.player.playerView.frame = self.bounds;
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)unsetupPlayer {
    [self stop];
    
    if (self.player.playerView.superview) {
        [self.player.playerView removeFromSuperview];
    }
    [self removeTimer];
}

//- (void)setMedia:(PLMediaInfo *)media {
//    _media = media;
//    self.titleLabel.text = media.detailDesc;
//    self.isNeedSetupPlayer = YES;
//    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:_media.thumbURL]];
//}

- (void)play {
    WS(weakself)
       if (!Ktoken) {
           [weakself gotoLogin];
                    return;
                }
    if (![CoreStatus isNetworkEnable]) {
        [KeyWindow showTip:@"网络貌似有问题..."];
        return;
    }
    //    是否是vip 1:是0:不是
    if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
        
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 0) { //未购买
            
            if ([self.model.price floatValue] <= 0) { //免费 需要报名
                
                if ([self.playerModel.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要报名，请先报名"];
                    return ;
                }
            }else{
                
                if ([self.playerModel.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要付费，请先购买"];
                    return ;
                }
            }
        }
    }
    
    
    if (self.isNeedSetupPlayer) {
        [self setupPlayer];
        self.isNeedSetupPlayer = NO;
    }
    [self judgeNetworkChange];

//    self.isStop = NO;
//
//    [self.delegate playerViewWillPlay:self];
//    [self addFullStreenNotify];
//    [self addTimer];
//    [self resetButton:YES];
//
//    if (!(PLPlayerStatusReady == self.player.status ||
//        PLPlayerStatusOpen == self.player.status ||
//        PLPlayerStatusCaching == self.player.status ||
//        PLPlayerStatusPlaying == self.player.status ||
//        PLPlayerStatusPreparing == self.player.status)
//        ) {
//        NSDate *date = [NSDate date];
//        [self.player play];
//        NSLog(@"play 耗时： %f s",[[NSDate date] timeIntervalSinceDate:date]);
//    }
    
    if (self.PlayerType == 1) {
        [self.audioView removeFromSuperview];
    }
   
    
   
}

- (void)pause {
    [self studyUpdate:NO];
    [self.player pause];
    [self resetButton:NO];
        if (self.PlayerType == 2) {
        [self setPlayingInfo];
    }
}

- (void)resume {
    
    [self.delegate playerViewWillPlay:self];
    [self.player resume];
    [self resetButton:YES];
}

- (void)stop {
    [self studyUpdate:NO];
    NSDate *date = nil;
    if ([self.player isPlaying]) {
        date = [NSDate date];
    }
    [self.player stop];
    if (date) {
        NSLog(@"stop 耗时： %f s",[[NSDate date] timeIntervalSinceDate:date]);
    }
    
    
    [self removeFullStreenNotify];
    [self resetUI];
    [self.controlView resetStatus];
    self.isStop = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)resetUI {
    
    self.bufferingView.progress = 0;
    self.slider.value = 0;
    self.playTimeLabel.text = @"0:00:00";
    self.durationLabel.text = @"0:00:00";
    self.thumbImageView.hidden = NO;
    
    [self resetButton:NO];
    [self hideFullLoading];
    
    [self hideTopBar];
    [self hideBottomBar];
    [self hideBottomProgressView];
    [self doConstraintAnimation];
    
}
- (NSArray *)speedAry{
    
    if (_speedAry == nil) {
        
        _speedAry = @[@1.0,@1.25,@1.5,@0.5,@0.75];
    }
    
    return _speedAry;
}

- (void)resetButton:(BOOL)isPlaying {
    
    self.playButton.hidden = isPlaying;
    self.pauseButton.hidden = !isPlaying;
    
    if (isPlaying) {
        self.centerPauseButton.hidden = NO;
        self.centerPlayButton.hidden  = YES;
        self.audioView.btnPlay.selected = YES;
        [self.audioView.autoScrollLabel setScrollSpeed:17.0];
        [self.audioView.runImgView startAnimating];
    } else {
        self.centerPauseButton.hidden = YES;
        [self.centerPlayButton show];
        self.audioView.btnPlay.selected = NO;
        [self.audioView.autoScrollLabel setScrollSpeed:0.0];
        [self.audioView.runImgView stopAnimating];


    }
}

// 避免 pan 手势将 slider 手势给屏蔽掉
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGesture) {
        CGPoint point = [gestureRecognizer locationInView:self];
        return !CGRectContainsPoint(self.bottomBarView.frame, point);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.panGesture) {
        CGPoint point = [touch locationInView:self];
        return !CGRectContainsPoint(self.bottomBarView.frame, point);
    }
    return YES;
}

// PLControlViewDelegate
- (void)controlViewClose:(PLControlView *)controlView {
    
    [self hideControlView];
    
    if (![[self gestureRecognizers] containsObject:self.panGesture]) {
        [self addGestureRecognizer:self.panGesture];
    }
    if (![[self gestureRecognizers] containsObject:self.tapGesture]) {
        [self addGestureRecognizer:self.tapGesture];
    }
}

- (void)controlView:(PLControlView *)controlView speedChange:(CGFloat)speed {
    [self.player setPlaySpeed:speed];
}

- (void)controlView:(PLControlView *)controlView ratioChange:(PLPlayerRatio)ratio {
    CGRect rc = CGRectMake(0, 0, self.player.width, self.player.height);
    if (PLPlayerRatioDefault == ratio) {
        [self.player setVideoClipFrame:CGRectZero];
    } else if (PLPlayerRatioFullScreen == ratio) {
        [self.player setVideoClipFrame:rc];
    } else if (PLPlayerRatio16x9 == ratio) {
        CGFloat width = 0;
        CGFloat height = 0;
        if (rc.size.width / rc.size.height > 16.0 / 9.0) {
            height = rc.size.height;
            width = rc.size.height * 16.0 / 9.0;
            rc.origin.x = (rc.size.width - width ) / 2;
        } else {
            width = rc.size.width;
            height = rc.size.width * 9.0 / 16.0;
            rc.origin.y = (rc.size.height - height ) / 2;
        }
        rc.size.width = width;
        rc.size.height = height;
        [self.player setVideoClipFrame:rc];
    } else if (PLPlayerRatio4x3 == ratio) {
        CGFloat width = 0;
        CGFloat height = 0;
        if (rc.size.width / rc.size.height > 4.0 / 3.0) {
            height = rc.size.height;
            width = rc.size.height * 4.0 / 3.0;
            rc.origin.x = (rc.size.width - width ) / 2;
        } else {
            width = rc.size.width;
            height = rc.size.width * 3.0 / 4.0;
            rc.origin.y = (rc.size.height - height ) / 2;
        }
        rc.size.width = width;
        rc.size.height = height;
        [self.player setVideoClipFrame:rc];
    }
}

- (void)controlView:(PLControlView *)controlView backgroundPlayChange:(BOOL)isBackgroundPlay {
    [self.player setBackgroundPlayEnable:isBackgroundPlay];
}

- (void)controlViewMirror:(PLControlView *)controlView {
    if (PLPlayerFlipHorizonal != self.player.rotationMode) {
        self.player.rotationMode = PLPlayerFlipHorizonal;
    } else {
        self.player.rotationMode = PLPlayerNoRotation;
    }
}


- (void)setPlayerRow:(NSInteger)playerRow {
//    if (_playerRow != playerRow) {
//        // 当不相同的时候
//        if (self.PlayerType == 2) {
//            // self.
//            if (self.BlockAudeoVCPlayRow) {
//                self.BlockAudeoVCPlayRow(playerRow);
//            }
//        }
//    }
    _playerRow = playerRow;
    
   
}
- (void)controlViewRotate:(PLControlView *)controlView {
    
    PLPlayerRotationsMode mode = self.player.rotationMode;
    mode ++;
    if (mode > PLPlayerRotate180) {
        mode = PLPlayerNoRotation;
    }
    self.player.rotationMode = mode;
}

- (BOOL)controlViewCache:(PLControlView *)controlView {
    if ([self.playerOption optionValueForKey:PLPlayerOptionKeyVideoCacheFolderPath]) {
        [_playerOption setOptionValue:nil forKey:PLPlayerOptionKeyVideoCacheFolderPath];
        [_playerOption setOptionValue:nil forKey:PLPlayerOptionKeyVideoCacheExtensionName];
        return NO;
    } else {
        NSString* docPathDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        docPathDir = [docPathDir stringByAppendingString:@"/PLCache/"];
        [_playerOption setOptionValue:docPathDir forKey:PLPlayerOptionKeyVideoCacheFolderPath];
        [_playerOption setOptionValue:@"mp4" forKey:PLPlayerOptionKeyVideoCacheExtensionName];
        return YES;
    }
}


#pragma mark - PLPlayerDelegate

- (void)playerWillBeginBackgroundTask:(PLPlayer *)player {
    
//    if (self.PlayerType == 1 && !self.videoBein) {
//        self.videoBein = true;
//        [self.player pause];
//    }
    
    
    
}
- (void)playerWillEndBackgroundTask:(PLPlayer *)player {
     
//    if (self.PlayerType == 1 && self.videoBein) {
//        self.videoBein = false;
//        [self.player resume];
//    }
}




- (void)setPlayingInfo {
//    设置后台播放时显示的东西，例如歌曲名字，图片等
//    <MediaPlayer/MediaPlayer.h>
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"80_80"]];
    
    NSDictionary *dic = @{MPMediaItemPropertyTitle:self.playerModel.title,
                          MPMediaItemPropertyArtist:@"",
                          MPMediaItemPropertyPlaybackDuration:@(self.playerModel.duration),
                          MPNowPlayingInfoPropertyElapsedPlaybackTime:@(CMTimeGetSeconds(self.player.currentTime)),
                          MPMediaItemPropertyArtwork:artWork
                          };
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
}



- (void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state
{
    if (self.BlockViewPlayerStatus) {
        self.BlockViewPlayerStatus(state);
    }
    
    
    
 
   
    
    
    
    if (self.isStop) {
        static NSString * statesString[] = {
            @"PLPlayerStatusUnknow"
            @"PLPlayerStatusPreparing",
            @"PLPlayerStatusReady",
            @"PLPlayerStatusOpen",
            @"PLPlayerStatusCaching",
            @"PLPlayerStatusPlaying",
            @"PLPlayerStatusPaused",
            @"PLPlayerStatusStopped",
            @"PLPlayerStatusError",
            @"PLPlayerStateAutoReconnecting",
            @"PLPlayerStatusCompleted"
        };
//        NSLog(@"stop statusDidChange self,= %p state = %@", self, statesString[state]);
        [self stop];
        return;
    }
    
    if (state == PLPlayerStatusPlaying ||
        state == PLPlayerStatusPaused ||
        state == PLPlayerStatusStopped ||
        state == PLPlayerStatusError ||
        state == PLPlayerStatusUnknow ||
        state == PLPlayerStatusCompleted) {
        [self hideFullLoading];
    } else if (state == PLPlayerStatusPreparing ||
               state == PLPlayerStatusReady ||
               state == PLPlayerStatusCaching) {
        [self showFullLoading];
        self.centerPauseButton.hidden = YES;
    } else if (state == PLPlayerStateAutoReconnecting) {
        [self showFullLoading];
        self.centerPauseButton.hidden = YES;
        // alert 重新
        [self showTip:@"重新连接..."];
    }
    
    //开始播放之后，如果 bar 是显示的，则 3 秒之后自动隐藏
    if (PLPlayerStatusPlaying == state) {
        if (self.bottomBarView.frame.origin.y >= self.bounds.size.height) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideBar) object:nil];
            [self performSelector:@selector(hideBar) withObject:nil afterDelay:6];
        }
    }
    
    
    
    
    
}

- (void)player:(PLPlayer *)player stoppedWithError:(NSError *)error
{
    NSString *info = error.userInfo[@"NSLocalizedDescription"];
    [self showTip:info];
    
    [self stop];
}

- (void)player:(nonnull PLPlayer *)player willRenderFrame:(nullable CVPixelBufferRef)frame pts:(int64_t)pts sarNumerator:(int)sarNumerator sarDenominator:(int)sarDenominator {
    dispatch_main_async_safe(^{
        if (![UIApplication sharedApplication].isIdleTimerDisabled) {
            [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        }
    });
}

- (AudioBufferList *)player:(PLPlayer *)player willAudioRenderBuffer:(AudioBufferList *)audioBufferList asbd:(AudioStreamBasicDescription)audioStreamDescription pts:(int64_t)pts sampleFormat:(PLPlayerAVSampleFormat)sampleFormat{
    return audioBufferList;
}

- (void)player:(nonnull PLPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType {
    if (PLPlayerFirstRenderTypeVideo == firstRenderType) {
        self.thumbImageView.hidden = YES;
    }
    self.slider.maximumValue = CMTimeGetSeconds(self.player.totalDuration);
    self.slider.minimumValue = 0;
    
    CGFloat fduration = CMTimeGetSeconds(self.player.totalDuration);
    int duration = fduration + .5;
    int hour = duration / 3600;
    int min  = (duration % 3600) / 60;
    int sec  = duration % 60;
    self.durationLabel.text = [NSString stringWithFormat:@"%d:%02d:%02d", hour, min, sec];
}

- (void)player:(nonnull PLPlayer *)player SEIData:(nullable NSData *)SEIData {
    
}

- (void)player:(PLPlayer *)player codecError:(NSError *)error {
    NSString *info = error.userInfo[@"NSLocalizedDescription"];
    [self showTip:info];
    
    [self stop];
}

- (void)player:(PLPlayer *)player loadedTimeRange:(CMTime)timeRange {
    
    float startSeconds = 0;
    float durationSeconds = CMTimeGetSeconds(timeRange);
    CGFloat totalDuration = CMTimeGetSeconds(self.player.totalDuration);
    self.bufferingView.progress = (durationSeconds - startSeconds) / totalDuration;
    self.bottomBufferingProgressView.progress = self.bufferingView.progress;
}

@end



@implementation PLControlView

static NSString * speedString[] = {@"0.5", @"0.75", @"1.0", @"1.25", @"1.5"};

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(self);
            make.width.mas_equalTo(290);
        }];
        
        UIButton *dismissButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [dismissButton addTarget:self action:@selector(clickCloseButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:dismissButton];
        [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(bgView.mas_left);
        }];
        
        
        self.scrollView = [[UIScrollView alloc] init];
        UIView *contentView = [[UIView alloc] init];
        
        UIView *barView = [[UIView alloc] init];
        [barView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.5]];
        
        UILabel *title = [[UILabel alloc] init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:18];
        title.textColor = [UIColor whiteColor];
        title.text = @"播放设置";
        
        UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [closeButton setTintColor:[UIColor whiteColor]];
        [closeButton setImage:[UIImage imageNamed:@"player_close"] forState:(UIControlStateNormal)];
        [closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:(UIControlEventTouchUpInside)];
        
        [bgView addSubview:barView];
        [bgView addSubview:self.scrollView];
        [barView addSubview:title];
        [barView addSubview:closeButton];
        [self.scrollView addSubview:contentView];
        
        [barView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(bgView);
            make.height.mas_equalTo(50);
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(barView);
        }];
        
        if (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 375, 812))) {
            // iPhone X
            [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(barView);
                make.right.mas_equalTo(barView).offset(-20);
                make.width.mas_equalTo(closeButton.mas_height);
            }];
        } else {
            [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(barView);
                make.right.mas_equalTo(barView).offset(-5);
                make.width.mas_equalTo(closeButton.mas_height);
            }];
        }
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(bgView);
            make.top.mas_equalTo(barView.mas_bottom);
        }];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(bgView);
        }];
        
        self.speedTitleLabel = [[UILabel alloc] init];
        self.speedTitleLabel.font = [UIFont systemFontOfSize:12];
        self.speedTitleLabel.textColor = [UIColor colorWithWhite:.8 alpha:1];
        self.speedTitleLabel.text = @"播放速度：";
        [self.speedTitleLabel sizeToFit];
        
        self.speedValueLabel = [[UILabel alloc] init];
        self.speedValueLabel.font = [UIFont systemFontOfSize:12];
        self.speedValueLabel.textColor = [UIColor colorWithRed:.33 green:.66 blue:1 alpha:1];
        self.speedValueLabel.text = @"1.0";
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithWhite:1 alpha:.5], NSForegroundColorAttributeName, [UIFont systemFontOfSize:12],NSFontAttributeName,nil];
        NSDictionary *dicS = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:.33 green:.66 blue:1 alpha:1],NSForegroundColorAttributeName, [UIFont systemFontOfSize:12],NSFontAttributeName ,nil];

        self.speedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:speedString count:ARRAY_SIZE(speedString)]];
        [self.speedControl addTarget:self action:@selector(speedControlChange:) forControlEvents:(UIControlEventValueChanged)];
        [self.speedControl setTitleTextAttributes:dicS forState:UIControlStateSelected];
        [self.speedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
        self.speedControl.tintColor = [UIColor clearColor];
        
        self.ratioControl = [[UISegmentedControl alloc] initWithItems:@[@"默认", @"全屏", @"16:9", @"4:3"]];
        [self.ratioControl addTarget:self action:@selector(ratioControlChange:) forControlEvents:(UIControlEventValueChanged)];
        [self.ratioControl setTitleTextAttributes:dicS forState:UIControlStateSelected];
        [self.ratioControl setTitleTextAttributes:dic forState:UIControlStateNormal];
        self.ratioControl.tintColor = [UIColor clearColor];
 
        UIButton *button[4];
        NSString *buttonTitles[4] = {@"后台播放", @"镜像反转", @"旋转", @"本地缓存"};
        NSString *buttonImages[4] = {@"background_play", @"mirror_swtich", @"rotate", @"save"};
        for (int i = 0; i < 4; i ++) {
            button[i] = [[UIButton alloc] init];
            [button[i] setImage:[UIImage imageNamed:buttonImages[i]] forState:(UIControlStateNormal)];
            [button[i] setTitle:buttonTitles[i] forState:(UIControlStateNormal)];
            button[i].titleLabel.font = [UIFont systemFontOfSize:14];
        }
        
        self.playBackgroundButton = button[0];
        self.mirrorButton = button[1];
        self.rotateButton = button[2];
        self.cacheButton  = button[3];
        
        [self.playBackgroundButton addTarget:self action:@selector(clickPlayBackgroundButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.mirrorButton addTarget:self action:@selector(clickMirrorButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.rotateButton addTarget:self action:@selector(clickRotateButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.cacheButton addTarget:self action:@selector(clickCacheButton) forControlEvents:(UIControlEventTouchUpInside)];
        
        [contentView addSubview:_speedTitleLabel];
        [contentView addSubview:_speedValueLabel];
        [contentView addSubview:_speedControl];
        [contentView addSubview:_ratioControl];
//        [contentView addSubview:_playBackgroundButton];
//        [contentView addSubview:_mirrorButton];
//        [contentView addSubview:_rotateButton];
//        [contentView addSubview:_cacheButton];
//
        // 这几句对齐的代码太 low 了，Demo中用用
        [_playBackgroundButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_mirrorButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_cacheButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        [_rotateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_rotateButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        
        [_cacheButton setTitle:@"缓存已开" forState:(UIControlStateSelected)];
        
        [self.speedTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(contentView).offset(20);
            make.width.mas_equalTo(self.speedTitleLabel.bounds.size.width);
        }];
        
        [self.speedValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.speedTitleLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(self.speedTitleLabel);
        }];
        
        [_speedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.speedTitleLabel);
            make.right.mas_equalTo(contentView).offset(-20);
            make.top.mas_equalTo(self.speedTitleLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
        
        [_ratioControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.right.mas_equalTo(_speedControl);
            make.top.mas_equalTo(_speedControl.mas_bottom).offset(20);
        }];
        
//        [_playBackgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_speedControl);
//            make.right.mas_equalTo(contentView.mas_centerX);
//            make.top.mas_equalTo(_ratioControl.mas_bottom).offset(20);
//            make.height.mas_equalTo(50);
//        }];
//
//        [_mirrorButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_playBackgroundButton.mas_right);
//            make.size.centerY.mas_equalTo(_playBackgroundButton);
//        }];
//
//        [_rotateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.height.mas_equalTo(_playBackgroundButton);
//            make.top.mas_equalTo(_playBackgroundButton.mas_bottom).offset(20);
//        }];
//
//        [_cacheButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(_mirrorButton);
//            make.height.mas_equalTo(_mirrorButton);
//            make.centerY.mas_equalTo(_rotateButton);
//            make.bottom.mas_equalTo(contentView).offset(-20);
//        }];
        
        [self resetStatus];
    }
    return self;
}

- (void)resetStatus {
    self.speedControl.selectedSegmentIndex = 2;
    self.ratioControl.selectedSegmentIndex = 0;
    self.playBackgroundButton.selected     = NO;
    self.cacheButton.selected = NO;
    self.speedValueLabel.text =  speedString[self.speedControl.selectedSegmentIndex];
}

- (void)speedControlChange:(UISegmentedControl *)control {
    self.speedValueLabel.text =  speedString[control.selectedSegmentIndex];
    [self.delegate controlView:self speedChange:[speedString[control.selectedSegmentIndex] floatValue]];
}

- (void)ratioControlChange:(UISegmentedControl *)control {
    [self.delegate controlView:self ratioChange:control.selectedSegmentIndex];
}

- (void)clickPlayBackgroundButton {
    self.playBackgroundButton.selected = !self.playBackgroundButton.isSelected;
    [self.delegate controlView:self backgroundPlayChange:self.playBackgroundButton.isSelected];
}

- (void)clickMirrorButton {
    [self.delegate controlViewMirror:self];
}

- (void)clickRotateButton {
    [self.delegate controlViewRotate:self];
}

- (void)clickCacheButton {
    self.cacheButton.selected = [self.delegate controlViewCache:self];
}

- (void)clickCloseButton {
    [self.delegate controlViewClose:self];
}

@end
#import "ImportHeader.h"

@implementation PlayerAudioView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *y = [[UIView alloc] initWithFrame:CGRectMake(38.5, 6.0, 130.5, 55)];
        [self addSubview:y];
       y.backgroundColor = [UIColor colorWithHex:0x489A9B];
        CAGradientLayer *gradient = [CAGradientLayer layer];
         gradient.frame = y.bounds;
        gradient.startPoint = CGPointMake(0, 0.5);
        gradient.endPoint = CGPointMake(1, 0.5);
        gradient.colors = @[(id)[UIColor colorWithHex:0x489A9B].CGColor,(id)[UIColor colorWithHex:0x456988].CGColor];
         [y.layer addSublayer:gradient];
        
        
        self.userInteractionEnabled = YES;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 27.5;
        
        self.imgView = [[UIImageView alloc] init];
        
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 29.5;
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(6);
            make.width.height.mas_equalTo(55);
        }];
        
        UIImageView *show = [[UIImageView alloc] init];
        self.runImgView = show;
        show.layer.masksToBounds = YES;
        show.image = [UIImage imageNamed:@"音屏动效1"];
                
        [show showGifImageWithData:self.imgData];
        [show startAnimating];


        show.layer.cornerRadius = 10.5;
        [y addSubview:show];
        [show mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(28.0);
            make.top.mas_equalTo(25);
            make.width.mas_equalTo(62);
            make.height.mas_equalTo(21);

        }];
        
        self.btnPlay = [[UIButton alloc] init];
        [self.btnPlay setBackgroundImage:[UIImage imageNamed:@"course_play_btn"] forState:UIControlStateNormal];
        [self.btnPlay setBackgroundImage:[UIImage imageNamed:@"course_pause_btn"] forState:UIControlStateSelected];
        [self addSubview:self.btnPlay];
        [self.btnPlay mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.leading.top.mas_equalTo(0);
            make.width.height.mas_equalTo(67);
        }];
        
        
    
        _autoScrollLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(28, 6, 70.5f, 12.0f)];
    //    _autoScrollLabel.center = CGPointMake(kDeviceWidth * 0.5, 64);
        [y addSubview:_autoScrollLabel];
        self.autoScrollLabel.text = @"";
        self.autoScrollLabel.layer.masksToBounds = YES;
        self.autoScrollLabel.layer.cornerRadius = 4;
        self.autoScrollLabel.textColor = [UIColor whiteColor];
        self.autoScrollLabel.backgroundColor = [UIColor clearColor];
        self.autoScrollLabel.font = [UIFont systemFontOfSize:12];//字体大小
        self.autoScrollLabel.labelSpacing = 30; // 开始和结束标签之间的距离
        self.autoScrollLabel.pauseInterval = 0; // 一秒的停顿之后再开始滚动
        self.autoScrollLabel.scrollSpeed = 17; // 每秒像素
        self.autoScrollLabel.textAlignment = NSTextAlignmentCenter; // 不使用自动滚动时的中心文本
        self.autoScrollLabel.fadeLength = 12.f;
        self.autoScrollLabel.scrollDirection = CBAutoScrollDirectionLeft;
        [self.autoScrollLabel observeApplicationNotifications];
        // course_show
        
        
        WS(weakself);
        
        [self addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (!Ktoken) {
                [weakself gotoLoginV];
                               return;
                           }
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            //获取当前导航控制器
            UITabBarController  *tableBar = (UITabBarController *)app.window.rootViewController;
            UINavigationController *currentNav = tableBar.selectedViewController;
            UIViewController *currentController = currentNav.visibleViewController;
            for (UIViewController *controller in currentNav.viewControllers) {
                if ([controller isKindOfClass:[AudioDetailVC class]]) {
                    [currentController.navigationController popViewControllerAnimated:YES];
                    return;
                }
            }
//            AudioDetailVC *next = [[AudioDetailVC alloc] init];
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            del.audioDetailVC.model = weakself.model;
            del.audioDetailVC.playerRow = weakself.playerRow;

//                                next.model = weakself.model;
//                                next.playerRow = weakself.playerRow;
                                [currentController.navigationController pushViewController:del.audioDetailVC animated:YES];
//            if (![currentController isMemberOfClass:[CourseDetailVC class]]) {
//
//                BOOL isVC = false;
//                for (UIViewController *vc in currentNav.viewControllers) {
//
//                    if ([vc isMemberOfClass:[CourseDetailVC class]]) {
//
//                        isVC = YES;
//                        [currentController.navigationController popToViewController:vc animated:YES];
//                    }
//                }
//
//                if (!isVC) {
//
//                    CourseDetailVC *next = [[CourseDetailVC alloc] init];
//                    next.courseId = weakself.playerModel.cid;
//                    next.goodsType = weakself.PlayerType;
//
//                    [currentController.navigationController pushViewController:next animated:YES];
//                }
//            }
        }];
    }
    
    return self;
}
- (void)gotoLoginV {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取当前导航控制器
    UITabBarController  *tableBar = (UITabBarController *)app.window.rootViewController;
    UINavigationController *currentNav = tableBar.selectedViewController;
    BaseVC *bs = (BaseVC *)currentNav.visibleViewController;
    [bs loginAction];
    
}
- (NSData *)imgData {
    if (_imgData == nil) {
        NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"音屏动效1" ofType:nil];
         _imgData = [NSData dataWithContentsOfFile:filePath];
    }
    return _imgData;
}
@end


@implementation PlayerVideoView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.edgeMargin = 20;
//        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor yellowColor];
        self.btnClose = [[UIButton alloc] init];
        [self.btnClose setImage:[UIImage imageNamed:@"ic_videcloe"] forState:UIControlStateNormal];
        [self addSubview:self.btnClose];
        [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.trailing.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(24);
        }];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    self.beginPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    CGFloat offsetX = nowPoint.x - self.beginPoint.x;
    CGFloat offsetY = nowPoint.y - self.beginPoint.y;
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.dragEnable) {
        return;
    }
    CGRect rect = self.frame;
    CGFloat marginLeft = rect.origin.x;
    CGFloat marginTop = rect.origin.y;
    CGFloat marginRight = KeyWindow.frame.size.width - (rect.origin.x + rect.size.width);
    CGFloat marginButtom = KeyWindow.frame.size.height - (rect.origin.y + rect.size.height);
    BOOL needToAjust = NO;
    
    if (marginLeft < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.x = self.edgeMargin;
    }
    if (marginTop < self.edgeMargin+50) {
        needToAjust = YES;
        rect.origin.y = self.edgeMargin+50;
    }
    if (marginRight < self.edgeMargin) {
        needToAjust = YES;
        rect.origin.x = KeyWindow.frame.size.width - self.frame.size.width - self.edgeMargin;
    }
    if (marginButtom < self.edgeMargin+50) {
        needToAjust = YES;
        rect.origin.y = KeyWindow.frame.size.height - self.frame.size.height - self.edgeMargin-50;
    }
    if (needToAjust) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
        }];
    }
}

@end


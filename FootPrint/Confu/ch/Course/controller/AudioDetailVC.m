//
//  AudioDetailVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/3/19.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "AudioDetailVC.h"
#import "SilenceWebViewUtil.h"
#import "PLPlayerView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "CourseDetailVC.h"
#import<QuartzCore/QuartzCore.h>
@interface AudioDetailVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;
@property (nonatomic, strong) AppDelegate *app;
@property (nonatomic, assign) NSInteger speedIdx;
@property (nonatomic, strong) NSArray *speedAry;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
//@property (nonatomic, strong) PLPlayerView *playerView;

@end

@implementation AudioDetailVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.app.playerView.audioView.hidden = YES;
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//          self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//      }
    self.playBgView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.playBgView.layer.shadowColor = [UIColor colorWithHex:0xc8c8c8].CGColor;// 阴影的颜色
    self.playBgView.layer.shadowRadius = 5;// 阴影扩散的范围控制
    self.playBgView.layer.shadowOffset  = CGSizeMake(0, 0);// 阴影的范围
  //  2.加圆角，首先保证你的imageVIew是正方形的，要不然效果不是圆的
 //   self.userImage.layer.masksToBounds = YES;
  //  self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
 //   如果想要有点弧度的不是地球那么圆的可以设置self.userImage.layer.cornerRadius =5；这个值越大弧度越大
//    3.加边框
//    self.playBgView.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
//    self.playBgView.layer.borderWidth = 2;//边框宽度
    self.playBgView.layer.cornerRadius = 10.0;
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.baseScrollView.contentOffset = CGPointMake(0, 0);
    [self initUI];
    
    [self.bgImgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
//    self.enterBtn.hidden = YES;
//    self.enterBgView.hidden = YES;
    NSArray *arr = self.navigationController.viewControllers;
    if (arr.count >= 2) {
      UIViewController *c = arr[arr.count -2];
        if ([c isKindOfClass:[CourseDetailVC class]]) {
            self.enterBtn.hidden = NO;
            self.enterBgView.hidden = NO;
        }
    }
    [self judgeAudioPlayStatus:self.app.playerView.player.status];
    if (self.last_click_play) {
        self.last_click_play = NO;
        [self.app.playerView play];
    }

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//        self.app.playerView.audioView.autoScrollLabel.scrollSpeed = 30;

//       UIView *v = self.app.playerView.audioView.leftwardMarqueeView.items[0];
//       UILabel *lb = [v viewWithTag:1001];
//        lb.text  = self.playerModel.title;
               [self.app.playerView showPlayerInView:KeyWindow];
        self.app.playerView.audioView.autoScrollLabel.text = self.playerModel.title;
        self.app.playerView.audioView.model = self.model;
        self.app.playerView.audioView.playerRow = self.playerRow;
        [self.app.playerView.player setBackgroundPlayEnable:YES];
           }else{
               [self.app.playerView stop];
           }
    
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//           self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//       }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.title = @"音频课程";
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.csBannerStraint.constant = 0.0;
    self.bannerBgView.hidden = YES;
    [self.app.playerView.player setBackgroundPlayEnable:YES];
    [self.slider setThumbImage:[UIImage imageNamed:@"ic_roll"] forState:(UIControlStateNormal)];
    self.slider.minimumTrackTintColor = [UIColor colorWithHex:0x479298];


    /*
     self.slider.maximumTrackTintColor = [UIColor clearColor];
     self.slider.minimumTrackTintColor = [UIColor colorWithRed:.2 green:.2 blue:.8 alpha:1];
     */

    
    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:self.webView];
    self.webView.scrollView.scrollEnabled = YES;
//    self.bgScrollView.bounces = NO;
    self.webView.scrollView.bounces = NO;
//    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
   WS(weakself)
    [self.btnPlay addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.btnPlay.selected) {
            [weakself.app.playerView pause];
        } else {
            [weakself.app.playerView play];

        }
        
    }];
    self.bannerBgView.hidden = NO;

 
    self.enterBgView.backgroundColor = [UIColor colorWithHex:0xffffff andAlpha:0.5];
    self.enterBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.csBannerStraint.constant = (SCREEN_WIDTH * 14.0) / 25.0;

    self.enterBgView.layer.borderWidth = 1.0;
    self.slider.maximumTrackTintColor = RGB(238, 238, 238);
    self.slider.minimumTrackTintColor = RGB(3, 153, 254);
    self.slider.minimumValue = 0;
    self.slider.continuous = NO;
    [self.slider addTarget:self action:@selector(sliderValueChange) forControlEvents:(UIControlEventValueChanged)];
   
        
    // self.app.playerView.player.status
   
    
//    self.playerView = [[PLPlayerView  alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
////    self.playerView.delegate = self;
//    PLMediaInfo *p = [[PLMediaInfo alloc] init];
//    p.videoURL = @"https://20200901164030.grazy.cn/oa_0ec879b7aea9e60ee22d36c0411a3d2f.mp3";
//    self.playerView.model = self.model;
//    self.playerView.playerModel = self.playerModel;
 self.fd_interactivePopDisabled = YES;

//    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
//    self.panGesture.di
//    self.panGesture.delegate = self;
//    [self.view addGestureRecognizer:self.panGesture];

    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
        right.direction=UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:right];

   

    
}
- (void)panGesture:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"滑动");
    
}
-(void)handleSwipes:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"向左边滑动了!!!!!!");
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"向右边滑动了!!!!!!");
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"向上边滑动了!!!!!!");
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"向下边滑动了!!!!!!");
    }
 
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{// 注意：只有非根控制器才有滑动返回功能，根控制器没有。// 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
//    if (self.childViewControllers.count == 1) {// 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//
//    }
    return NO;
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if (gestureRecognizer == self.panGesture) {
//        CGPoint point = [touch locationInView:self];
//        return !CGRectContainsPoint(self.bottomBarView.frame, point);
//    }
    return NO;
}


//滑块事件
- (void)sliderValueChange{
    NSLog(@"current:%f",self.slider.value);
//    self.app.playerView.player.currentTime = CMTimeMake(s
    [self.app.playerView.player seekTo:CMTimeMake(self.slider.value * 1000, 1000)];
    //placeholder_method_call//

    int duration = self.slider.value;
           int hour = duration / 3600;
           int min  = (duration % 3600) / 60;
           int sec  = duration % 60;
           
    self.lblPlayTime.text = [NSString stringWithFormat:@"%d:%02d:%02d", hour, min, sec];
    
    
    
    
    
}

- (void)judgeAudioPlayStatus:(PLPlayerStatus)status{
    
    if (status == PLPlayerStatusPlaying) { //正在播放
        
        self.btnPlay.selected = YES;
        
    }else{
        
        self.btnPlay.selected = NO;
        
        if (status == PLPlayerStatusCompleted) {
            
            [self nextPlayerModel:YES];
        }
    }
}
//下一曲
- (void)nextPlayerModel:(BOOL)play{
    NSLog(@"状态 %d",self.btnPlay.selected);

    if (![CoreStatus isNetworkEnable]) {
        //placeholder_method_call//

        return;
    }
    if (self.model.chapter_audio.count == 0) {
        
        return;
    }
    
    self.playerRow ++;
    if (self.playerRow >= self.model.chapter_audio.count) {
        [KeyWindow showTip:@"已经到第一章啦"];
        self.playerRow = 0;
    }
    
    //    是否是vip 1:是0:不是
    if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
        
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 0) { //未购买
            //placeholder_method_call//

            if ([self.model.price floatValue] <= 0) { //免费 需要报名
                
                if ([self.model.chapter_audio[self.playerRow].free integerValue] == 0) { //不是试看
                    
                    self.playerRow ++;
                    if (self.playerRow >= self.model.chapter_audio.count) {
                        
                        self.playerRow = 0;
                    }
                    [KeyWindow showTip:@"该课程需要报名，请先报名"];
                    return ;
                }
            }else{
                
                if ([self.model.chapter_audio[self.playerRow].free integerValue] == 0) { //不是试看
                    
                    self.playerRow ++;
                    if (self.playerRow >= self.model.chapter_audio.count) {
                        
                        self.playerRow = 0;
                    }
                    [KeyWindow showTip:@"该课程需要付费，请先购买"];
                    return ;
                }
            }
        }
    }
    
    if (play) {
        [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:YES];

    } else {
        [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:NO];

    }
}
//- (void)loadData{
   
//placeholder_method_call//
    
 
//    WS(weakself)
//    [APPRequest GET:@"/audioDetail" parameters:@{@"cid":self.playerModel.cid,@"id":self.playerModel.id} finished:^(AjaxResult *result) {
//
//        if (result.code == AjaxResultStateSuccess) {
//
//          weakself.playerNewModel =  [CoursePlayerFootModel mj_objectWithKeyValues:result.data];
//            [self updateUI];
//
//        }
//    }];
//}
- (NSArray *)speedAry{
    
    if (_speedAry == nil) {
        
        _speedAry = @[@1.0,@1.25,@1.5,@0.5,@0.75];
    }
    
    return _speedAry;
}


- (void)initUI {
    self.playerModel = self.model.chapter_audio[self.playerRow];
    self.lbVideoTitle.text = self.playerModel.title;
    self.webView.scrollView.scrollEnabled = NO;
        self.navigationItem.title = self.model.title;
    self.slider.value = 0.0;
    self.nameLabel.text = self.playerModel.title;

        WS(weakself)
        if (self.playerModel.desc.length > 0) {
            
//         NSString *contentUrl = [NSString stringWithFormat:@"<html> \n"
//                                             "<head> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
//                                             "<style type=\"text/css\"> \n"
//                                             "body {font-size:14px;}\n"
//                                             "span{line-height:20px;}\n"
//                                             "p{line-height:20px;}\n"
//                                              "textarea{line-height:20px;}\n"
//                                             "</style> \n"
//                                             "</head> \n"
//                                             "<body>"
//                                             "<script type='text/javascript'>"
//                                             "window.onload = function(){\n"
//                                             "var $img = document.getElementsByTagName('img');\n"
//                                             "for(var p in  $img){\n"
//                                             " $img[p].style.width = '100%%';\n"
//                                             "$img[p].style.height ='auto'\n"
//                                             "}\n"
//                                             "}"
//                                             "</script>%@"
//                                             "<br/><br/><br/><br/>"
//                                             "</body>"
//                                             "</html>", self.playerModel.desc];
            NSString *contentUrl = [NSString stringWithFormat:@"<html> \n"
                       "<head> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0,user-scalable=0\"> \n"
                       "<style type=\"text/css\"> \n"
                       "p{line-height:30px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "<br/><br/>"
                       "</body>"
                       "</html>", self.playerModel.desc];
            
            
            
            [self.webViewUtil setContent:contentUrl heightBlock:^(CGFloat h) {
                weakself.csWebHeight.constant = h + 12;
            }];
        } else {
            weakself.csWebHeight.constant = 10;

            [self.webViewUtil setContent:@"" heightBlock:^(CGFloat h) {
                weakself.csWebHeight.constant = h + 12;
            }];
        }
    
    self.slider.maximumValue = self.playerModel.duration;
    self.slider.minimumValue = 0;

    self.lblDuraTime.text = self.playerModel.lenght;
    self.lblPlayTime.text = @"00:00:00";
    
    self.lblSpeed.text = @"1x";
    self.app.playerView.playerRow = self.playerRow;
    
    self.app.playerView.playerModel = self.playerModel;
    
    self.app.playerView.PlayerType = 2;
    
    self.app.playerView.BlockTimerClick = ^(NSString *time, CGFloat progress) {
        NSLog(@"%f",progress);
        weakself.lblPlayTime.text = time;
        weakself.slider.value = progress;
    };
    self.app.playerView.audioView.autoScrollLabel.text = self.playerModel.title;
    self.app.playerView.audioView.playerRow = self.playerRow;
//    self.app.playerView.audioView.model = self.model;   
    
    self.app.playerView.BlockViewPlayerStatus = ^(PLPlayerStatus status) {
        
            [weakself judgeAudioPlayStatus:status];
        
    };

    
    
}
//上一曲
- (void)lastPlayerModel:(BOOL) play{
    
    if (![CoreStatus isNetworkEnable]) {
        //placeholder_method_call//

        return;
    }
    if (self.model.chapter_audio.count == 0) {
        
        return;
    }
    self.playerRow --;
    if (self.playerRow < 0) {
        [KeyWindow showTip:@"已经到最后一章啦"];
        self.playerRow = self.model.chapter_audio.count-1;
    }
    
    //    是否是vip 1:是0:不是
    if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
        
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 0) { //未购买
            
            if ([self.model.price floatValue] <= 0) { //免费 需要报名
                
                if ([self.model.chapter_audio[self.playerRow].free integerValue] == 0) { //不是试看
                    
                    self.playerRow ++;
                    if (self.playerRow >= self.model.chapter_audio.count) {
                        
                        self.playerRow = 0;
                    }
                    [KeyWindow showTip:@"该课程需要报名，请先报名"];
                    return ;
                }
            }else{
                
                if ([self.model.chapter_audio[self.playerRow].free integerValue] == 0) { //不是试看
                    
                    self.playerRow ++;
                    if (self.playerRow >= self.model.chapter_audio.count) {
                        
                        self.playerRow = 0;
                    }
                    [KeyWindow showTip:@"该课程需要付费，请先购买"];
                    return ;
                }
            }
        }
    }
  
    if (play) {
        [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:YES];

    } else {
        [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:NO];

    }
}

- (void)setPlayModel:(CoursePlayerFootModel *)playerModel isPlay:(BOOL)play{
    self.baseScrollView.contentOffset = CGPointMake(0, 0);
    [self initUI];
    if (self.BlockSwitchAdudioClick) {
        self.BlockSwitchAdudioClick(playerModel,self.playerRow);
    }
    
   
    if (play) {
        [self.app.playerView play];
    }
    
    
}
- (IBAction)enterAction:(UIButton *)sender {
    NSArray *arr = self.navigationController.viewControllers;
    if (arr.count >= 2) {
      UIViewController *c = arr[arr.count -2];
        if ([c isKindOfClass:[CourseDetailVC class]]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    // cud
    
    
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = 2;
    next.courseId = self.playerModel.cid;
    next.is_buy = self.is_buy;
    [self.navigationController pushViewController:next animated:YES];
     
    
    
    
}

//下一曲 点击事件
- (IBAction)btnNextClick:(id)sender {
    
    [self nextPlayerModel:self.btnPlay.selected];
    

}
//上一曲  点击事件
- (IBAction)btnLastClick:(id)sender {
    

    [self lastPlayerModel:self.btnPlay.selected];
}
//倍速播放
- (IBAction)btnSpeedClick:(id)sender {
    
    if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
        //placeholder_method_call//

        self.speedIdx ++;
        if (self.speedIdx >= self.speedAry.count) {
            
            self.speedIdx = 0;
        }
        [self.app.playerView.player setPlaySpeed:[self.speedAry[self.speedIdx] floatValue]];
        self.lblSpeed.text = [NSString stringWithFormat:@"%@x",self.speedAry[self.speedIdx]];
    }
}
@end

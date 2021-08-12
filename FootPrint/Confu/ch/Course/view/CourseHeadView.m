//
//  CourseHeadView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseHeadView.h"
#import "PLPlayerView.h"
#import "UIImage+GIF.h"
#import "UILabel+Attribute.h"
#import "GroupJoinCell.h"
#import "TogetcherVC.h"
#import "UIView+ViewController.h"
@interface CourseHeadView ()<PLPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AppDelegate *app;

@property (nonatomic, strong) NSArray *speedAry;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, assign) NSInteger speedIdx;

@property (nonatomic, strong) UIImage *gifImg;

@property (nonatomic, assign) NSInteger playerRow;

@property (nonatomic, assign) NSInteger playerSection;

@property (nonatomic, assign) BOOL smallEnterFull;


@end

@implementation CourseHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    WS(weakself)
    self.csJoinListBgView.constant = 0.0;
    [self.topImgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            //
        
        }];
    // [UIFont fontWithName:@"Helvetica" size: 14]
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"选择课程"attributes: @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName: [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0]}];
//
//    self.label1.attributedText = string;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 40, 16) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
    _vipTipLabel.layer.mask = shapeLayer2;
    
    self.cardButton.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x6BB6D1).CGColor, (__bridge id)UIColorFromRGB(0x8882CC).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 49);
    [self.cardButton.layer addSublayer:gradientLayer];
}
- (void)goingToTogetcher {
    if (self.BlokGroupDetailClick) {
        self.BlokGroupDetailClick();
    }
  
}
#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

//进入全屏
- (void)playerViewEnterFullScreen:(PLPlayerView *)playerView {
    //placeholder_method_call//
//
//    [[UIApplication sharedApplication] setValue:@(YES) forKey:@"statusBarHidden"];
//    [playerView removeFromSuperview];
//
//    playerView.dragEnable = NO;
//    playerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [KeyWindow addSubview:playerView];
    if ([playerView.superview isKindOfClass:[PlayerVideoView class]]) {
        UIView *v = playerView.superview;
        self.smallEnterFull = YES;
        v.hidden = YES;
    }
    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    [playerView removeFromSuperview];
    [superView addSubview:playerView];
    [playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(superView.mas_height);
        make.height.equalTo(superView.mas_width);
        make.center.equalTo(superView);
    }];
    
    
    [superView setNeedsUpdateConstraints];
    [superView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [superView layoutIfNeeded];
    }];
    
//    [self.delegate tableViewCellEnterFullScreen:self];
}

//退出全屏
- (void)playerViewExitFullScreen:(PLPlayerView *)playerView {
    
//    [[UIApplication sharedApplication] setValue:@(NO) forKey:@"statusBarHidden"];
    //placeholder_method_call//
    
    
    [playerView removeFromSuperview];
    if (self.smallEnterFull == YES) {
        self.smallEnterFull = NO;
        [self.app.playerView.videoView addSubview:playerView];
        self.app.playerView.videoView.hidden = NO;
        [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.trailing.mas_equalTo(-12);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(self.app.playerView.videoView.height);
        }];
        
    } else {
        
        [self.headTopBgView insertSubview:playerView belowSubview:self.topImgView];
        
        [playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.headTopBgView);
        }];
        
    }
    
  
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

//    if (playerView.isWindowsView) {
//
//        [playerView showPlayerInView:KeyWindow];
//    }else{
//
//        [playerView removeFromSuperview];
//        [self.headTopBgView addSubview:playerView];
//
//        [playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.headTopBgView);
//        }];
//
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
//
//
//
////        [playerView showPlayerInView:self];
//    }
//    [self.delegate tableViewCellExitFullScreen:self];
}

- (void)playerViewWillPlay:(PLPlayerView *)playerView {
    
    [self.delegate tableViewWillPlay:self];
}

#pragma mark - 事件

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

//下一曲 点击事件
- (IBAction)btnNextClick:(id)sender {
    
    [self nextPlayerModel];
    //placeholder_method_call//

}
//placeholder_method_impl//

//上一曲  点击事件
- (IBAction)btnLastClick:(id)sender {
    //placeholder_method_call//

    [self lastPlayerModel];
}

#pragma mark - 公开方法
//placeholder_method_impl//

//上一曲
- (void)lastPlayerModel{
    
    if (![CoreStatus isNetworkEnable]) {
        //placeholder_method_call//

        return;
    }
    if (self.model.chapter_audio.count == 0) {
        
        return;
    }
    self.playerRow --;
    if (self.playerRow < 0) {
        
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
    
    [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:YES];
}
//placeholder_method_impl//

//下一曲
- (void)nextPlayerModel{
    
    if (![CoreStatus isNetworkEnable]) {
        //placeholder_method_call//

        return;
    }
    if (self.model.chapter_audio.count == 0) {
        
        return;
    }
    
    self.playerRow ++;
    if (self.playerRow >= self.model.chapter_audio.count) {
        
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
    
    [self setPlayModel:self.model.chapter_audio[self.playerRow] isPlay:YES];
}
//placeholder_method_impl//

//添加播放视图
- (void)addPlayerView{
    
    WS(weakself);
    if (self.PlayerType == 1) {
        self.app.playerView.delegate = self;

    }
        //placeholder_method_call//

        self.app.playerView.BlockTimerClick = ^(NSString *time, CGFloat progress) {
            NSLog(@"%f",progress);
            weakself.lblPlayTime.text = time;
            weakself.slider.value = progress;
        };
    if (self.PlayerType == 1) {
        self.app.playerView.BlockViewPlayerStatus = ^(PLPlayerStatus status) {
            
            if (self.PlayerType == 1) { //视频
                
                [weakself judgeVideoPlayStatus:status];
            }else{
                
//                [weakself judgeAudioPlayStatus:status];
            }
        };
    }
      
           
    if (self.PlayerType == 1) {
//        [self.headTopBgView insertSubview:self.app.playerView belowSubview:self.topImgView];
//        [self.app.playerView.videoView removeFromSuperview];
//        [self.app.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.headTopBgView);
//        }];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        
        
        [self.app.playerView showPlayerInView:self];
    }
    else {
      
    }

    
    
  

    
}

#pragma mark - 私有方法
//placeholder_method_impl//

#pragma mark - get set

- (void)setModel:(CourseDetailModel *)model{
    
    _model = model;
    
    self.lblTitle.text = model.title;
    self.lblContent.text = model.desc;
    //placeholder_method_call//

    self.lblPrice.text = [model.price ChangePrice];
    self.lblNum.text = [NSString stringWithFormat:@"已有%ld人在学",[model.virtual_amount integerValue] + [model.study_count integerValue]];
    [self.btnConment setTitle:[NSString stringWithFormat:@"  %@",model.comment_total] forState:UIControlStateNormal];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@", HOST_IMG,self.model.banner]);
    self.messageCountLabel.text = model.comment_total;
    
   // https://vipdz.geziketang.com/public/uploads/image/course/20210318/695d6dac43f3abbf342ea1cf4fc831dd.png
    
    if (self.PlayerType == 1) {
        self.app.playerView.defaultImg = model.banner;
        self.app.playerView.hidden = YES;
        self.topImgView.hidden = NO;
        self.playBtn.hidden = NO;
        [self.topImgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    } else {
        self.topImgView.hidden = NO;
        [self.topImgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    }
    
    
    self.btnDownLoad.hidden = NO;
    if ([self.model.download integerValue] == 0) { //不允许下载
        
        self.btnDownLoad.hidden = YES;
    }
    
    if (self.model.is_open == 1) {
        self.incomeShowView.hidden = NO;
        self.precetageLabel.text = [NSString stringWithFormat:@"%ld%%",self.model.goods_ratio];
    }
    if (model.is_discount == 1) {
        NSString *yh_price = [model.yh_price ChangePrice];
        self.lblPrice.text = [NSString stringWithFormat:@"优惠中 %@",yh_price];
    }
    if (model.is_group == 1) {
            NSString *yh_price = [model.group.spell_price ChangePrice];
            self.lblPrice.text = [NSString stringWithFormat:@"拼团价 %@",yh_price];
    }
    if ([self.model.checkbuy integerValue] == 1) {
        self.csPeopleBgView.constant = 0.0;
        self.peopleBgView.hidden = YES;
        self.csLineHeight.constant = 0.0;
        self.inviteBtn.hidden = YES;
        self.csInviteBtn.constant = 0.0;
        self.purchaseShowBgView.hidden = YES;
        self.csPurchaseShowBg.constant = 0;
        self.lastTimeLabel.hidden = YES;
        self.csLastTimeBgView.constant = 0;
        self.joinListBgView.hidden = YES;
        self.csJoinListBgView.constant = 0.0;
        return;
    }
    
    
    
    
    
    
    
    
    //            限时优惠                  拼团
    if (model.is_discount == 1  || model.is_group == 1) {
        self.csLineHeight.constant = 1.0;
        NSString *price = [model.price ChangePrice];
        NSMutableAttributedString*newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",price]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.originPriceLabel.attributedText= newPrice;
        self.lastTimeLabel.hidden = NO;
        self.csLastTimeBgView.constant = 37.0;
       
        [self startTime];

       
           
        if (model.is_group == 1) {
            NSArray<GroupUserModel *> *group_user = model.group.join_group_user.group_user;
            self.peopleBgView.hidden = NO;
            self.csPeopleBgView.constant = 83.0;
            self.currentPeopleLabel.text = [NSString stringWithFormat:@"目前%lu人",(unsigned long)group_user.count];
            self.totalPeopleLabel.text = [NSString stringWithFormat:@"%lu人成团",(unsigned long)model.group.spell_num];

            int count = (int)model.group.spell_num;
            if (count > 5) {
                count = 5;
            }
//            if (self.model.group.join_group_status == YES) { // 自己加入了拼团
                for (int i = 0; i < count; i ++) {
                    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(25 + 48.0 *i, 25.0, 38.0, 38.0)];
                    imgV.layer.cornerRadius = 19.0;
                    imgV.layer.masksToBounds = YES;
                    [self.peopleBgView addSubview:imgV];
                    WS(weakself)
                    imgV.userInteractionEnabled = YES;
                    [imgV addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                        if (weakself.model.group.join_group_status == YES) {
                            [weakself goingToTogetcher];
                        }
                       

                    }];
                    if (i == count - 1 && model.group.spell_num > 5) {
                      
                        //course_last_icon
                        imgV.image = [UIImage imageNamed:@"course_last_icon"];
                       
                    } else {
                        //
                        if (group_user.count > i) {
                            [imgV sd_setImageWithURL:[NSURL URLWithString:group_user[i].face] placeholderImage:[UIImage imageNamed:@"course_face_icon"]];
                        } else {
                            imgV.image = [UIImage imageNamed:@"course_icon_img"];
                        }

                    }
                    
                    
                }
//            }
           
            
            if (self.model.grouping.count > 0  && self.model.group.join_group_status == NO) {
                self.joinTableView.delegate = self;
                self.joinTableView.dataSource = self;
                self.joinTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                [self.joinTableView registerNib:[UINib nibWithNibName:@"GroupJoinCell" bundle:nil] forCellReuseIdentifier:@"GroupJoinCell"];
                
            }
            
            self.purchaseShowBgView.hidden = NO;
            self.csPurchaseShowBg.constant = 76.0;
            
            // 已经发起参团了
            if (self.model.group.join_group_status == YES) { // 我发起团了
                self.csJoinListBgView.constant = 0.0;
                self.inviteBtn.hidden = NO;
                self.csInviteBtn.constant = 38.0;
               
            } else {
                self.joinListBgView.hidden = NO;
                self.csJoinListBgView.constant = self.model.grouping.count * 58.0 + 48.0;

            }
        
            
        }
        }
    
    if ([_model.is_discount_vip intValue]) {
        NSString *vip_priceStr;
        CGFloat vip_price = _model.vip_price.floatValue;
        if (vip_price == 0) {
            vip_priceStr = @"免费";
        }else if (vip_price > 0) {
            vip_priceStr = [NSString stringWithFormat:@"¥%.2f",vip_price];
        }
        self.vipPriceLabel.text = vip_priceStr;
        
        CGFloat width1 = [vip_priceStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 11) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.width;
        self.vipBgWifht.constant = 48+width1;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 48+width1, 16) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
        _vipBgview.layer.mask = shapeLayer;//8
        _vipBgview.hidden = NO;
    }else{
        _vipBgview.hidden = YES;
    }
        
}

- (void)startTime {
    int currentTime = (int) [[NSDate date]timeIntervalSince1970];
    int end_time = 0;
    if (self.model.is_discount == 1) {
        end_time = self.model.end_time;
    } else {
        end_time = self.model.group.end_time;
    }
    int  diff =  end_time - currentTime;
    if (diff <= 0) {
        self.lastTimeLabel.text = @"活动结束";

        return;
    }
    
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }

//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    
    // 如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    //     self.statusLabel.text = [NSString stringWithFormat:@"优惠价 %@",courseModel.yh_price];

    
    
}

- (void)refreshLessTime {
    // SaleSuperCell
    
    
//    self.courseModel.end_time;
//    self.courseModel.end_time
   int currentTime = (int) [[NSDate date]timeIntervalSince1970];
    int end_time = 0;
    if (self.model.is_discount == 1) {
        end_time = self.model.end_time;
    } else {
        end_time = self.model.group.end_time;
    }
 int  diff =  end_time - currentTime;
    if (diff > 0) {
       NSString *st = [self lessSecondToDay:diff];
        self.lastTimeLabel.text = st;
        self.lastTimeLabel.textColor = [UIColor colorWithHex:0x479298];
        [self.lastTimeLabel addAttrbuteColorWithAttributeText:@[@"活动结束还剩",@"时",@"分",@"秒"] withAttrArrayColor:@[[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2]]];
        self.lastTimeLabel.text = st;
     } else {
         self.lastTimeLabel.text = @"活动结束";

    }
    
    
    
    
    
    
    
}

- (NSString *)lessSecondToDay:(long)seconds
{
    if (seconds <= 0) {
        return @"活动结束";
    }
    
    NSUInteger day  = (NSUInteger)seconds/(24*3600);
    NSInteger hour = (NSInteger)(seconds/(3600));
    NSInteger min  = (NSInteger)(seconds%(3600))/60;
    NSInteger second = (NSInteger)(seconds%60);
    
    NSString *time = [NSString stringWithFormat:@"活动结束还剩  %lu 时 %lu 分  %lu 秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
    return time;
    
}



//placeholder_method_impl//

- (void)setPlayModel:(CoursePlayerFootModel *)playerModel isPlay:(BOOL)play{
    
    self.slider.maximumValue = playerModel.duration;
    self.slider.minimumValue = 0;
    //placeholder_method_call//

//    CGFloat fduration = [playerModel.lenght floatValue];
//    int duration = fduration + .5;
//    int hour = duration / 3600;
//    int min  = (duration % 3600) / 60;
//    int sec  = duration % 60;
    
//    self.lblDuraTime.text = [NSString stringWithFormat:@"%d:%02d:%02d", hour, min, sec];;
    self.lblDuraTime.text = playerModel.lenght;
    self.lblPlayTime.text = @"00:00:00";
    
    self.lblSpeed.text = @"1x";
    
    self.lblAudioTitle.text = playerModel.title;
    self.imgMp3.hidden = NO;
    
//    if ([CoreStatus isNetworkEnable]) {
    
        if (self.PlayerType == 2) { //音频
            
//            if (self.model.chapter_audio.count == 0) {
//
//                self.app.playerView.isPlayUrlNil = YES;
//                //            self.csSliderCenter.constant = -20;
//                self.csAudioViewHeight.constant = 130;
//                self.lblAudioTitle.hidden = YES;
//                self.imgMp3.hidden = YES;
//            }
            if (self.BlockSwitchAdudioClick) {
                self.BlockSwitchAdudioClick(playerModel,self.playerRow);
            }
        }else{
            
            if (self.BlockSwitchVideoClick) {
                self.BlockSwitchVideoClick(playerModel,self.playerSection,self.playerRow);
            }
        }
//    }
    if (self.PlayerType == 1) {
        self.playerModel = playerModel;
        
//        self.app.playerView.playerModel = playerModel;
//        self.app.playerView.PlayerType = self.PlayerType;
//        if (play) {
//            
//            [self.app.playerView play];
//        }
    }
    
  
    //placeholder_method_call//
    /*
     if (weakself.model.is_group == 1) { // 开团和参团
         
         weakself.model.coursePurchaseType = 2;
         // 已经发起参团了
         if (weakself.model.group.join_group_status == YES) { // 发起团了
     */
   

   
}
- (void)beginPlayVideo {
    self.topImgView.hidden = YES;
    self.playBtn.hidden = YES;
    self.playBgView.hidden = YES;
    self.app.playerView.hidden = NO;
    self.app.playerView.model = self.model;
        self.app.playerView.playerModel = self.playerModel;
            self.app.playerView.PlayerType = self.PlayerType;

    
                [self.app.playerView play];

    
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)setPlayerType:(NSInteger)PlayerType{
    
    _PlayerType = PlayerType;
    //placeholder_method_call//

    //     1视频 2音频
    if (PlayerType == 1) {
        
        self.csAudioViewHeight.constant = 0;
        self.viewAudio.hidden = YES;
    }else{
        
//        self.csAudioViewHeight.constant = 0;
//        self.viewAudio.hidden = NO;
//
//        self.slider.continuous = NO;
//        [self.slider setThumbImage:[UIImage imageNamed:@"ic_slider"] forState:(UIControlStateNormal)];
//        self.slider.maximumTrackTintColor = RGB(238, 238, 238);
//        self.slider.minimumTrackTintColor = RGB(3, 153, 254);
//        self.slider.minimumValue = 0;
//        [self.slider addTarget:self action:@selector(sliderValueChange) forControlEvents:(UIControlEventValueChanged)];
//        //placeholder_method_call//
//
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"ic_audio" ofType:@"gif"];
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        self.gifImg = [UIImage sd_animatedGIFWithData:data];
//        WS(weakself)
//        [self.btnPlay addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
////            if (!Ktoken) {
////                weakself
////            }
//
//            [self.app.playerView play];
//        }];
//
//        [self judgeAudioPlayStatus:self.app.playerView.player.status];
    }
}

- (void)setPlayerSection:(NSInteger)section PlayerRow:(NSInteger)row{
    
    _playerSection = section;
    _playerRow = row;
}

- (void)judgeAudioPlayStatus:(PLPlayerStatus)status{
    
    if (status == PLPlayerStatusPlaying) { //正在播放
        
        self.btnPlay.selected = YES;
        self.imgMp3.image = self.gifImg;
    }else{
        
        self.btnPlay.selected = NO;
        self.imgMp3.image = [UIImage imageNamed:@"ic_mp3"];
        
        if (status == PLPlayerStatusCompleted) {
            
            [self nextPlayerModel];
        }
    }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)judgeVideoPlayStatus:(PLPlayerStatus)status{
    
    if (![CoreStatus isNetworkEnable]) {
        
        return;
    }
    if (status == PLPlayerStatusCompleted) {
        
        if (self.model.chapter_video.count == 0) {
            
            return;
        }
//        if ((self.playerSection + 1) >= self.model.chapter_video.count) {
//            return;
//        }
        if ((self.playerSection == (self.model.chapter_video.count -1)) && (self.playerRow == (self.model.chapter_video[self.playerSection].video_list.count -1))) {
            return;
        }
        
        self.playerRow ++;
        
        if (self.playerRow >= self.model.chapter_video[self.playerSection].video_list.count) {

            self.playerSection ++;
            self.playerRow = 0;
        }

        if (self.playerSection >= self.model.chapter_video.count) {

            self.playerSection = 0;
            self.playerRow = 0;
        }

        if (self.model.chapter_video[self.playerSection].video_list.count == 0) {

            self.playerSection ++;
            self.playerRow = -1;
            [self judgeVideoPlayStatus:status];
            
            return;
        }
        
        //    是否是vip 1:是0:不是
        if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
            
            //    是否购买,如果是VIP默认购买状态
            if ([self.model.checkbuy integerValue] == 0) { //未购买
                
                if ([self.model.price floatValue] <= 0) { //免费 需要报名
                    
                    if ([self.model.chapter_video[self.playerSection].video_list[self.playerRow].free integerValue] == 0) { //不是试看
                        
                        self.playerRow --;
                        if (self.playerRow < 0) {
                            
                            self.playerSection --;
                            self.playerRow = self.model.chapter_video[self.playerSection].video_list.count-1;
                        }
                        [KeyWindow showTip:@"该课程需要报名，请先报名"];
                        return ;
                    }
                }else{
                    
                    if ([self.model.chapter_video[self.playerSection].video_list[self.playerRow].free integerValue] == 0) { //不是试看
                        
                        self.playerRow --;
                        if (self.playerRow < 0) {
                            
                            self.playerSection --;
                            self.playerRow = self.model.chapter_video[self.playerSection].video_list.count-1;
                        }
                        [KeyWindow showTip:@"该课程需要付费，请先购买"];
                        return ;
                    }
                }
            }
        }
        
        //是课程就播放 直播就跳过
        if ([self.model.chapter_video[self.playerSection].video_list[self.playerRow].live_state integerValue] == 0) {
            
            [self setPlayModel:self.model.chapter_video[self.playerSection].video_list[self.playerRow] isPlay:YES];
            [self beginPlayVideo];
            
        }else{
            
            [self judgeVideoPlayStatus:status];
        }
    }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (NSArray *)speedAry{
    
    if (_speedAry == nil) {
        
        _speedAry = @[@1.0,@1.25,@1.5,@0.5,@0.75];
    }
    
    return _speedAry;
}



#pragma mark - uitableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.grouping.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupJoinCell"];
    cell.model =self.model.grouping[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WS(weakself)
    cell.BlockJoinClick = ^(GroupingModel * _Nonnull model) {
        if (weakself.BlockJoinClick) {
            weakself.BlockJoinClick(model);
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}

- (IBAction)goingToDetail:(UIButton *)sender {
    if (self.model.group.join_group_status == YES) {
        [self goingToTogetcher];
    }
}
@end

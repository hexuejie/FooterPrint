//
//  CourseDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseDetailVC.h"
#import "CourseIntroduceVC.h"
#import "AdudioListVC.h"
#import "VideoListVC.h"
#import "CourseHeadView.h"
#import "CourseFootView.h"
#import "CourseDetailModel.h"
#import "CommentsVC.h"
#import "AppDelegate.h"
#import "BuyVipVC.h"
#import "AddOrderVC.h"
#import "PlayerFootModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "WMStickyPageController.h"
#import "SelectCacheAudioVC.h"
#import "SelectCacheVideoVC.h"
#import "ShareFootModel.h"
#import "SilenceShareUtil.h"
#import "OpenShare.h"
#import "YCDownloadManager.h"
#import "AudioDetailVC.h"
#import "ShareShowView.h"
#import "TogetcherVC.h"
#import "UILabel+Attribute.h"
#import "TogetcherModel.h"
@interface CourseDetailVC ()<CourseHeadViewCellDelegate,WMPageControllerDelegate,WMPageControllerDataSource>

@property (strong, nonatomic) NSMutableArray *titleAry;

@property (strong, nonatomic) NSMutableArray<UIViewController *> *views;

@property (nonatomic, strong) CourseFootView *footView;

@property (nonatomic, strong) CourseHeadView *headView;

@property (nonatomic, strong) ShareShowView *shareShowView;


@property (nonatomic, strong) CourseIntroduceVC *IntroduceVC;

@property (nonatomic, strong) VideoListVC *videoListVC;

@property (nonatomic, strong) AdudioListVC *adudioListVC;

@property (nonatomic, strong) CourseDetailModel *model;

@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, assign) BOOL isClosePlayerView;

@property (nonatomic, strong) CoursePlayerFootModel *playerModel;

@property (nonatomic, assign) NSInteger playerRow;

@property (nonatomic, assign) NSInteger playerSection;

@property (nonatomic, strong) AppDelegate *app;

@property (nonatomic, assign) CGFloat scrollViewOffset;

@property (nonatomic, strong) WMStickyPageController *pageController;

@end

@implementation CourseDetailVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
- (void)loadView {
    [super loadView];
  
    
    
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.app.playerView.timelong > 0) {
      [self.app.playerView studyUpdate:YES];
      }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.isFullScreen = YES;
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];

    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 50;
    
    self.title = @"课程详情";
    self.view.backgroundColor = kColor_BG;
    //placeholder_method_call//
    
    //顶部导航栏右侧按钮
    WS(weakself)
    UIBarButtonItem *rightBarBtn = [UIFactory barBtnMakeWithImage:[UIImage imageNamed:@"course_share"] event:^{
        
        [weakself showShareViews:weakself.goodsType shareId:weakself.model.cid shareImgUrl:weakself.model.banner shareTitle:weakself.model.title Success:^(OSMessage *message) {
            
            NSLog(@"");
        } Fail:^(OSMessage *message, NSError *error) {
            
            NSLog(@"");
        }];
    }];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.clipsToBounds = YES;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-50);
        make.width.mas_equalTo(self.view);
    }];
    
    [contentView addSubview:self.pageController.view];
    
   
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    float safeArea = 0;
    if (@available(iOS 11.0, *)) {
        safeArea  =  mainWindow.safeAreaInsets.bottom;
    }

    [self.view addSubview:self.footView];
    
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50 + safeArea);
    }];
    self.view.clipsToBounds = YES;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    [self.view addSubview:v];
       v.backgroundColor = [UIColor whiteColor];

    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.leading.trailing.mas_equalTo(self.view).offset(50);
              make.height.mas_equalTo(50+KSafeAreaHeight);
    }];
    
    
    
    
    self.pageController.BlockScrollViewClick = ^(UIScrollView * _Nonnull scrollView) {
        
        weakself.scrollViewOffset = scrollView.contentOffset.y;
        
        CGFloat height = 0;
         

        if (self.app.playerView.PlayerType == 1) { //视频
            
            height = SCREEN_WIDTH*14/25;
        }else{
            
            height = SCREEN_WIDTH*14/25;
        }
        
        if (weakself.isClosePlayerView) {
            
            if (scrollView.contentOffset.y < height) {
                
                weakself.isClosePlayerView = NO;
            }
            
            return ;
        }
        
        if (scrollView.contentOffset.y > height) {
            if (self.goodsType == 1) { //视频
                if (!weakself.app.playerView.isWindowsView) {
                    
                    if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//                        weakself.app.allowRotation = NO;
                        // 小屏播放
                        [weakself.app.playerView showPlayerInView:KeyWindow];
                    }
                }
            }
        }else if (scrollView.contentOffset.y < height){
            if (self.goodsType == 1) { //视频
                
                if (weakself.app.playerView.isWindowsView) {
//                    weakself.app.allowRotation = YES;

                    [weakself.headView addPlayerView];
                }
                
            }
           
        }
         
    };
    
    self.app.playerView.BlockCloseClick = ^{
        
        weakself.isClosePlayerView = YES;
        [weakself.headView addPlayerView];
    };
    //placeholder_method_call//
    
//    if (self.coursePurseType == 1) {
//        self.headView.csLineHeight.constant = 1.0;
//        self.headView.csLastTimeBgView.constant = 67.0;
//    }
//    if (self.coursePurseType == 2) {
//        self.headView.csLastTimeBgView.constant = 37.0;
//        self.headView.csPurchaseShowBg.constant = 76.0;
////        self.headView.csInviteBtn.constant = 38.0;
//    }
    
    

    [self.pageController.view addSubview:self.headView];
    NSLog(@"%f",self.headView.size.height);
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.mas_equalTo(self.pageController.view); // 左边
        make.trailing.mas_equalTo(self.pageController.view);// 后边
        make.top.mas_equalTo(self.pageController.view);  // 顶部
        make.width.mas_equalTo(SCREEN_WIDTH);          // 宽度
    }];

    
        [self.headView addPlayerView];

    
    NSLog(@"%f",self.headView.size.height);
  
    
    
    
  
    
    [self.pageController reloadData];
    
    if ([CoreStatus isNetworkEnable]) {
        
        [self loadData];
    }else{
        
        if (self.playerId) { //有缓存过 才能展示
            self.model = [CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",self.courseId]];
            self.playerModel = [CoursePlayerFootModel infoWithData:[YCDownloadManager itemWithFileId:self.playerId].extraData];
            [self.headView setModel:self.model];
            [self upPlayerView:YES];
        }
    }
//    UIWindow
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeRotate:) name:kNotification_DirectionChange object:nil];

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//-(void)didChangeRotate:(NSNotification*)notification{
//    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
//           || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
//
////        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//        self.isFullScreen = NO;
//           //竖屏
//       } else {
//           //横屏
////           [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//           self.isFullScreen = YES;
//           }
//    self.isFullScreen = NO;
//
//    NSLog(@"dddddddddddddd = %d",self.isFullScreen);
//    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//
//
//}
- (void)addChildSouse {
    WS(weakself)
    if (self.goodsType == 1) { //视频
        
        self.videoListVC = [[VideoListVC alloc] init];
        self.videoListVC.BlockVideoClick = ^(NSInteger section, NSInteger row) {
            
            CoursePlayerFootModel *model = weakself.model.chapter_video[section].video_list[row];
            if ([model.live_state integerValue] == 0) { //课程视频
                
                weakself.playerSection = section;
                weakself.playerRow = row;
                
                weakself.playerModel = model;
                
                [weakself upPlayerView:YES];
//                [weakself.headView beginPlayVideo];
                
                CGFloat height = 0;
                if (self.app.playerView.PlayerType == 1) { //视频
                    
                    height = SCREEN_WIDTH*14/25;
                }else{
                    height = SCREEN_WIDTH*14/25;
//                    height = SCREEN_WIDTH*14/25+160;
                }
                if (self.scrollViewOffset > height) {
                    if (self.goodsType == 1) { //视频
                        if (!weakself.app.playerView.isWindowsView) {
                            
                            [weakself.app.playerView showPlayerInView:KeyWindow];
                        }
                    }
                }
                [weakself.headView beginPlayVideo];
            }else{ //课程直播
                
                [weakself GoLiveRoom:model.live_id liveState:[model.live_state integerValue]];
            }
        };
       
        [self.views addObject:self.videoListVC];
        
    }else if (self.goodsType == 2){ //音频
        
        self.adudioListVC = [[AdudioListVC alloc] init];
        self.adudioListVC.is_buy = self.is_buy;
        self.adudioListVC.BlockAudioClick = ^(NSInteger index) {
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if (weakself.app.playerView.player.status == PLPlayerStatusPlaying && weakself.app.playerView.playerModel.id == weakself.model.chapter_audio[index].id) {
                del.audioDetailVC.last_click_play  = NO;
            } else {
                del.audioDetailVC.last_click_play  = YES;
            }
            weakself.app.playerView.model = weakself.model;

            del.audioDetailVC.model = weakself.model;
            del.audioDetailVC.playerRow = index;
            del.audioDetailVC.is_buy = weakself.is_buy;
            weakself.playerRow = index;
           

//                                next.model = weakself.model;
//                                next.playerRow = weakself.playerRow;
                                 
                                [weakself.navigationController pushViewController:del.audioDetailVC animated:YES];
            
//            weakself.app.playerView.model = weakself.model;
//            a.playerRow = index;
//            a.model = weakself.model;
//                   [weakself.navigationController pushViewController:a animated:YES];
            

//
//      weakself.playerModel = weakself.model.chapter_audio[index];
//
//            [weakself upPlayerView:YES];
        };
        [self.views addObject:self.adudioListVC];
    }
}
- (void)addIntroduce {
    self.IntroduceVC = [[CourseIntroduceVC alloc] init];
    [self.views addObject:self.IntroduceVC];
  
}



//视图已经消失
- (void)viewDidDisappear:(BOOL)animated{
    
    [self upCourseLearnRecord];
    //placeholder_method_call//

    if (self.goodsType == 1) { //视频
        if (self.headView.topImgView.hidden == YES) {
            [self.app.playerView.videoView removeFromSuperview];
            [self.app.playerView stop];
        }
        
 

//        if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//
//            [self.app.playerView pause];
//        }else{
//
//            [self.app.playerView stop];
//        }
    }else{
        
//        if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//
//            [self.app.playerView showPlayerInView:KeyWindow];
//        }else{
//
//            [self.app.playerView stop];
//        }
    }
}

//视图已经显示
- (void)viewDidAppear:(BOOL)animated{
    
//    self.app.playerView.audioView.hidden = YES;
    self.app.playerView.hidden = NO;
    //placeholder_method_call//

    if (self.app.playerView.isWindowsView) {
        
        self.app.playerView.videoView.hidden = NO;
    }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//


- (BOOL)prefersStatusBarHidden {
    
    return self.isFullScreen;
}

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark - Datasource & Delegate

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    //placeholder_method_call//

    return self.titleAry.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    //placeholder_method_call//

    return self.views[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    //placeholder_method_call//

    return self.titleAry[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    //placeholder_method_call//

    CGFloat width = [self.pageController menuView:menu widthForItemAtIndex:index];
    return width;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    //placeholder_method_call//
    
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, self.pageController.maximumHeaderViewHeight, self.view.frame.size.width, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    //placeholder_method_call//

    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height-50-KSafeAreaHeight);
}

#pragma mark 自定义代理

- (void)tableViewWillPlay:(CourseHeadView *)view{
//placeholder_method_call//

    if (view == self.headView) return;
}

- (void)tableViewCellEnterFullScreen:(CourseHeadView *)view {
    //placeholder_method_call//

    self.isFullScreen = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)tableViewCellExitFullScreen:(CourseHeadView *)view {
    //placeholder_method_call//

    self.isFullScreen = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 事件
- (void)goingToTogetcher:(NSString *)t_id {
    TogetcherVC *t = [[TogetcherVC alloc] init];
    t.goodsId = self.model.cid;
    t.goodsType = @"course";
    t.myCourseTypes = (int)self.goodsType;
    t.t_id = t_id;
    WS(weakself)
    t.BlockBackClick = ^{
        [weakself loadData];
    };
    [self.navigationController pushViewController:t animated:YES];
}
#pragma mark - 公开方法

- (void)loadData{
    
//placeholder_method_call//
WS(weakself)
    [APPRequest GET:@"/courseDetail" parameters:@{@"id":self.courseId} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            weakself.model = [CourseDetailModel mj_objectWithKeyValues:result.data];
//            if (weakself.model.is_discount == 1) {
//                weakself.model.end_time = weakself.end_time;
//
//            }
          
        
            
            weakself.views = [NSMutableArray array];
            if ([weakself.model.checkbuy intValue] == 1) {
                [weakself addChildSouse];
                [weakself addIntroduce];
                weakself.titleAry = [NSMutableArray arrayWithObjects:@"目录",@"详情",nil];
            } else {
                [weakself addIntroduce];
                [weakself addChildSouse];
                weakself.titleAry = [NSMutableArray arrayWithObjects:@"详情",@"目录",nil];

            }
            [weakself.pageController reloadData];
            
            

            
            //创建下载唯一id
            if ([self.model.goods_type integerValue] == 1) { //视频
                
                for (CourseChapterModel *chapM in self.model.chapter_video) {
                    
                    for (CoursePlayerFootModel *model in chapM.video_list) {
                        
                        model.did = [NSString stringWithFormat:@"%@%@",model.cid,model.id];
                    }
                }
            }else{ //音频
                
                for (CoursePlayerFootModel *model in self.model.chapter_audio) {
                    
                    model.did = [NSString stringWithFormat:@"%@%@",model.cid,model.id];
                }
            }
            if (self.model.curChannel == nil) { //没有学习记录
                
                if (self.goodsType == 1) { //视频
                    
                    if (self.model.chapter_video.count > 0) {
                        
                        for (int i=0; i<self.model.chapter_video.count; i++) {
                            
                            CourseChapterModel *ChapterModel = self.model.chapter_video[i];
                            if (ChapterModel.video_list.count > 0) {
                                
                                self.playerRow = 0;
                                self.playerSection = i;
                                
                                self.playerModel = self.model.chapter_video[self.playerSection].video_list[self.playerRow];
                                
                                break;
                            }
                        }
                    }
                }else{ //音频
                    
                    if (self.model.chapter_audio.count > 0) {
                        
                        self.playerRow = 0;
                        self.playerSection = 0;
                        
                        self.playerModel = self.model.chapter_audio[self.playerRow];
                    }
                }
            }else{ //有学习记录
                
                if (self.goodsType == 1) { //视频
                    
                    for (int i=0; i<self.model.chapter_video.count; i++) {
                        
                        CourseChapterModel *chapModel = self.model.chapter_video[i];
                        if (chapModel.id == self.model.curChannel.tid) {
                            
                            for (int j=0; j<chapModel.video_list.count; j++) {
                                
                                CoursePlayerFootModel *playerModel = chapModel.video_list[j];
                                
                                if (playerModel.id == self.model.curChannel.id) {
                                    
                                    self.playerSection = i;
                                    self.playerRow = j;
                                    self.playerModel = playerModel;
                                    break;
                                    
                                    
                                }
                            }
                        }
                    }
                }else{ //音频
                    
                    for (int i=0; i<self.model.chapter_audio.count; i++) {
                        
                        CoursePlayerFootModel *playerModel = self.model.chapter_audio[i];
                        if (playerModel.id == self.model.curChannel.id) {
                            
                            self.playerRow = i;
                            self.playerSection = 0;
                            
                            self.playerModel = playerModel;
                        }
                    }
                }
            }
             
            [self.headView setModel:self.model];
            // #######
            [self upPlayerView:NO];
            self.IntroduceVC.contentUrl = self.model.content;
            if (self.goodsType == 1) { //视频
                
                self.videoListVC.model = self.model;
                self.videoListVC.playerModel = self.playerModel;
                [self.videoListVC setPlayerSection:self.playerSection PlayerRow:self.playerRow];
            }else if (self.goodsType == 2){ //音频
                
                self.adudioListVC.model = self.model;
                self.adudioListVC.playerRow = self.playerRow;
                self.adudioListVC.playerModel = self.playerModel;
            }
        }
    }];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)upPlayerView:(BOOL)isPlay{
    
    [self.headView setPlayerSection:self.playerSection PlayerRow:self.playerRow];
    [self.headView setPlayModel:self.playerModel isPlay:isPlay];
    [self.headView layoutIfNeeded];
    //placeholder_method_call//

    NSLog(@"%f",self.headView.height);
    self.pageController.maximumHeaderViewHeight = self.headView.height;
    WS(weakself)
    self.footView.model = self.model;
    self.footView.playModel = self.playerModel;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });

   
}

- (void)updateFoot {
    
}

//更新学习记录
- (void)upCourseLearnRecord{
    
    if (self.app.playerView.playerModel) {
        //placeholder_method_call//

        if (self.app.playerView.player.status == PLPlayerStatusUnknow) {
            
            return;
        }
        if (self.app.playerView.PlaylongTime > 0 ) {
            
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:self.app.playerView.playerModel.cid forKey:@"course_id"];
            [param setObject:[NSString stringWithFormat:@"%ld",self.app.playerView.PlaylongTime] forKey:@"study_time"]; //视频播放时长
            [param setObject:[NSString stringWithFormat:@"%.f",CMTimeGetSeconds(self.app.playerView.player.totalDuration)] forKey:@"long_time"];
            if (self.app.playerView.PlayerType == 1) { //视频
                
                [param setObject:self.app.playerView.playerModel.id forKey:@"vid"];
                [param setObject:@"video" forKey:@"type"];
            }else { //音频
                
                [param setObject:self.app.playerView.playerModel.id forKey:@"aid"];
                [param setObject:@"audio" forKey:@"type"];
            }
            [APPRequest POST:@"/updateCourseRecord" parameters:param     finished:^(AjaxResult *result) {
                
                if (result.code == AjaxResultStateSuccess) {
                    
                }
            }];
        }
    }
}

#pragma mark - 私有方法
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

#pragma mark - get set

- (CourseFootView *)footView{
    
    if (_footView == nil) {
        
        WS(weakself);
        _footView = [[[NSBundle mainBundle] loadNibNamed:@"CourseFootView" owner:nil options:nil] lastObject];
        //placeholder_method_call//

        _footView.BlockOperationClick = ^(NSInteger type) {
            
            if (type == 1) { //回主页
                
                [weakself BackHome:0];
            }else if (type == 2){ //购买vip
                
                BuyVipVC *next = [[BuyVipVC alloc] init];
                [weakself.navigationController pushViewController:next animated:YES];
            }else if (type == 3){ //购买课程
                if (!Ktoken) {
                    [weakself loginAction];
                    return;
                }
                
                if ([self.model.audit integerValue] == 0) { //已下架
                    
                    [KeyWindow showTip:@"该课程已下架"];
                    return ;
                }else{
                    //    是否购买,如果是VIP默认购买状态
                    if ([self.model.checkbuy integerValue] == 1) { //已购买  播
                      
                        if (self.goodsType == 1) { //视频
                            if (self.app.playerView.player.status != PLPlayerStatusPlaying) {
                                [weakself.headView beginPlayVideo];
                            } else {
                                if (self.headView.topImgView.hidden == NO) {
                                    [weakself.headView beginPlayVideo];

                                }
                            }
                            if (weakself.model.chapter_video.count > 0) {
                               
                                if (weakself.model.chapter_video[weakself.playerSection].video_list.count > 0) {
                                    
                                    /* 滚动指定段的指定row  到 指定位置*/
                                    [weakself.videoListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:weakself.playerSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                                }
                            }
                        }else{
                            if (weakself.model.chapter_audio.count > 0) {
                                
                                /* 滚动指定段的指定row  到 指定位置*/
                                [weakself.adudioListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                            }
                            
                            weakself.app.playerView.model = weakself.model;
                            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            if (weakself.app.playerView.player.status == PLPlayerStatusPlaying && weakself.app.playerView.playerModel.id == weakself.model.chapter_audio[weakself.playerRow].id) {
                                del.audioDetailVC.last_click_play  = NO;
                            } else {
                                del.audioDetailVC.last_click_play  = YES;
                            }
                            del.audioDetailVC.model = weakself.model;
                            del.audioDetailVC.playerRow = weakself.playerRow;
                            
                            [weakself.navigationController pushViewController:del.audioDetailVC animated:YES];
                            
                            
                            
                        }
                    }else{ //未购买
                        
                        if ([self.model.price floatValue] <= 0) {
                            
                            NSMutableDictionary *param = [NSMutableDictionary dictionary];
                            [param setObject:@"ios" forKey:@"source"];
                            [param setObject:weakself.model.cid forKey:@"item_id"];
                            [param setObject:@"course" forKey:@"order_type"];
                            
                            [APPRequest GET:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
                                
                                if (result.code == AjaxResultStateSuccess) {
                                    
                                    [KeyWindow showTip:@"报名成功"];
                                    [weakself loadData];
                                }
                            }];
                        }else{
                            
                            if (self.goodsType == 1 && self.model.chapter_video.count == 0) {
                                
                                [KeyWindow showTip:@"暂无视频!"];
                                return;
                            }else if (self.goodsType == 2 && self.model.chapter_audio.count == 0){
                                
                                [KeyWindow showTip:@"暂无音频!"];
                                return;
                            }
                            AddOrderVC *next = [[AddOrderVC alloc] init];
                            next.goodsId = weakself.model.cid;
                            next.goodsType = @"course";
                            next.BlockBackClick = ^{
                                
                                [weakself loadData];
                            };
                            [weakself.navigationController pushViewController:next animated:YES];
                        }
                    }
                }
            }else if (type == 4){
                
                [weakself showShareViews:weakself.goodsType shareId:weakself.model.cid shareImgUrl:self.model.banner shareTitle:weakself.model.title Success:^(OSMessage *message) {
                    
                    NSLog(@"");
                } Fail:^(OSMessage *message, NSError *error) {
                    
                    NSLog(@"");
                }];
            } else if (type == 7) {
                if (!Ktoken) {
                    [weakself loginAction];
                    return;
                }
                [weakself goingToTogetcher:weakself.model.group.join_group_id];
            }
            
            else if (type == 5){
                if (!Ktoken) {
                    [weakself loginAction];
                    return;
                }
                
                if ([self.model.audit integerValue] == 0) { //已下架
                    
                    [KeyWindow showTip:@"该课程已下架"];
                    return ;
                }else{
                    //    是否购买,如果是VIP默认购买状态
                    if ([self.model.checkbuy integerValue] == 1) { //已购买  播
                      
                        if (self.goodsType == 1) { //视频
                            if (self.app.playerView.player.status != PLPlayerStatusPlaying) {
                                [weakself.headView beginPlayVideo];
                            } else {
                                if (self.headView.topImgView.hidden == NO) {
                                    [weakself.headView beginPlayVideo];

                                }
                            }
                            if (weakself.model.chapter_video.count > 0) {
                               
                                if (weakself.model.chapter_video[weakself.playerSection].video_list.count > 0) {
                                    
                                    /* 滚动指定段的指定row  到 指定位置*/
                                    [weakself.videoListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:weakself.playerSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                                }
                            }
                        }else{
                            if (weakself.model.chapter_audio.count > 0) {
                                
                                /* 滚动指定段的指定row  到 指定位置*/
                                [weakself.adudioListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                            }
                            
                            weakself.app.playerView.model = weakself.model;
                            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            if (weakself.app.playerView.player.status == PLPlayerStatusPlaying && weakself.app.playerView.playerModel.id == weakself.model.chapter_audio[weakself.playerRow].id) {
                                del.audioDetailVC.last_click_play  = NO;
                            } else {
                                del.audioDetailVC.last_click_play  = YES;
                            }
                            del.audioDetailVC.model = weakself.model;
                            del.audioDetailVC.playerRow = weakself.playerRow;
                            
                            [weakself.navigationController pushViewController:del.audioDetailVC animated:YES];
                            
                            
                            
                        }
                    }else{ //未购买
                        
                        if ([self.model.price floatValue] <= 0) {
                            
                            NSMutableDictionary *param = [NSMutableDictionary dictionary];
                            [param setObject:@"ios" forKey:@"source"];
                            [param setObject:weakself.model.cid forKey:@"item_id"];
                            [param setObject:@"course" forKey:@"order_type"];
                            
                            [APPRequest GET:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
                                
                                if (result.code == AjaxResultStateSuccess) {
                                    
                                    [KeyWindow showTip:@"报名成功"];
                                    [weakself loadData];
                                }
                            }];
                        }else{
                            
                            if (self.goodsType == 1 && self.model.chapter_video.count == 0) {
                                
                                [KeyWindow showTip:@"暂无视频!"];
                                return;
                            }else if (self.goodsType == 2 && self.model.chapter_audio.count == 0){
                                
                                [KeyWindow showTip:@"暂无音频!"];
                                return;
                            }
                            AddOrderVC *next = [[AddOrderVC alloc] init];
                            next.goodsId = weakself.model.cid;
                            next.goodsType = @"course";
                            next.group = @"new";
                            next.BlockBackClick = ^{
                                
                                [weakself loadData];
                            };
                            [weakself.navigationController pushViewController:next animated:YES];
                        }
                    }
                }
                
                
            }
            
            
            
            
            
            
        };
    }
    return _footView;
}

- (CourseHeadView *)headView{
    
    if (_headView == nil) {
        
        WS(weakself);
        //placeholder_method_call//

        _headView = [[[NSBundle mainBundle] loadNibNamed:@"CourseHeadView" owner:nil options:nil] lastObject];
        _headView.delegate = self;
        _headView.PlayerType = self.goodsType;
        _headView.BlockSwitchAdudioClick = ^(CoursePlayerFootModel * _Nonnull playerModel, NSInteger playerRow) {
            
            weakself.adudioListVC.playerRow = playerRow;
            weakself.adudioListVC.playerModel = playerModel;
        };
        _headView.BlockSwitchVideoClick = ^(CoursePlayerFootModel * _Nonnull playerModel, NSInteger playerSection, NSInteger playerRow) {
          
            [weakself.videoListVC setPlayerSection:playerSection PlayerRow:playerRow];
            weakself.videoListVC.playerModel = playerModel;
        };
        _headView.BlokGroupDetailClick = ^{
           
            [weakself goingToTogetcher:weakself.model.group.join_group_id];
        };
        [_headView.incomeShowView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                    NSLog(@"xddd");
            [KeyWindow addSubview:weakself.shareShowView];
            
                }];
        _headView.BlockJoinClick = ^(GroupingModel * _Nonnull model) {
            [weakself goingToTogetcher:model.spell_items_id];
        };
        [_headView.inviteBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            
            [weakself inviteFriend];
            

                    // 邀请
//            [weakself ShareGroupshareImgUrl:nil shareUrl:self.model.share_url Success:^(OSMessage *message) {
//
//                        } Fail:^(OSMessage *message, NSError *error) {
//
//                        }];
            
        }];
        
        [_headView.playBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (!Ktoken) {
                [weakself loginAction];
                return;
            }
            
            if ([self.model.audit integerValue] == 0) { //已下架
                
                [KeyWindow showTip:@"该课程已下架"];
                return ;
            }else{
                //    是否购买,如果是VIP默认购买状态
                if ([self.model.checkbuy integerValue] == 1) { //已购买  播放
                    
//                        weakself.pageController.selectIndex = 1;
                    
                  
                    if (self.goodsType == 1) { //视频
                        if (self.app.playerView.player.status != PLPlayerStatusPlaying   || (self.app.playerView.player.status == PLPlayerStatusPlaying && self.app.playerView.audioView.hidden == NO)) {
                            
//                            weakself.headView.topImgView.hidden = YES;
//                            weakself.headView.playBtn.hidden = YES;
//                            weakself.headView.playBgView.hidden = YES;
//                            weakself.app.playerView.hidden = NO;
                            [weakself.headView beginPlayVideo];
//                            [weakself.app.playerView play];
                        }
                        
                        
                        if (weakself.model.chapter_video.count > 0) {
                           
                            if (weakself.model.chapter_video[weakself.playerSection].video_list.count > 0) {
                                
                                /* 滚动指定段的指定row  到 指定位置*/
                                [weakself.videoListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:weakself.playerSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                            }
                        }
                    }else{
                        if (weakself.model.chapter_audio.count > 0) {
                            
                            /* 滚动指定段的指定row  到 指定位置*/
                            [weakself.adudioListVC.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.playerRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                        }
                        
                        weakself.app.playerView.model = weakself.model;
                        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        del.audioDetailVC.model = weakself.model;
                        del.audioDetailVC.playerRow = weakself.playerRow;
            //                                next.model = weakself.model;
            //                                next.playerRow = weakself.playerRow;
                                            [weakself.navigationController pushViewController:del.audioDetailVC animated:YES];
                        
                        
                        
                    }
                }else{ //未购买
                    
                    if ([self.model.price floatValue] <= 0) {
                        
                        NSMutableDictionary *param = [NSMutableDictionary dictionary];
                        [param setObject:@"ios" forKey:@"source"];
                        [param setObject:weakself.model.cid forKey:@"item_id"];
                        [param setObject:@"course" forKey:@"order_type"];
                        
                        [APPRequest GET:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
                            
                            if (result.code == AjaxResultStateSuccess) {
                                
                                [KeyWindow showTip:@"报名成功"];
                                [weakself loadData];
                            }
                        }];
                    }else{
                        
                        
                        
                        if (self.goodsType == 1 && self.model.chapter_video.count == 0) {
                            
                            [KeyWindow showTip:@"暂无视频!"];
                            return;
                        }else if (self.goodsType == 2 && self.model.chapter_audio.count == 0){
                            
                            [KeyWindow showTip:@"暂无音频!"];
                            return;
                        }
                        [KeyWindow showTip:@"请购买课程"];
                        return;
//                        AddOrderVC *next = [[AddOrderVC alloc] init];
//                        next.goodsId = weakself.model.cid;
//                        next.goodsType = @"course";
//                        next.BlockBackClick = ^{
//
//                            [weakself loadData];
//                        };
//                        [weakself.navigationController pushViewController:next animated:YES];
                    }
                }
            }
                    
        }];
        [_headView.btnConment addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            CommentsVC *next = [[CommentsVC alloc] init];
            next.courseId = self.courseId;
            next.isBuy = [self.model.checkbuy integerValue] == 1?YES:NO;
            next.BlockReloadClick = ^{
              
                [_headView.btnConment setTitle:[NSString stringWithFormat:@"  %ld",[self.model.comment_total integerValue]+1] forState:UIControlStateNormal];
            };
            [self.navigationController pushViewController:next animated:YES];
        }];
        [_headView.btnDownLoad addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           
            if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
                
                //    是否购买,如果是VIP默认购买状态
                if ([self.model.checkbuy integerValue] == 0) { //未购买
                    
                    if ([self.model.price floatValue] <= 0) { //免费 需要报名
                        
                        [KeyWindow showTip:@"该课程需要报名，请先报名"];
                        return ;
                    }else{
                        
                        [KeyWindow showTip:@"该课程需要付费，请先购买"];
                        return ;
                    }
                }
            }
            
            if (self.goodsType == 1) {
               
                SelectCacheVideoVC *next = [[SelectCacheVideoVC alloc] init];
                next.cid = self.model.cid;
                [self.navigationController pushViewController:next animated:YES];
            }else{
                
                SelectCacheAudioVC *next = [[SelectCacheAudioVC alloc] init];
                next.cid = self.model.cid;
                [self.navigationController pushViewController:next animated:YES];
            }
        }];
    }
    
    return _headView;
}
- (ShareShowView *)shareShowView{
    
    if (_shareShowView == nil) {
        
        WS(weakself);
        //placeholder_method_call//

        _shareShowView = [[[NSBundle mainBundle] loadNibNamed:@"ShareShowView" owner:nil options:nil] lastObject];
        _shareShowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _shareShowView.incomeshowLabel.text  = [NSString stringWithFormat: @"点击课程详情页的分享按钮即可把课程分享给好友, 好友购买后你可以获得课程款%ld%%的分销提成",self.model.goods_ratio];
        [_shareShowView.incomeshowLabel addAttrbuteColorWithAttributeText:@[[NSString stringWithFormat:@"%ld%%",self.model.goods_ratio]] withAttrArrayColor:@[[UIColor colorWithHex:0x489A9B]]];
       
    }
    
    return _shareShowView;
}
- (AppDelegate *)app{
    
    if (_app == nil) {
        //placeholder_method_call//

        _app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return _app;
}

- (WMStickyPageController *)pageController{
    
    if (!_pageController) {
        
        _pageController = [[WMStickyPageController alloc] init];
        _pageController.showOnNavigationBar = NO;     //在导航栏上展示
        _pageController.menuViewStyle = WMMenuViewStyleLine;
        //placeholder_method_call//

        _pageController.scrollEnable = YES;
        _pageController.titleSizeSelected = 16;
        _pageController.titleSizeNormal = 16;
        _pageController.progressColor = [UIColor colorWithHex:0x479298];
        _pageController.titleColorNormal = RGB(144, 147, 153);
        _pageController.titleColorSelected = [UIColor colorWithHex:0x479298];
        _pageController.itemMargin = 0;
        _pageController.progressWidth = 25;
        _pageController.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
        _pageController.menuItemWidth = SCREEN_WIDTH/2;
        _pageController.delegate = self;
        _pageController.dataSource = self;
    }
    
    return _pageController;
}

- (void)inviteFriend {
    NSMutableDictionary *param = @{
        @"t_id":self.model.group.join_group_id
    }.mutableCopy;
    WS(weakself)
    [APPRequest GET:@"/spellGroupItem" parameters:param finished:^(AjaxResult *result) {

        if (result.code == AjaxResultStateSuccess) {
            TogetcherModel *model = [TogetcherModel mj_objectWithKeyValues:result.data];
            
            [weakself ShareGroupshareImgUrl:model.shop.banner shareUrl:self.model.share_url withTitle:model.shop.title Success:^(OSMessage *message) {

                        } Fail:^(OSMessage *message, NSError *error) {

                        }];
            
         
           
           
        }
    }];
}

//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

@end

//
//  SilenceShareUtil.m
//  Dy
//
//  Created by Silence on 16/8/3.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "SilenceShareUtil.h"
#import "AppDelegate.h"
#import "UIButton+Block.h"
#import "UIView+BlockGesture.h"
#import "UIView+Frame.h"
static NSString *const kSilenceShareUtilInstanceKey = @"SilenceShareUtilInstanceKey";
static NSInteger const kContentViewHeight = 120;
@interface SilenceShareUtil()
@property (strong, nonatomic) UIView *shareView;//整个分享视图
@property (strong, nonatomic) UIView *shareBottomView;//底部分享视图
@property (strong, nonatomic) UIScrollView *scrollView;//底部分享图标容器
@property (strong, nonatomic) NSMutableArray *shareTypes;//分享到那些平台
@property (strong, nonatomic) NSMutableArray *shareTypeImgNames;//分享到那些平台的图片名称
@property (strong, nonatomic) NSMutableArray *shareTypeNames;//分享到那些平台的文字标签内容

@property (strong, nonatomic) OSMessage *shareMsg; //需要分享的内容
@property (strong, nonatomic) shareSuccess shareSuccessCallback;//分享成功后的回调
@property (strong, nonatomic) shareFail shareFailCallback;//分享失败后的回调

@property (assign, nonatomic) ShareType currentShareType; // 当前分享的类型

@property (nonatomic , assign) CGFloat contentViewHeight; // 高度
@end
@implementation SilenceShareUtil

+(SilenceShareUtil *)shareUtil{
    @synchronized(self){
        SilenceShareUtil *ins = [APPManager findSingleInstanceWithIdentifier:kSilenceShareUtilInstanceKey];
        if(ins == nil){
            ins = [[self alloc] init];
            [APPManager addSingleInstanceWithIdentifier:kSilenceShareUtilInstanceKey instance:ins];
            //全局注册appId
            //            [OpenShare connectQQWithAppId:@"1101123416"];
            //            [OpenShare connectWeixinWithAppId:@"wx82688e14bd7078e9"];
        }
        return ins;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shareTypes = [NSMutableArray array];
        self.shareTypeImgNames = [NSMutableArray array];
        self.shareTypeNames = [NSMutableArray array];
    }
    return self;
}

-(void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg HandleShareClick:(HandleShareClick)shareClick Success:(shareSuccess)success Fail:(shareFail)fail{
    self.handleShareClick = shareClick;
    [self showShareViews:shareTypeArray shareMsg:shareMsg Success:success Fail:fail];
}


-(void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg Success:(shareSuccess)success Fail:(shareFail)fail{
    [self.shareTypes removeAllObjects];
    [self.shareTypeImgNames removeAllObjects];
    [self.shareTypeNames removeAllObjects];
    
    for (NSNumber *type in shareTypeArray) {
        if (type.integerValue == ShareTypeQQ) {
            if ([OpenShare isQQInstalled]) {
                [self.shareTypes addObject:type];
                [self.shareTypeImgNames addObject:@"share_qq"];
                [self.shareTypeNames addObject:@"QQ好友"];
            }
        }else if (type.integerValue == ShareTypeQQSpace){
            if ([OpenShare isQQInstalled]) {
                [self.shareTypes addObject:type];
                [self.shareTypeImgNames addObject:@"share_kj"];
                [self.shareTypeNames addObject:@"QQ空间"];
            }
        }else if (type.integerValue == ShareTypeWX){
            if ([OpenShare isWeixinInstalled]) {
                [self.shareTypes addObject:type];
                [self.shareTypeImgNames addObject:@"share_wx"];
                [self.shareTypeNames addObject:@"微信"];
            }
        }else if (type.integerValue == ShareTypeWXSpace){
            if ([OpenShare isWeixinInstalled]) {
                [self.shareTypes addObject:type];
                [self.shareTypeImgNames addObject:@"share_pyq"];
                [self.shareTypeNames addObject:@"朋友圈"];
            }
        }
    }
    [self setupView];
    self.shareMsg = shareMsg;
    self.shareSuccessCallback = success;
    self.shareFailCallback = fail;
    
    [self show];
    
}

#pragma mark - 私有方法

/**
 *  初始化视图
 */
-(void)setupView{
    CGFloat saftBottom = 0.0;
    if (@available(iOS 11.0, *)) {
        if (is_iPhoneXSerious) {
            saftBottom = 44.0;
    }
    }
    NSInteger num = (self.shareTypes.count % 4 == 0) ? self.shareTypes.count/4 : self.shareTypes.count/4 + 1;
    self.contentViewHeight = kContentViewHeight * num ;
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.shareView.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    //初始化背景按钮，用于点击隐藏
    UIButton *bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgBtn.backgroundColor = [UIColor clearColor];
    [self.shareView addSubview:bgBtn];
    [bgBtn addActionHandler:^(NSInteger tag) {
        [self hide];
    }];
    [self.shareView addSubview:bgBtn];
    
    
    //    //提示文字
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 44)];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.font = [UIFont systemFontOfSize:13];
    //    label.textColor = kColor_Text_Black2;
    //    label.text = @"分享到：";
    //    [self.shareBottomView addSubview:label];
    
    //底部按钮
  
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - saftBottom, SCREEN_WIDTH, 44)];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = FONT_SIZE(14);
    [cancelBtn addActionHandler:^(NSInteger tag) {
        [self hide];
    }];
    [self.shareView addSubview:cancelBtn];
    
    //初始化底部视图
    self.shareBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentViewHeight)];
    self.shareBottomView.backgroundColor = [UIColor whiteColor];
    [self.shareView addSubview:self.shareBottomView];
    self.shareBottomView.bottom = cancelBtn.frame.origin.y;
    
    
    
    //添加内容
    //    CGFloat h = kContentViewHeight-VIEW_H(label) - VIEW_H(cancelBtn);
    //    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEW_H(label), SCREEN_WIDTH, h)];
    //    self.scrollView.backgroundColor = [UIColor clearColor];
    //    self.scrollView.showsVerticalScrollIndicator = NO;
    //    self.scrollView.showsHorizontalScrollIndicator = NO;
    //    self.scrollView.bounces = NO;
    //    [self.shareBottomView addSubview:self.scrollView];
    CGFloat width = SCREEN_WIDTH / 4;
    
    
    //    self.scrollView.contentSize = CGSizeMake(width*self.shareTypes.count + 16, h);
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i=0; i<self.shareTypes.count; i++) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, kContentViewHeight)];
        unitView.backgroundColor = [UIColor clearColor];
        [unitView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [self handleShareClick:[self.shareTypes[i] integerValue]];
        }];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, width - 2*8, 75)];
        img.image = [UIImage imageNamed:self.shareTypeImgNames[i]];
        img.contentMode = UIViewContentModeCenter;
        [unitView addSubview:img];
        
        //提示文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_H(img) + 8, width, 36)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor darkGrayColor];
        label.text = self.shareTypeNames[i];
        [unitView addSubview:label];
        [self.shareBottomView addSubview:unitView];
        
        x+=width;
        if ((i+1) % 4 == 0) {
            x = 0;
            y+= kContentViewHeight;
        }
    }
    
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentViewHeight - (1.0 / [UIScreen mainScreen].scale), SCREEN_WIDTH, (1.0 / [UIScreen mainScreen].scale))];
    splitLine.backgroundColor = kColor_Split;
    [self.shareBottomView addSubview:splitLine];
}

//处理点击事件
-(void)handleShareClick:(ShareType)type{
    self.currentShareType = type;
    if (self.handleShareClick != nil) {
        self.handleShareClick(type);
    }else{
        [self handle:type];
    }
    [self hide];
}

-(void)handle:(ShareType)type{
    if (type == ShareTypeQQ) {
        [OpenShare shareToQQFriends:self.shareMsg Success:self.shareSuccessCallback Fail:self.shareFailCallback];
    }else if (type == ShareTypeQQSpace){
        [OpenShare shareToQQZone:self.shareMsg Success:self.shareSuccessCallback Fail:self.shareFailCallback];
    }else if (type == ShareTypeWX){
        [OpenShare shareToWeixinSession:self.shareMsg Success:self.shareSuccessCallback Fail:self.shareFailCallback];
    }else if (type == ShareTypeWXSpace){
        [OpenShare shareToWeixinTimeline:self.shareMsg Success:self.shareSuccessCallback Fail:self.shareFailCallback];
    }
}



/**
 *  显示视图
 */
-(void)show{
    CGFloat saftBottom = 0.0;
    if (@available(iOS 11.0, *)) {
        if (is_iPhoneXSerious) {
            saftBottom = 44.0;
    }
    }
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self.shareView];
    self.shareView.alpha = 0;
    [UIView animateWithDuration:.15 animations:^{
        self.shareView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:.2 animations:^{
                self.shareBottomView.frame = CGRectMake(0, SCREEN_HEIGHT - self.contentViewHeight - 44 - saftBottom, SCREEN_WIDTH, self.contentViewHeight);
            }];
        }
    }];
}

/**
 *  隐藏视图
 */
-(void)hide{
    [UIView animateWithDuration:.2 animations:^{
        self.shareBottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.contentViewHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:.1 animations:^{
                self.shareView.alpha = 0.0;
            } completion:^(BOOL finished2) {
                if (finished2) {
                    [self.shareView removeFromSuperview];
                }
            }];
            
        }
    }];
}

@end

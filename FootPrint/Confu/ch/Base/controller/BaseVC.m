//
//  BaseVC.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/12.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "BaseVC.h"
#import "KxMenu.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import <sys/utsname.h>
#import "ShareFootModel.h"
#import "TalkfunViewController.h"
#import "TalkfunPlaybackViewController.h"
#import "ProcessImg.h"
#import "WXApi.h"
@interface BaseVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *morePopBtn;

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation BaseVC

#pragma mark - 设置视图
- (void)loginAction {
                if (![CoreStatus isNetworkEnable]) {
                    NSLog(@"没有网络");
                    [KeyWindow showFailTip:@"暂无网络..."];
                    return;
                }
    
         UIViewController *login;

                if ([isAudit isEqualToString:@"no"]) {
                    login = [[WXLogInVC alloc]init];
                } else {
                    login = [[LoginVC alloc]init];
                }
   

    
                [self.navigationController pushViewController:login animated:true];
    
    
    
}

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];

    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:YES];//导航栏背景颜色
    
    //导航栏标题字体大小，颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//        [self.navigationController.navigationBar navBarAlpha:0 isOpaque:YES];//导航栏透明度
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
//placeholder_method_call//
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;

    // 设置默认背景色
    self.view.backgroundColor = kColor_BG;
    // 设置返回按钮
    [self setBackBtn];
    // 设置UI
    [self setupUI];
    
    NSLog(@"----load----:%@", [NSString stringWithUTF8String:object_getClassName(self)]);
}
//placeholder_method_impl//


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//

//
//#pragma mark - 代理
//
//#pragma mark 系统代理

//// 是否支持自动转屏
//- (BOOL)shouldAutorotate
//{
//    NSLog(@"%@",self);
//    if ([self isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//
//        return YES;
//    }
//    return NO;
//}
//// 支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    NSLog(@"%@",self);
//    if ([self isKindOfClass:[NSClassFromString(@"PlayVideoVC") class]]) {
//        
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}

#pragma mark 自定义代理

#pragma mark - 事件
//placeholder_method_impl//

#pragma mark - 公开方法

-(void)toRootViewController{
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        //判断是否为最底层控制器
        if ([viewController isKindOfClass:[BaseVC class]]) {
            viewController = viewController.presentingViewController;
            //placeholder_method_call//
        }else{
            break;
        }
    }
    if (viewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}
//placeholder_method_impl//

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //placeholder_method_call//
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
//placeholder_method_impl//

/**
 给子类去实现
 */
-(void)setupUI{
    
}
//placeholder_method_impl//

/**
 加载数据（给子类实现）
 */
-(void)loadData{
    //placeholder_method_call//
}
//placeholder_method_impl//

/**
 点击了返回按钮
 */
-(void)leftButtonClick{    
    if ([self.navigationController popViewControllerAnimated:YES] == nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    //placeholder_method_call//
    if (self.BlockBackClick) {
        self.BlockBackClick();
    }
}
//placeholder_method_impl//

- (void)callPhone:(NSString *)phone{

    NSMutableString *str= [[NSMutableString alloc]initWithFormat:@"tel:%@",phone];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"拨打电话\n%@",phone] preferredStyle:UIAlertControllerStyleAlert];
//placeholder_method_call//
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];

    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//placeholder_method_impl//

/**
 检查登录并跳转至登录界面
 
 @return 返回是否登录了
 */
-(BOOL)checkLoginBlokc:(BlockLoginSuccess)block{
    if ([APPUserDefault getCurrentUserFromLocal]) {
        return YES;
    }
    //placeholder_method_call//
    LoginVC *next = [[LoginVC alloc] init];
    next.loginSeccessback = block;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.navigationController presentViewController:next animated:YES completion:nil];
    });
    
    return NO;
}
//placeholder_method_impl//

-(void)gotoMsgCenter{
    //placeholder_method_call//
}
//placeholder_method_impl//

-(void)addMorePopBtn{
    
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"ic_common_list"] forState:UIControlStateNormal];
    [btn sizeToFit];
    //placeholder_method_call//
    self.morePopBtn = btn;
    [btn addActionHandler:^(NSInteger tag) {
        [self showMorePop:self.morePopBtn];
    }];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[barBtn];
}
//placeholder_method_impl//

-(void)showMorePop:(UIButton *)sender{
    
    CGRect frame = CGRectMake(CGRectGetMaxX(self.view.frame) - 30, 0, 1, 1);
    //placeholder_method_call//
    [KxMenu setTintColor:[UIColor blackColor]];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
    [KxMenu showMenuInView:self.view
                  fromRect:frame
                 menuItems:@[
                             [KxMenuItem menuItem:@"主页"
                                            image:[UIImage imageNamed:@"smqj"]
                                           target:self
                                           action:@selector(onKxmenuItemAction:)
                                              tag:0],
                             [KxMenuItem menuItem:@"定制"
                                            image:[UIImage imageNamed:@"smqj"]
                                           target:self
                                           action:@selector(onKxmenuItemAction:)
                                              tag:1],
                             [KxMenuItem menuItem:@"订单"
                                            image:[UIImage imageNamed:@"smqj"]
                                           target:self
                                           action:@selector(onKxmenuItemAction:)
                                              tag:2],
                             [KxMenuItem menuItem:@"我的"
                                            image:[UIImage imageNamed:@"smqj"]
                                           target:self
                                           action:@selector(onKxmenuItemAction:)
                                              tag:3]
                             ]
     ];
}
//placeholder_method_impl//

// 大图浏览
- (void)showBigImageView:(NSArray *)imglist Index:(NSInteger)index{
 
    SilenceImagePreview *view = [[SilenceImagePreview alloc] init];
    view.imgs = imglist;
    //placeholder_method_call//
    view.currentIndex = index;
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:view];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - private
//placeholder_method_impl//

#pragma mark - 空界面 相关的内容
/**
 *  显示加载视图
 */
-(void) xshowLoadingView{
    //placeholder_method_call//
    [self showEmptyView:EmptyViewTypeLoading eventBlock:nil];
}

/**
 *  隐藏加载视图
 */
-(void) hideLoadingView{
    //placeholder_method_call//
    [self hideEmptyView];
}
//placeholder_method_impl//

-(void)showEmptyView:(EmptyViewType)emptyViewType eventBlock:(EmptyViewEventBlock)eventBlock{
    [self hideEmptyView];
    //placeholder_method_call//
    self.emptyView = [[FzEmptyView alloc] initEmptyViewType:emptyViewType showInView:self.view eventBlock:eventBlock];
    [self.emptyView show:0];
}
//placeholder_method_impl//

- (void)showEmptyView:(EmptyViewType)emptyViewType viewHeight:(CGFloat)height eventBlock:(EmptyViewEventBlock)eventBlock{
    [self hideEmptyView];
    //placeholder_method_call//
    self.emptyView = [[FzEmptyView alloc] initEmptyViewType:emptyViewType showInView:self.view eventBlock:eventBlock];
    [self.emptyView show:height];
}
//placeholder_method_impl//

-(void)showEmptyViewWithAjaxResultState:(AjaxResultState)ajaxResultState eventBlock:(EmptyViewEventBlock)eventBlock{
    if (ajaxResultState == AjaxResultStateSuccess) {
        return;
    }
    //placeholder_method_call//
    [self hideEmptyView];
    if (ajaxResultState == AjaxResultStateParamError) {
        
    }
    self.emptyView = [[FzEmptyView alloc] initEmptyViewWithAjaxResultState:ajaxResultState showInView:self.view eventBlock:eventBlock];
    //placeholder_method_call//
    [self.emptyView show:0];
}
//placeholder_method_impl//

-(void)hideEmptyView{
    if (self.emptyView) {
        [self.emptyView hide];
        //placeholder_method_call//
        self.emptyView = nil;
    }
}
//placeholder_method_impl//

//-(NSString *)rsa_strt:(NSString *)string{
//
//    RSAEncryptor *rsa = [[RSAEncryptor alloc] init];
//    NSString *str=[[rsa rsaEncryptString:string] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
//    
//    return str;
//}

- (NSString*)deviceVersion{
    
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //placeholder_method_call//
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    //iPod
    
    　　if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    　　if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    　　if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    　　if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    　　if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G"; return @"iPod Touch 5G";
    
    　　//iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"]||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    　 if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"])  return @"iPad mini 3";
    
    　　return deviceString;
}
//placeholder_method_impl//

- (void)showShareViews:(NSArray *)shareTypeArray shareMsg:(OSMessage *)shareMsg Success:(shareSuccess)success Fail:(shareFail)fail{
    //placeholder_method_call//
    if (shareTypeArray) {
        
        [[SilenceShareUtil shareUtil]showShareViews:shareTypeArray shareMsg:shareMsg Success:success Fail:fail];
    }else{
        
        shareTypeArray = @[@(ShareTypeWX),@(ShareTypeWXSpace),@(ShareTypeQQ),@(ShareTypeQQSpace)];
        [[SilenceShareUtil shareUtil]showShareViews:shareTypeArray shareMsg:shareMsg Success:success Fail:fail];
    }
}
//placeholder_method_impl//
/*
   [self showShareViews:self.goodsType shareId:self.model.cid shareTitle:self.model.title Success:^(OSMessage *message) {
            
            NSLog(@"");
        } Fail:^(OSMessage *message, NSError *error) {
            
            NSLog(@"");
        }];
 */

- (void)showShareViews:(NSInteger)shareType shareId:(NSString *)shareid shareImgUrl:(NSString *)imgUrl shareTitle:(NSString *)title Success:(shareSuccess)success Fail:(shareFail)fail{
    //placeholder_method_call//
//    shareType 1视频 2音频 3套餐 4直播
    [APPRequest GET:@"/share" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            ShareFootModel *shareModel = [ShareFootModel mj_objectWithKeyValues:result.data];
            
            
            OSMessage *mes = [[OSMessage alloc] init];
            mes.title = @"只为您分享有价值的信息！";
            mes.title = title;

            mes.desc = @"只为您分享有价值的信息！";
        
                    
            if (imgUrl && imgUrl.length > 0) {
                    NSURL *url = APP_IMG(imgUrl);
                     UIImage *img = [ProcessImg getImageFromURL:url];
               img = [ProcessImg imageCompressForWidthScale:img targetWidth:288];
                img = [ProcessImg compressImage:img toByte:32765];

                NSLog(@"%f,%f",img.size.width,img.size.height);
                mes.thumbnail = img;
                mes.image = img;
                

            } else {
                

                mes.thumbnail = [UIImage imageNamed:@"app_logo"];
                 mes.image = [UIImage imageNamed:@"app_logo"];
            }
            mes.multimediaType = OSMultimediaTypeNews;
            

            [[SilenceShareUtil shareUtil] showShareViews:@[@(ShareTypeWX),@(ShareTypeWXSpace),@(ShareTypeQQ),@(ShareTypeQQSpace)] shareMsg:mes HandleShareClick:^(ShareType type) {
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *uname = [user objectForKey:@"uname"];;
                
                if (shareType == 1) { //视频
                    
                    mes.link = [NSString stringWithFormat:@"%@&id=%@&uname=%@",shareModel.video_course,shareid,uname];
                }else if (shareType == 2){ //音频
                    
                    mes.link = [NSString stringWithFormat:@"%@&id=%@&uname=%@",shareModel.audio_course,shareid,uname];
                }else if (shareType == 3){ //套餐
                    
                    mes.link = [NSString stringWithFormat:@"%@&id=%@&uname=%@",shareModel.packages,shareid,uname];
                    
                    
                    
                }else if (shareType == 4){ //直播

                    mes.link = [NSString stringWithFormat:@"%@&id=%@&from=singlemessage&uname=%@&isappinstalled=0",shareModel.live,shareid,uname];
                }
                
                if (type == ShareTypeQQ) {
                    
                    mes.link = shareModel.down;
                    [OpenShare shareToQQFriends:mes Success:success Fail:fail];
                }else if (type == ShareTypeQQSpace){
                    
                    mes.link = shareModel.down;
                    [OpenShare shareToQQZone:mes Success:success Fail:fail];
                } else if (type == ShareTypeWX || type == ShareTypeWXSpace) {
                      WXWebpageObject *webpageObject = [WXWebpageObject object];
                    webpageObject.webpageUrl = mes.link;
               
                WXMediaMessage *message = [WXMediaMessage message];
                    message.title = mes.title;
                    message.description = mes.desc;
                    [message setThumbImage:mes.image];
                message.mediaObject = webpageObject;

                    
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.bText = NO;
                req.message = message;
                    if (type == ShareTypeWX) {
                        req.scene = WXSceneSession;
                        
                    }
                    if (type == ShareTypeWXSpace) {
                        req.scene = WXSceneTimeline;
                        
                    }
                [WXApi sendReq:req completion:^(BOOL success) {
                    NSLog(@"ssssss");
                }];
                }
                
//                else if (type == ShareTypeWX){
//
//                    [OpenShare shareToWeixinSession:mes Success:success Fail:fail];
//                }else if (type == ShareTypeWXSpace){
//
//                    [OpenShare shareToWeixinTimeline:mes Success:success Fail:fail];
//                }
                
            } Success:^(OSMessage *message) {
                NSLog(@"%@",message.desc);

                
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"%@",error.description);
            }];
        }
        
    }];
}

- (void)ShareGroupshareImgUrl:(NSString *)imgUrl shareUrl:(NSString *)urlStr withTitle:(NSString *)title  Success:(shareSuccess)success Fail:(shareFail)fail{
    //placeholder_method_call//

    OSMessage *mes = [[OSMessage alloc] init];
    mes.title = @"只为您分享有价值的信息！";
    mes.title = title;

    mes.desc = @"只为您分享有价值的信息！";

            
    if (imgUrl && imgUrl.length > 0) {
            NSURL *url = APP_IMG(imgUrl);
             UIImage *img = [ProcessImg getImageFromURL:url];
       img = [ProcessImg imageCompressForWidthScale:img targetWidth:288];
        img = [ProcessImg compressImage:img toByte:32765];

        NSLog(@"%f,%f",img.size.width,img.size.height);
        mes.thumbnail = img;
        mes.image = img;
        

    } else {
        

        mes.thumbnail = [UIImage imageNamed:@"app_logo"];
         mes.image = [UIImage imageNamed:@"app_logo"];
    }
    mes.multimediaType = OSMultimediaTypeNews;
    

    [[SilenceShareUtil shareUtil] showShareViews:@[@(ShareTypeWX),@(ShareTypeWXSpace),@(ShareTypeQQ),@(ShareTypeQQSpace)] shareMsg:mes HandleShareClick:^(ShareType type) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *uname = [user objectForKey:@"uname"];;
        mes.link = [NSString stringWithFormat:@"%@&uname=%@",urlStr,uname];

       
        
        if (type == ShareTypeQQ) {
            
            
            [OpenShare shareToQQFriends:mes Success:success Fail:fail];
        }else if (type == ShareTypeQQSpace){
            
            
            [OpenShare shareToQQZone:mes Success:success Fail:fail];
        } else if (type == ShareTypeWX || type == ShareTypeWXSpace) {
              WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = mes.link;
       
        WXMediaMessage *message = [WXMediaMessage message];
            message.title = mes.title;
            message.description = mes.desc;
            [message setThumbImage:mes.image];
        message.mediaObject = webpageObject;

            
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
            if (type == ShareTypeWX) {
                req.scene = WXSceneSession;
                
            }
            if (type == ShareTypeWXSpace) {
                req.scene = WXSceneTimeline;
                
            }
        [WXApi sendReq:req completion:^(BOOL success) {
            NSLog(@"ssssss");
        }];
        }
        
//                else if (type == ShareTypeWX){
//
//                    [OpenShare shareToWeixinSession:mes Success:success Fail:fail];
//                }else if (type == ShareTypeWXSpace){
//
//                    [OpenShare shareToWeixinTimeline:mes Success:success Fail:fail];
//                }
        
    } Success:^(OSMessage *message) {
        NSLog(@"%@",message.desc);

        
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}


- (void)shareImgUrl:(NSString *)imgUrl andSuccess:(shareSuccess)success Fail:(shareFail)fail{
    //placeholder_method_call//

    [[SilenceShareUtil shareUtil] showShareViews:@[@(ShareTypeWX),@(ShareTypeWXSpace)] shareMsg:nil HandleShareClick:^(ShareType type) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *uname = [user objectForKey:@"uname"];;
        
        
        
        if (type == ShareTypeQQ) {
            
          
        }else if (type == ShareTypeQQSpace){
            
           
        } else if (type == ShareTypeWX || type == ShareTypeWXSpace) {
            
            
            //1.创建多媒体消息结构体
                WXMediaMessage *mediaMsg = [WXMediaMessage message];
                //2.创建多媒体消息中包含的图片数据对象
                WXImageObject *imgObj = [WXImageObject object];
                //图片真实数据
                imgObj.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
                //多媒体数据对象
                mediaMsg.mediaObject = imgObj;
                
                //3.创建发送消息至微信终端程序的消息结构体
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                //多媒体消息的内容
                req.message = mediaMsg;
                //指定为发送多媒体消息（不能同时发送文本和多媒体消息，两者只能选其一）
                req.bText = NO;
                //指定发送到会话(聊天界面)
            if (type == ShareTypeWX) {
                req.scene = WXSceneSession;
                
            }
            if (type == ShareTypeWXSpace) {
                req.scene = WXSceneTimeline;
                
            }
        [WXApi sendReq:req completion:^(BOOL success) {
            NSLog(@"ssssss");
        }];
        }
        
//                else if (type == ShareTypeWX){
//
//                    [OpenShare shareToWeixinSession:mes Success:success Fail:fail];
//                }else if (type == ShareTypeWXSpace){
//
//                    [OpenShare shareToWeixinTimeline:mes Success:success Fail:fail];
//                }
        
    } Success:^(OSMessage *message) {
        NSLog(@"%@",message.desc);

        
    } Fail:^(OSMessage *message, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}



#pragma mark - 私有方法

/**
 设置返回按钮
 */
-(void)setBackBtn{
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, 30, 80);
    [btn setImage:[UIImage imageNamed:@"ic_return"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [btn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
   //placeholder_method_call//
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    self.leftButton = btn;
}

- (void)BackHome:(NSInteger)selectIndex{

    self.appDelegate.mainVC.selectedIndex = selectIndex;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GoLiveRoom:(NSString *)liveId liveState:(NSInteger)livestate{
    
    //    状态 1-直播中 2-待直播 3-已结束 4.查看回放
    if (livestate == 1 || livestate == 4) {
        
        [APPRequest POST:@"/accessToken" parameters:@{@"id":liveId} finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
                
                //    状态 1-直播中 2-待直播 3-已结束， 4 回放
                if (livestate == 1) {
                    
                    //   跳转到直播界面
                    TalkfunViewController *TalkfunView = [[TalkfunViewController alloc ]init];
                    
                    NSMutableDictionary *data = [NSMutableDictionary dictionary];
                    
                    [data setObject:result.data[@"access_token"] forKey:@"access_token"];
                    
                    
                    NSMutableDictionary *result = [NSMutableDictionary dictionary];
                    [result setObject:data forKey:@"data"];
                    [result setObject:@(0) forKey:@"code"];
                    
                    TalkfunView.res = result;
                    
                    [self presentViewController:TalkfunView animated:NO completion:nil];
                }else if (livestate == 4){
                    
                    //   跳转到点播 界面
                    TalkfunPlaybackViewController *playbackVC = [[TalkfunPlaybackViewController alloc ]init];
//                    playbackVC.BlockBackClick = ^{
//
////                        [self.navigationController setNavigationBarHidden:NO animated:nil];
//                        [APPLICATION setStatusBarHidden:NO];
//                    };
                    playbackVC.playbackID = liveId;
                    
                    NSMutableDictionary *data = [NSMutableDictionary dictionary];
                    
                    [data setObject:result.data[@"access_token"] forKey:@"access_token"];
                    [data setObject:liveId forKey:@"TalkfunPlaybackID"];
                    
                    
                    NSMutableDictionary *result = [NSMutableDictionary dictionary];
                    [result setObject:data forKey:@"data"];
                    [result setObject:@(0) forKey:@"code"];
                    
                    playbackVC.res = result;
                    //                @{@"data":@{@"access_token":access_token},TalkfunPlaybackID:liveid};
                    
                    //    [self presentViewController:playbackVC animated:NO completion:nil];
                    playbackVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:playbackVC animated:NO completion:nil];
                }
            }
        }];
    }else{
        
        [KeyWindow showTip:@"直播还未开始!"];
    }
}

//底部默认尾视图
- (UIView *)getDefaultFootView:(CGPoint)point{
    
    CGFloat Footheight = 50;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, SCREEN_WIDTH, Footheight)];
    footerView.backgroundColor = kColor_BG;
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Footheight)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"北京脚印互动科技有限公司";
    lblTitle.hidden = NO;
    lblTitle.font = [UIFont systemFontOfSize:13.0];
    lblTitle.textColor = RGB(192, 196, 204);
    [footerView addSubview:lblTitle];
    
    return footerView;
}


#pragma mark - get set

@end

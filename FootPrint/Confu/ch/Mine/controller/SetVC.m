//
//  SetVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SetVC.h"
#import "AboutVC.h"
#import "UIAlertController+Blocks.h"
#import "QrCdeView.h"
#import "SetModel.h"
#import "BindVC.h"
#import "SZKCleanCache.h"
#import "UIAlertController+Blocks.h"
#import "JPushNotification.h"
#import "MessageDetailVC.h"
#import "VersionModel.h"
#import "YCDownloadManager.h"

@interface SetVC ()

@property (nonnull, strong) SetModel *model;

@end

@implementation SetVC
//placeholder_method_impl//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    
    
    [self.view addSubview:[self getDefaultFootView:CGPointMake(0, SCREEN_HEIGHT-KNavAndStatusHight-50)]];
    
    self.lblCache.text = [NSString stringWithFormat:@"%.2fM",[SZKCleanCache folderSizeAtPath]];
    //placeholder_method_call//

    self.btnPlay.onTintColor = RGB(23, 125, 255);
    [self.btnPlay addTarget:self action:@selector(PlaySwitchClick:) forControlEvents:(UIControlEventValueChanged)];
    [self.btnPlay setOn:KIsTrafficPlay];
    
    self.btnDownLoad.onTintColor = RGB(23, 125, 255);
    [self.btnDownLoad addTarget:self action:@selector(DownLoadSwitchClick:) forControlEvents:(UIControlEventValueChanged)];
    [self.btnDownLoad setOn:KIsTrafficDownLoad];
}

- (void)PlaySwitchClick:(UISwitch *)sender{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (KIsTrafficPlay) {
        //placeholder_method_call//

        [user setBool:NO forKey:@"isTrafficPlay"];
    }else{
        
        [user setBool:YES forKey:@"isTrafficPlay"];
    }
    [user synchronize];
}

- (void)DownLoadSwitchClick:(UISwitch *)sender{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (KIsTrafficDownLoad) {
        
        [user setBool:NO forKey:@"isTrafficDownLoad"];
    }else{
        //placeholder_method_call//

        [user setBool:YES forKey:@"isTrafficDownLoad"];
    }
    [user synchronize];
    
    [YCDownloadManager allowsCellularAccess:KIsTrafficDownLoad];
}

- (void)loadData{
    
    [APPRequest GET:@"/user/Linkour" parameters:nil finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [SetModel mj_objectWithKeyValues:result.data];
            if (KTour) {
                self.lblBind.text = @"游客";

            } else {
                self.lblBind.text = @"换绑手机";
//                if ([self.model.mobile_bind integerValue] == 0) { //1:绑定 0:未绑定手机号
//                    self.lblBind.text = @"点击绑定手机";
//                }else{
//
//                    self.lblBind.text = self.model.user_mobile;
//                }
            }
        }
    }];
    //placeholder_method_call//
//    if (![isAudit isEqualToString:@"no"]) {
//        return;
//    }
//    [APPRequest GET:@"/versionInfo" parameters:nil finished:^(AjaxResult *result) {
//
//        if (result.code == AjaxResultStateSuccess) {
//
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            // app版本号
//            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            // 后台版本号
//            VersionModel *model = [VersionModel mj_objectWithKeyValues:result.data];
//            if ([app_Version isEqualToString:model.version]) {
//
//                self.lblVersion.text = [NSString stringWithFormat:@"版本%@",model.version];
//                self.lblVersion.textColor = RGB(144, 147, 153);
//            }else{
//
//                self.lblVersion.text = [NSString stringWithFormat:@"最新版%@",model.version];
//                self.lblVersion.textColor = RGB(0, 136, 255);
//            }
//        }
//    }];
}
//placeholder_method_impl//
- (IBAction)btnOperationClick:(UIButton *)sender {
    
    
    if (sender.tag == 101) { //
        //placeholder_method_call//
        if (KTour) {
            return;
        }
        BindVC *next = [[BindVC alloc] init];
        next.phone = self.model.user_mobile;
        next.bindStatus = 1;
//        next.BlockBackClick = ^{
//
//            [self loadData];
//        };
        [self.navigationController pushViewController:next animated:YES];
        
        
        
        
        
        
    }  if (sender.tag == 102) { //
        //placeholder_method_call//
        if (KTour) {
            return;
        }
        BindVC *next = [[BindVC alloc] init];
        next.nickname = self.model.nickname;
        next.bindStatus = 2;
//        next.BlockBackClick = ^{
//
//            [self loadData];
//        };
        [self.navigationController pushViewController:next animated:YES];
    }
    
    
    else if (sender.tag == 103){ //

        MessageDetailVC *next = [[MessageDetailVC alloc] init];
        next.requsetStr = self.model.aboutus;
        [self.navigationController pushViewController:next animated:YES];
    }else if (sender.tag == 104){ //
        return;
        AboutVC *next = [[AboutVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }else if (sender.tag == 106){ //关注微信
        
        QrCdeView *view = [[[NSBundle mainBundle] loadNibNamed:@"QrCdeView" owner:nil options:nil] lastObject];
        [view.imgCode sd_setImageWithURL:APP_IMG(self.model.wechat)];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [KeyWindow addSubview:view];
    }else if (sender.tag == 105){  //清除缓存
    
        [UIAlertController showActionSheetInViewController:self withTitle:@"是否清除缓存" message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除缓存" otherButtonTitles:nil popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
            
            NSLog(@"");
        } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [SZKCleanCache cleanCache:^{
                    
                    [KeyWindow showTip:@"清除成功"];
                    self.lblCache.text = [NSString stringWithFormat:@"%.2fM",[SZKCleanCache folderSizeAtPath]];
                }];
            }
        }];
    }
}
//placeholder_method_impl//
//placeholder_method_impl//
- (IBAction)btnGooutClick:(id)sender {
    //placeholder_method_call//

    [UIAlertController showAlertInViewController:self withTitle:@"是否退出登录" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"token"];
            
            [userDefaults synchronize];
            [APPUserDefault removeCurrentUserFromLocal];
            [[JPushNotification shareJPushNotification] logoutJPush];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LoginOut object:nil];
        }
    }];
}
//placeholder_method_impl//
//placeholder_method_impl//
@end

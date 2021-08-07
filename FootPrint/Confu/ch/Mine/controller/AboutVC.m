//
//  AboutVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "AboutVC.h"
#import "VersionModel.h"
#import <StoreKit/StoreKit.h>
#import "UpVersionView.h"

@interface AboutVC ()<SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) VersionModel *model;

@end

@implementation AboutVC
//placeholder_method_impl//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"脚印云课";
    //placeholder_method_call//

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

- (void)loadData{
    
    [APPRequest GET:@"/versionInfo" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本号
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            self.lblVersion.text = [NSString stringWithFormat:@"Version %@",app_Version];
            
            // 后台版本号
            self.model = [VersionModel mj_objectWithKeyValues:result.data];
            if ([app_Version isEqualToString:self.model.version]) {
                
                self.lblVersionStatus.text = @"已是最新版本";
                self.lblVersionStatus.textColor = RGB(144, 147, 153);
            }else{
                
                self.lblVersionStatus.text = [NSString stringWithFormat:@"发现新版本%@",self.model.version];
                self.lblVersionStatus.textColor = RGB(0, 136, 255);
            }
        }
    }];
}

- (IBAction)btnGoUpDataClick:(id)sender {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本号
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //placeholder_method_call//

    if ([app_Version isEqualToString:self.model.version]) {
        
        [KeyWindow showTip:@"已是最新版本"];
    }else{
        
        UpVersionView *view = [[[NSBundle mainBundle] loadNibNamed:@"UpVersionView" owner:nil options:nil] lastObject];
        view.model = self.model;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.BlockClick = ^{
            
            SKStoreProductViewController *storeVC = [[SKStoreProductViewController alloc] init];
            storeVC.delegate = self;
            [KeyWindow showLoadingHUD];
            //    1459075725
            [storeVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"1459075725"} completionBlock:^(BOOL result, NSError * _Nullable error) {
                [KeyWindow hiddenLoading];
                if(error){
                    
                    [KeyWindow showTip:[NSString stringWithFormat:@"%@",error]];
                }else{
                    //模态弹出appstore
                    [self presentViewController:storeVC animated:YES completion:nil];
                }
            }];
        };
        [KeyWindow addSubview:view];
    }
}
//placeholder_method_impl//
#pragma  mark -- SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    //placeholder_method_call//

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//placeholder_method_impl//
@end

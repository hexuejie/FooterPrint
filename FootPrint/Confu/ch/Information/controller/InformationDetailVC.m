//
//  InformationDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "InformationDetailVC.h"
#import "InformationfootModel.h"
#import "SilenceWebViewUtil.h"
#import "InformationVC.h"

@interface InformationDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) InformationDetailModel *model;

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@end

@implementation InformationDetailVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"资讯详情";
    //placeholder_method_call//

    
    [self loadData];
}
//placeholder_method_impl//

- (void)leftButtonClick{
    
    InformationVC *vc = self.presentingViewController;

    if ([vc isKindOfClass:[MainTabBarController class]]){
        //placeholder_method_call//

        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (!vc.presentingViewController){
        
        return;
    }

    while (vc.presentingViewController)  {
        vc = vc.presentingViewController;
    }

    [vc dismissViewControllerAnimated:YES completion:nil];
}
//placeholder_method_impl//


- (void)loadData{
    
    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:self.webView];
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.delegate = self;
    //placeholder_method_call//

    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.clipsToBounds = NO;
    self.webView.clipsToBounds = NO;
    
    [APPRequest GET:@"/artinfo" parameters:@{@"id":self.informationId} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [InformationDetailModel mj_objectWithKeyValues:result.data];
            [self loadDataView];
        }
    }];
}
//placeholder_method_impl//

- (void)loadDataView{
    
    if (self.model.prev_article) {
        //placeholder_method_call//

        self.lblLastTitle.text = self.model.prev_article.title;
        self.viewLast.hidden = NO;
        self.csViewLastHeight.constant = 50;
    }
    if (self.model.next_article) {
        
        self.lblNextTitle.text = self.model.next_article.title;
        self.viewNext.hidden = NO;
        self.csViewNextHeight.constant = 50;
    }
    
    self.lblTitle.text = self.model.title;
    self.lblTime.text = self.model.update_time;
    self.lblNum.text = self.model.views;
    
    self.model.content = [self.model.content stringByReplacingOccurrencesOfString:@"width: 780px" withString:@"width: auto"]; //
    
    WS(weakself);
    [self.webView loadHTMLString:self.model.content baseURL:nil];
    [self.webViewUtil setContent:self.model.content heightBlock:^(CGFloat h) {

        weakself.csWebViewHeight.constant = h + 32;
    }];
}

- (IBAction)btnOperationClick:(UIButton *)sender {
    
    if (sender.tag == 101) { //上一篇
        
        if (self.model.prev_article) {
            //placeholder_method_call//

            CATransition *animation = [CATransition animation];
            animation.duration = 1.0;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"pageCurl";
            //animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:animation forKey:nil];
            InformationDetailVC *next = [[InformationDetailVC alloc] init];
            next.informationId = self.model.prev_article.id;
            //        self presentm
            UINavigationController *Navnext = [[UINavigationController alloc] initWithRootViewController:next];
            [self presentViewController:Navnext animated:animation completion:nil];

        }
    }else if (sender.tag == 102){ //下一篇

        if (self.model.next_article) {

            CATransition *animation = [CATransition animation];
            animation.duration = 1.0;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"pageUnCurl";
            //animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromLeft;
            [self.view.window.layer addAnimation:animation forKey:nil];
            InformationDetailVC *next = [[InformationDetailVC alloc] init];
            next.informationId = self.model.next_article.id;
            UINavigationController *Navnext = [[UINavigationController alloc] initWithRootViewController:next];
            [self presentViewController:Navnext animated:animation completion:nil];
        }
    }
}
//placeholder_method_impl//


- (UIModalPresentationStyle)modalPresentationStyle{
    //placeholder_method_call//

    return UIModalPresentationFullScreen;
}
//placeholder_method_impl//

@end

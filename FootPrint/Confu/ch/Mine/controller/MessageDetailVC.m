//
//  MessageDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MessageDetailVC.h"
#import "SilenceWebViewUtil.h"
#import "ShopMessageModel.h"

#define FootViewHeight 50

@interface MessageDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) ShopMessageModel *model;

@end

@implementation MessageDetailVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:self.webView];
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    //placeholder_method_call//

    self.footerView = [self getDefaultFootView:CGPointMake(0, 0)];
    self.footerView.backgroundColor = [UIColor whiteColor];
    
    if (self.messageId) {
        //placeholder_method_call//

        self.title = @"公告详情";
        [self loadData];
    }else if(self.requsetUrl){
        
        self.title = @"脚印云课";
       [self setContentUrl:self.requsetUrl];
    }else if(self.requsetStr){
        
        self.title = @"关于我们";
        [self setContentStr:self.requsetStr];
    }
}
//placeholder_method_impl//

- (void)loadData{
    
    
    [APPRequest GET:@"/user/notice" parameters:@{@"id":self.messageId,} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [ShopMessageModel mj_objectWithKeyValues:result.data];
            [self setContentStr:self.model.content];
        }
    }];
}
//placeholder_method_impl//


- (void)setContentStr:(NSString *)contentStr{
    
    WS(weakself);
    //placeholder_method_call//
    NSString *contentUrl = [NSString stringWithFormat:@"<html> \n"
                                    "<head> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                                    "<style type=\"text/css\"> \n"
                                    "body {font-size:14px;}\n"
                                    "span{line-height:20px;}\n"
                                    "p{line-height:20px;}\n"
                                     "textarea{line-height:20px;}\n"
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
                                    "</body>"
                                    "</html>", contentStr];

    [self.webViewUtil setContent:contentUrl heightBlock:^(CGFloat h) {
        
        if (h > weakself.webView.height) {
            
            h = h+66;
        }
        weakself.webView.scrollView.contentSize = CGSizeMake(0, h);
        weakself.webView.scrollView.contentOffset = CGPointMake(0, 1);
        [weakself.view addSubview:weakself.footerView];
    }];
}

- (void)setContentUrl:(NSString *)contentUrl{
    
    WS(weakself);
    //placeholder_method_call//

    [self.webViewUtil setRequstUrl:contentUrl heightBlock:^(CGFloat h) {
        
        if (h > weakself.webView.height) {
            
            h = h+66;
        }
        weakself.webView.scrollView.contentSize = CGSizeMake(0, h);
        weakself.webView.scrollView.contentOffset = CGPointMake(0, 1);
        [weakself.view addSubview:weakself.footerView];
    }];
}
//placeholder_method_impl//

//滑动监听 判断底部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int totalHeightOfScrollView = scrollView.contentSize.height - FootViewHeight;
    float footerViewY = (totalHeightOfScrollView - scrollView.contentOffset.y);
    float footerViewX = 0;
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    //placeholder_method_call//

    if (bottomEdge >= scrollView.contentSize.height) {
        footerViewY = scrollView.frame.size.height - FootViewHeight;
    }
    
    if (SCREEN_WIDTH < self.view.frame.size.width) {
        footerViewX = (self.view.frame.size.width/2)-(SCREEN_WIDTH/2);
    }
    self.footerView.frame = CGRectMake(footerViewX, footerViewY+16, SCREEN_WIDTH, FootViewHeight);
}
//placeholder_method_impl//

@end

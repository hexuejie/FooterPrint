//
//  CourseIntroduceVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseIntroduceVC.h"
#import "SilenceWebViewUtil.h"

#define FootViewHeight 50

@interface CourseIntroduceVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) BOOL showIntroduct;

@end

@implementation CourseIntroduceVC{
    BOOL criticality; // 判断当前的是否滑动的
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //placeholder_method_call//

    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:self.webView];
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.footerView = [self getDefaultFootView:CGPointMake(0, 0)];
//     [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.webViewUtil) {
        [self loadWebPage];
    }
    
}

- (void)loadWebPage {
    
    
    if (self.contentUrl.length > 0) {
        NSString *html = [NSString stringWithFormat:@"<html> \n"
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
                                         "<br/><br/><br/><br/>"
                                         "</body>"
                                         "</html>", self.contentUrl];
        WS(weakself)

        [self.webViewUtil setContent:html heightBlock:^(CGFloat h) {
            
            if (h > weakself.webView.height) {

               h = h+ 116;

            }
            weakself.webView.scrollView.contentSize = CGSizeMake(0, h + 50);
            weakself.webView.scrollView.contentOffset = CGPointMake(0, 1);
            [weakself.view addSubview:weakself.footerView];
        }];
    }
    
}

//placeholder_method_impl//

- (void)setContentUrl:(NSString *)contentUrl{
    //placeholder_method_call//

    _contentUrl = contentUrl;
    if (self.webViewUtil) {
        [self loadWebPage];
    }
    
   
}
//placeholder_method_impl//


//滑动监听 判断底部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    int totalHeightOfScrollView = scrollView.contentSize.height - FootViewHeight;
    int totalHeightOfScrollView = scrollView.contentSize.height ;
//placeholder_method_call//

    float footerViewY = (totalHeightOfScrollView - scrollView.contentOffset.y);
    float footerViewX = 0;
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;

    if (bottomEdge >= scrollView.contentSize.height) {

    }

    if (SCREEN_WIDTH < self.view.frame.size.width) {
        footerViewX = (self.view.frame.size.width/2)-(SCREEN_WIDTH/2);
        
    }
    self.footerView.frame = CGRectMake(footerViewX, footerViewY-FootViewHeight+16, SCREEN_WIDTH, FootViewHeight);
}
//placeholder_method_impl//


- (void)delaySecond {
//    self.webView.scrollView.contentSize = CGSizeMake(0, webViewSize.height);
//placeholder_method_call//

}
//placeholder_method_impl//

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
if ([keyPath isEqualToString:@"contentSize"]) {
    //placeholder_method_call//

//    CGSize webViewSize = [self.webView sizeThatFits:CGSizeZero];
//    if (self.webView != nil) {
//        [self performSelector:@selector(delaySecond) withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
//
//    }
//    NSLog(@"%f",webViewSize.height);
//    self.webView.scrollView.contentSize = webViewSize;
//    _webView.frame = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.x, _webView.size.width, webViewSize.height);
//    self.csWebViewHeight.constant = webViewSize.height;
//    int totalHeightOfScrollView = webViewSize.height - FootViewHeight;
//    float footerViewY = (totalHeightOfScrollView - self.webView.scrollView.contentOffset.y);
//       float footerViewX = 0;
//       float bottomEdge = self.webView.scrollView.contentOffset.y + self.webView.scrollView.frame.size.height;
//
//       if (bottomEdge >= self.webView.scrollView.contentSize.height) {
//           footerViewY = self.webView.scrollView.frame.size.height - FootViewHeight;
//       }
//
//       if (SCREEN_WIDTH < self.view.frame.size.width) {
//           footerViewX = (self.view.frame.size.width/2)-(SCREEN_WIDTH/2);
//       }
//       self.footerView.frame = CGRectMake(footerViewX, footerViewY-FootViewHeight+16, SCREEN_WIDTH, FootViewHeight);

}
}
@end

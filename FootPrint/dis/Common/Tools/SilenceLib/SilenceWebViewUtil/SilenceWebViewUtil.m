//
//  SilenceWebViewUtil.m
//  webView内容自适应工具类
//
//  Created by Silence on 2016/12/22.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "SilenceWebViewUtil.h"

@interface SilenceWebViewUtil()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic , weak) WKWebView *webView;
@property (nonatomic , strong) NSString *content;
@end

@implementation SilenceWebViewUtil

-(instancetype)initWithWebView:(WKWebView *)webView{
    self = [super init];
    if (self ) {
        self.webView = webView;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        self.webView.scrollView.scrollEnabled = NO;
      

    }
    return self;
}

-(void)setContent:(NSString *)content heightBlock:(void (^)(CGFloat))heightBlock{
    
   
    self.content = content;
    self.heightBlock = heightBlock;
    [self.webView loadHTMLString:content baseURL:nil];
//    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setRequstUrl:(NSString *)requesturl heightBlock:(void (^)(CGFloat))heightBlock{
    NSURL *url =[NSURL URLWithString:requesturl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    self.heightBlock = heightBlock;
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    CGRect wvFrame = webView.frame;
//    NSLog(@"original wvFrame: %@\n", NSStringFromCGRect(wvFrame));
//    [webView sizeToFit];
//    NSLog(@"wvFrame after sizeToFit: %@\n", NSStringFromCGRect(wvFrame));
//    wvFrame.size.height = 1.0;
//    webView.frame = wvFrame;
//    CGSize sz = [webView sizeThatFits:CGSizeZero];
//    NSLog(@"sizeThatFits A: %@\n", NSStringFromCGSize(sz));
//    sz = CGSizeMake(wvFrame.size.width, 0.0);
//    sz = [webView sizeThatFits:sz];
//    NSLog(@"sizeThatFits B: %@\n", NSStringFromCGSize(sz));
//
//    self.heightBlock(sz.height);

    
    
    WS(weakself)
    [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable complete, NSError * _Nullable error) {
        if (complete != nil) {
            [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable height, NSError * _Nullable error) {
                weakself.heightBlock([height doubleValue]);
            }];
        }


    }];
//    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
//
//    [webView evaluateJavaScript:meta completionHandler:nil];
//
//
//    [webView evaluateJavaScript:
//     @"var tagHead =document.documentElement.firstChild;"
//    "var tagMeta = document.createElement(\"meta\");"
//    "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
//    "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
//    "var tagHeadAdd = tagHead.appendChild(tagMeta);"
//              completionHandler:nil];
//
//
//    [webView evaluateJavaScript:
//         @"var tagHead =document.documentElement.firstChild;"
//           "var tagStyle = document.createElement(\"style\");"
//           "tagStyle.setAttribute(\"type\", \"text/css\");"
//           "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 0pt 0pt;margin:0}\"));"
//           "var tagHeadAdd = tagHead.appendChild(tagStyle);"
//                 completionHandler:nil];
//
//

//
//      NSString *str = [NSString stringWithFormat:
//                       @"var script = document.createElement('script');"
//                               "script.type = 'text/javascript';"
//                                "script.text = \"function ResizeImages() { "
//                                "var myimg,oldwidth;"
//
//                       "var maxwidth = %f;"
//                       "for(i=0;i <document.images.length;i++){"
//                               "myimg = document.images[i];"
//                               "if(myimg.width > maxwidth){"
//                               "oldwidth = myimg.width;"
//                               "myimg.width = maxwidth;"
//                               "}"
//                               "}"
//                               "}\";"
//                       "document.getElementsByTagName('head')[0].appendChild(script);"
//
//                       ,width];
//
//  NSString *js= [NSString stringWithFormat:@"var script = document.createElement('script');"
//   "script.type = 'text/javascript';"
//    "script.text = \"function ResizeImages() { "
//   "var myimg,oldwidth;"
//   "var maxwidth = %f;"
//  "for(i=0;i <document.images.length;i++){"
//  "myimg = document.images[i];"
//  "if(myimg.width > maxwidth){"
//  "oldwidth = myimg.width;"
//  "myimg.width = %f;"
//  "}"
//  "}"
//      "}\";",width,width];
//
//
//
//     // 缩放系数
//    [webView evaluateJavaScript:js completionHandler:nil];
    
//      [ webView evaluateJavaScript:
//        @"var script = document.createElement('script');"
//          "script.type = 'text/javascript';"
//          "script.text = \"function ResizeImages() { "
//          "var myimg,oldwidth;"
//          "var maxwidth=document.body.clientWidth;" //缩放系数
//          "for(i=0;i <document.images.length;i++){"
//          "myimg = document.images[i];"
//          "if(myimg.width > maxwidth){"
//          "oldwidth = myimg.width;"
//          "oldheight = myimg.height;"
//          "myimg.style.width = maxwidth;"
//          "myimg.style.height = maxwidth * (oldheight / oldwidth);"
//          "}"
//          "}"
//          "}\";"
//          "document.getElementsByTagName('head')[0].appendChild(script);"
//                 completionHandler:nil];


//    // 字体大小
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"completionHandler:nil];
//
//    //设置颜色
//      [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'" completionHandler:nil];
  
    //     [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    
//    [webView evaluateJavaScript:@"ResizeImages();" completionHandler:nil];
    
//    NSString *heightString4 = @"document.body.scrollHeight";
//    [self.webView evaluateJavaScript:heightString4 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"html 的高度：%@", result);
//        self.heightBlock([result doubleValue]);
//    }];
    
    
//    [self.webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable complete, NSError * _Nullable error) {
        

        
//        if (complete != nil) {
//             [self.webView evaluateJavaScript:@"document.body.scrollWidth" completionHandler:^(id _Nullable weight, NSError * _Nullable error) {
//                            NSLog(@"weight =%@",weight);
//                         CGFloat ratio =  self.webView.width /[weight floatValue];
//
//
//                    [self.webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable height, NSError * _Nullable error) {
//                                 NSLog(@"height =%@",height);
//                           float  actualHeight = [height floatValue]*ratio;
//                                                   NSLog(@"scrollHeight高度：%.2f",[height floatValue]*ratio);
//
//                                             if (self.heightBlock != nil) {
//                 //                                  self.heightBlock([height floatValue] );
//
//                                                 self.heightBlock(actualHeight);
//                                               }
//
//                             }];
//
//
//
//                        }];
//
//
//
//
//
//
//        }
//
//
//    }];
    
}
 
#pragma mark  - KVO回调
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//
//    //更具内容的高重置webView视图的高度
//    NSLog(@"Height is changed! new=%@", [change valueForKey:NSKeyValueChangeNewKey]);
//    NSLog(@"tianxia :%@",NSStringFromCGSize(self.webView.scrollView.contentSize));
//    CGFloat newHeight = self.webView.scrollView.contentSize.height;
//
//     self.heightBlock(newHeight);
//}
//


@end

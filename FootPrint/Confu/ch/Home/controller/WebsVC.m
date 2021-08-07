//
//  WebsVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/1/23.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "WebsVC.h"
#import <WebKit/WebKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface WebsVC ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *  webView;
@property (nonatomic,strong)NSString *redirect_url;
@end

@implementation WebsVC

#pragma mark - 生命周期
//placeholder_method_impl//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.webView];
//    self.webView.scrollView.backgroundColor = kColor_Green;
//    self.webView.backgroundColor = kColor_Green;
//    [self.webView evaluateJavaScript:@"document.body.style.backgroundColor=\"#00AF63\"" completionHandler:nil];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    //placeholder_method_call//
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    
    
}
//注意：遵守WKScriptMessageHandler协议，代理是由WKUserContentControl设置

//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    
    // js 调 oc
    /*
     name:sendToWechat\\n body:(
             {
             url = "https://jiaoyin-static-web-pro.oss-cn-beijing.aliyuncs.com/images/service.png";
         },
     */
   
   
   
    // 查看订单
    if ([message.name isEqualToString:@"sendToWechat"]) {
        NSArray *arr = message.body;
       NSString *st =  arr[0][@"url"];
        NSLog(@"%@",st);
        [self shareImgUrl:st andSuccess:^(OSMessage *message) {
                    
                } Fail:^(OSMessage *message, NSError *error) {
                    
                }];
               
            
    }
    if ([message.name isEqualToString:@"closePage"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}
- (void)viewOrderFunction:(NSString *)body {
    
    
//
//    OrderDetailVC *next = [[OrderDetailVC alloc] init];
//          next.orderId = body;
//          next.goodsType =1;
//          [self.navigationController pushViewController:next animated:YES];
//
//     OrderListVC *orderListVC = [[OrderListVC alloc]init];
//    orderListVC.title = body;
//        [self.navigationController pushViewController:orderListVC animated:true];
//
}

//placeholder_method_impl//
- (void)viewDidAppear:(BOOL)animated{
    
//    [self.navigationController.navigationBar navBarBackGroundColor:kColor_Green image:nil isOpaque:YES];//导航栏背景颜色
    
    //导航栏标题字体大小，颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 如果当前页面有登录成功就跳转到主控制器


    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"closePage"];
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"sendToWechat"];

}
//placeholder_method_impl//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//






- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *absoluteString = navigationAction.request.URL.absoluteString;
    NSString *scheme = navigationAction.request.URL.scheme;
    NSLog(@"%@",absoluteString);
    // https://maoke.com/?order_number=2020060519525448529&redirect_url=https%3A%2F%2Ftest.maoke123.com%2Fwechat%2Fordersubmit%2Fordersubmit%3Ftype%3Dcourse%26entrance%3Ddetail%26goods_type%3D1%26id%3D149%26order_sn%3D2020060519525448529%26is_expirence%3D1
    // //          NSArray *arr = [absoluteString componentsSeparatedByString:@"redirect_url="];
    //        self.redirect_url = arr[1];
     
    
    
  
    
    decisionHandler(WKNavigationActionPolicyAllow);

    
}




// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    
    //placeholder_method_call//
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self getCookie];
}
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //placeholder_method_call//
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

//解决 页面内跳转（a标签等）还是取不到cookie的问题
- (void)getCookie{
    
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    
    //执行js
    [_webView evaluateJavaScript:JSCookieString completionHandler:nil];
}

#pragma mark - 私有方法

#pragma mark - get set

- (WKWebView *)webView{
    
    if(_webView == nil){
        
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        //placeholder_method_call//
        //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
//        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理
//        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
//        [config.userContentController addScriptMessageHandler:self  name:@"shareEvent"];
//        [config.userContentController addScriptMessageHandler:self  name:@"lookData"];
//        [config.userContentController addScriptMessageHandler:self name:@"iosLogin"];
//        [config.userContentController addScriptMessageHandler:self name:@"payment"];
        [config.userContentController addScriptMessageHandler:self name:@"closePage"];
        [config.userContentController addScriptMessageHandler:self name:@"sendToWechat"];

//        config.userContentController = wkUController;
        
        //以下代码适配文本大小
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
        // UI代理
//        _webView.UIDelegate = self;
        // 导航代理
//        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        
        
        _webView.navigationDelegate = self;
 
        if (self.index == 2) {
               self.navigationItem.title = @"签单工具";
               [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://download-app.jiaoyin.vip/jiaoyin/tools/home/?aaa2#/home"]]];
           } else if (self.index == 3) {
              
               self.navigationItem.title = @"联系客服";
               [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://download-app.jiaoyin.vip/jiaoyin/tools/home/?aaa3#/service-page"]]];
           } else if (self.index == 4) {
               
               self.navigationItem.title = @"我的收益";
               [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://download-app.jiaoyin.vip/jiaoyin/ykhtml?token=%@",Ktoken]]]];
           }
        
        
    }
    return _webView;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@",message);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

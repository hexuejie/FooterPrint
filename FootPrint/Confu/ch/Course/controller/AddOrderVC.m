//
//  AddOrderVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "AddOrderVC.h"
#import "AddOrderFooterModel.h"
#import "CouponView.h"
#import "PayModel.h"
#import "CouponFootModel.h"
#import "PayCompleteVC.h"
#import "PayModel2.h"
#import <WebKit/WebKit.h>
#import "TogetcherVC.h"
@interface AddOrderVC ()<WKNavigationDelegate>

@property (nonatomic, strong) AddOrderFooterModel *model;

@property (nonatomic, strong) CouponView *couponView;

@property (nonatomic, strong) CouponFootModel *couponModel;

@property (nonatomic, assign) BOOL isSelectCoupon;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, strong) OrderIntegralFooterModel *integraModel;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) NSInteger isload;
@property (nonatomic, strong) NSString *redirect_url;

@end

@implementation AddOrderVC
- (WKWebView *)webView{
//placeholder_method_call//

    if (_webView == nil) {
                          WKUserContentController *wkUController = [[WKUserContentController alloc] init];
     WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
                 wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1) configuration:wkWebConfig];
         _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor clearColor];
    }

    return _webView;
}

//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

#pragma mark - yy类注释逻辑
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![isAudit isEqualToString:@"no"]) {
          
          self.lblInfo.hidden = YES;
          self.csLblInfoHeight.constant = 16;
          
          self.lblObtainInterfral.hidden = YES;
          self.csLblInterfralHeight.constant = 16;
          
          self.viewCoupons.hidden = YES;
          self.csviewCouponsHeight.constant = 0;
          
          self.viewIntegra.hidden = YES;
          self.csViewIntegraHeight.constant = 0;
          
          self.viewWX.hidden = YES;
          self.csViewWXHeight.constant = 0;
          
          self.viewZFB.hidden = YES;
          self.csViewZFBHeight.constant = 0;
          
          self.viewGold.hidden = NO;
          self.csviewGoldHeight.constant = 50;
          
          UIButton *btn = [self.view viewWithTag:103];
          btn.selected = YES;
      }else{
      
          self.lblInfo.hidden = NO;
          self.csLblInfoHeight.constant = 48;
          
          self.lblObtainInterfral.hidden = NO;
          self.csLblInterfralHeight.constant = 48;
          
          self.viewCoupons.hidden = NO;
          self.csviewCouponsHeight.constant = 50;
          
          self.viewIntegra.hidden = NO;
          self.csViewIntegraHeight.constant = 50;
          
          self.viewWX.hidden = NO;
          self.csViewWXHeight.constant = 50;
          
          self.viewGold.hidden = YES;
          self.csviewGoldHeight.constant = 0;
          

      }
}
- (UIImage *)imageWithColor:(UIColor *)color andUIImageage:(UIImage *)img {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"确认订单";
    
    [self.view addSubview:self.webView];
    //placeholder_method_call//

    self.payType = 1; //默认
    
    self.btnSwitch.onTintColor = RGB(23, 125, 255);
    [self.btnSwitch addTarget:self action:@selector(switchClick:) forControlEvents:(UIControlEventValueChanged)];
 // ic_add btnaddcou
   UIImage *img = [UIImage imageNamed:@"ic_add"];
    img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
    [self.btnAddCoupons setImage:img forState:UIControlStateNormal];
    
    
    [self loadData];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//


#pragma mark - 生命周期

#pragma mark - 代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
        NSString *absoluteString = navigationAction.request.URL.absoluteString;

        NSString *scheme = navigationAction.request.URL.scheme;
    NSLog(@"absoluteString=%@",absoluteString);
    NSLog(@"scheme=%@",scheme);
    
    
  
// we         ix         in
 if ([scheme hasPrefix:@"weix"] && [scheme hasSuffix:@"in"]) {


        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL];
        if (canOpen) {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        }
       decisionHandler(WKNavigationActionPolicyCancel);
       return;
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}
//    NSString *absoluteString = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
//    NSString *scheme = navigationAction.request.URL.scheme;
//        NSURLRequest *request        = navigationAction.request;
//     static NSString *endPayRedirectURL = nil;
//      if ([absoluteString hasPrefix:@"https://wx.t"] && ![absoluteString hasSuffix:[NSString stringWithFormat:@"redirect_url=%@",Wechat_Jump]]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        NSString *redirectUrl = nil;
//        if ([absoluteString containsString:@"redirect_url="]) {
//            NSRange redirectRange = [absoluteString rangeOfString:@"redirect_url"];
//            endPayRedirectURL =  [absoluteString substringFromIndex:redirectRange.location+redirectRange.length+1];
//            redirectUrl = [[absoluteString substringToIndex:redirectRange.location] stringByAppendingString:[NSString stringWithFormat:@"redirect_url=%@",Wechat_Jump]];
//        }else {
//            redirectUrl = [absoluteString stringByAppendingString:[NSString stringWithFormat:@"&redirect_url=%@",Wechat_Jump]];
//        }
//
//        NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:redirectUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//        newRequest.allHTTPHeaderFields = request.allHTTPHeaderFields;
//        newRequest.URL = [NSURL URLWithString:redirectUrl];
//        [webView loadRequest:newRequest];
//        return;
//    }
//
//
//    if (![scheme isEqualToString:@"https"] && ![scheme isEqualToString:@"http"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        if ([scheme isEqualToString:@"weixin"]) {
//            // The var endPayRedirectURL was our saved origin url's redirect address. We need to load it when we return from wechat client.
//            if (endPayRedirectURL) {
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:endPayRedirectURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]];
//            }
//        }else if ([scheme isEqualToString:[NSString stringWithFormat:@"%@",Wechat_Jump]]) {
//
//        }
//
//        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:request.URL];
//        if (canOpen) {
//            [[UIApplication sharedApplication] openURL:request.URL];
//        }
//        return;
//    }
//
//    decisionHandler(WKNavigationActionPolicyAllow);
    
//}

#pragma mark 系统代理

//  OC 做URLEncode的方法
-  (NSString *)URLEncodeString:(NSString*)str {
    NSString *unencodedString = str;
    
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString*)URLDecodedString:(NSString*)str {
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

#pragma mark 自定义代理
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

#pragma mark - 事件

- (void)switchClick:(UISwitch *)sender{
    
    if ([self.integraModel.status integerValue] != 1){ //未开启
     
        [KeyWindow showTip:@"暂不支持积分抵扣"];
        [sender setOn:NO];
        return;
    }
    //placeholder_method_call//

    if ([self.integraModel.deducted_integral integerValue] == 0) { //0积分
        
        [KeyWindow showTip:@"0积分可用"];
        [sender setOn:NO];
        return;
    }
        
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.model.orderInfo.price forKeyedSubscript:@"old_price"];
    [param setObject:self.couponModel.minus forKeyedSubscript:@"coupon_minus"];
    [param setObject:self.btnSwitch.isOn?@"1":@"0" forKeyedSubscript:@"is_switch"];
    
    [KeyWindow showLoadingHUD];;
    [APPRequest GET:@"/api/app/checkIntergral" parameters:param finished:^(AjaxResult *result) {
       
        [KeyWindow hideLoadingHUD];
        if (result.code == AjaxResultStateSuccess) {
           
            self.integraModel = [OrderIntegralFooterModel mj_objectWithKeyValues:result.data];
            self.lblPrice.text = [self.integraModel.order_price ChangeMoney];
            
            if (self.btnSwitch.isOn) {
                
                self.lblIntegralMoeny.text = [NSString stringWithFormat:@"-¥ %@",self.integraModel.deducted_money];
            }else{
                
                self.lblIntegralMoeny.text = @"";
            }
        }
    }];
}

- (IBAction)btntypeClick:(UIButton *)sender {
    
    for (int i=1; i<3; i++) {
        //placeholder_method_call//
        UIButton *btn = [self.view viewWithTag:100+i];
        if (btn.tag == sender.tag) {
            
            self.payType = btn.tag - 100;
            btn.selected = YES;
        }else{
            
            btn.selected = NO;
        }
    }
}

- (IBAction)btnAddCoupons:(id)sender {
    
    if (self.isSelectCoupon) {
        
        self.couponModel.minus = @"0";
        //placeholder_method_call//
        self.lblCouponMoney.text = @"";
        self.lblDiscount.text = @"";
        [self.btnAddCoupons setTitle:@"添加" forState:UIControlStateNormal];
        [self.btnAddCoupons setImage:[UIImage imageNamed:@"ic_add"] forState:UIControlStateNormal];
        self.isSelectCoupon = NO;
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:self.model.orderInfo.price forKeyedSubscript:@"old_price"];
        [param setObject:self.couponModel.minus forKeyedSubscript:@"coupon_minus"];
        [param setObject:self.btnSwitch.isOn?@"1":@"0" forKeyedSubscript:@"is_switch"];
        
        [KeyWindow showLoadingHUD];;
        [APPRequest GET:@"/api/app/checkIntergral" parameters:param finished:^(AjaxResult *result) {
            
            [KeyWindow hideLoadingHUD];
            if (result.code == AjaxResultStateSuccess) {
                
                self.integraModel = [OrderIntegralFooterModel mj_objectWithKeyValues:result.data];
                [self upDataView];
            }
        }];
    }else{
        
        [KeyWindow addSubview:self.couponView];
    }
}

- (IBAction)btnBuyClick:(id)sender {
    
    [KeyWindow showNormalLoadingWithTip:@"订单支付中"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //placeholder_method_call//
    [param setObject:@"ios" forKey:@"source"];
    if (self.couponModel) {
        [param setObject:self.couponModel.coupon_code forKey:@"coupon_code"];
    }
    [param setObject:self.goodsId forKey:@"item_id"];
    [param setObject:self.btnSwitch.isOn?@"1":@"0" forKey:@"is_switch"];
    [param setObject:self.goodsType forKey:@"order_type"];
    
    if (self.order_sn.length != 0) { //有订单
        
        [self payOrder];
    }else{
        if (self.group && self.group.length > 0) {
                [param setObject:self.group forKey:@"group"];
                
            }
            
            if (self.group_join_id && self.group_join_id.length > 0) {
                [param setObject:self.group_join_id forKey:@"group_join_id"];
            }
        
        
        
        //生成订单
        [APPRequest POST:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
            
            [KeyWindow hiddenLoading];
            if (result.code == AjaxResultStateSuccess) {
                
                //订单号
                self.order_sn = result.data[@"order_sn"];
                [PayModel2 sharedInstance].order_sn = self.order_sn;
                [self payOrder];
            }
        }];
    }
}

#pragma mark - 公开方法
- (void)paySuccessAction {
    if (self.BlockBackClick) {
    self.BlockBackClick();
}
    [self.navigationController popViewControllerAnimated:true];

}
- (void)payOrder{
    
    if (![isAudit isEqualToString:@"no"]) {
        //placeholder_method_call//
        [APPRequest POST:@"/setOrderStatus" parameters:@{@"order_sn":self.order_sn} finished:^(AjaxResult *result) {
            
            [KeyWindow hiddenLoading];
            if (result.code == AjaxResultStateSuccess) {
                
                [KeyWindow showTip:@"支付成功"];
                [self performSelector:@selector(paySuccessAction) withObject:nil afterDelay:1];
              
            }
        }];
    }else{
        
        NSString *price = [self.lblPrice.text stringByReplacingOccurrencesOfString:@"¥" withString:@""];
        price = [price stringByReplacingOccurrencesOfString:@"￥" withString:@""];
        
        if ([price floatValue] <= 0) { //支付价格小于等于0

            if (self.group && self.group.length > 0) { // 拼团成功
                [KeyWindow showTip:@"拼团成功"];

                TogetcherVC * togetcherVC = [[TogetcherVC alloc] init];
                togetcherVC.t_id = self.group_join_id;
                if (self.BlockBackClick) {
                    self.BlockBackClick();
                }
                [self.navigationController popViewControllerAnimated:YES];
                
                
                
            } else { // 单独购买
                [KeyWindow showTip:@"购买成功"];
                if (self.BlockBackClick) {
                    self.BlockBackClick();
                }
                [self.navigationController popViewControllerAnimated:YES];
               
            }
            
           
            return ;
        }
        
        if (self.payType == 1) {
            
            [APPRequest GET:@"/api/app/unifiedorder" parameters:@{@"order_sn":self.order_sn,@"pay_type":@"4"} finished:^(AjaxResult *result) {
                
                [KeyWindow hiddenLoading];
                if (result.code == AjaxResultStateSuccess) {
                    
                    PayModel *model = [PayModel mj_objectWithKeyValues:result.data];
                    
               
                    NSMutableURLRequest * requset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.mweb_url]];
                    
                    [requset addValue:Wechat_Jump forHTTPHeaderField:@"Referer"];
                    // www.92zhiqu.com
                    
                    NSLog(@"mweb_url=%@",model.mweb_url);
                    
                    [self.webView loadRequest:requset];
                }
            }];
        }
        

    }
}

- (void)loadData{
    NSMutableDictionary *params = @{
        @"item_id":self.goodsId,
        @"order_type":self.goodsType,
    }.mutableCopy;
    if (self.group && self.group.length > 0) {
            [params setObject:self.group forKey:@"group"];
            
        }
        
        if (self.group_join_id && self.group_join_id.length > 0) {
            [params setObject:self.group_join_id forKey:@"group_join_id"];
        }
    [APPRequest GET:@"/payOrderInfo" parameters:params finished:^(AjaxResult *result) {
       //placeholder_method_call//
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [AddOrderFooterModel mj_objectWithKeyValues:result.data];
            self.integraModel = self.model.integral_data;
            [self upDataView];
        }
    }];
}

- (void)upDataView{
    //placeholder_method_call//
    if ([self.goodsType isEqualToString:@"usercard"]) {
        
        self.imgView.image = [UIImage imageNamed:@"ic_vip"];
    }else{
        [self.imgView sd_setImageWithURL:APP_IMG(self.model.orderInfo.banner) placeholderImage: [UIImage imageNamed:@"head_default"]];
    }
    
  

    self.lblTitle.text = self.model.orderInfo.title;
    self.lblPrice.text = [self.model.orderInfo.price ChangeMoney];
    
    if ([self.goodsType isEqualToString:@"package"]) {
        
        self.lblInfo.text = @"购买后永久有效";
    }else{
        
        self.lblInfo.text = [NSString stringWithFormat:@"购买后%@有效",self.model.orderInfo.expire_time_str];
    }
    //placeholder_method_call//
    //    积分抵扣开关 1:开启
    if ([self.integraModel.status integerValue] != 1) { // 未开启
        
        self.lblIntegral.text = @"暂不支持积分抵扣";
    }else{
        
        self.lblIntegral.text = [NSString stringWithFormat:@"%@积分可用",self.integraModel.deducted_integral];
    }
    self.lblObtainInterfral.text = [NSString stringWithFormat:@"付款后可获得%@积分",self.integraModel.consume_integral];
    
    if ([self.goodsType isEqualToString:@"course"]) { //课程
        
        self.lblStatus.text = [NSString stringWithFormat:@"%@人在学",self.model.orderInfo.studyUser];
//        [self.btnPrice setTitle:[NSString stringWithFormat:@" ¥%@",] forState:UIControlStateNormal];
        [self.btnPrice setTitle:[self.model.orderInfo.price ChangeMoney] forState:UIControlStateNormal];
        if ([self.model.orderInfo.goods_type integerValue] == 1) { //1:视频 2音频
            
            [self.btnPrice setImage:[UIImage imageNamed:@"course_small_video"] forState:UIControlStateNormal];
      
        }else{
            
            [self.btnPrice setImage:[UIImage imageNamed:@"course_small_audio"] forState:UIControlStateNormal];
        }
    }else if ([self.goodsType isEqualToString:@"usercard"]){
        
        [self.btnPrice setTitle:[self.model.orderInfo.price ChangeMoney] forState:UIControlStateNormal];
        self.lblStatus.text = self.model.orderInfo.expire_time_str;
//        self.lblStatus.font = [UIFont systemFontOfSize:14.0];
//        self.lblStatus.textColor = [UIColor blackColor];
    }
}

#pragma mark - 私有方法

#pragma mark - get set

- (CouponView *)couponView{
    
    if (_couponView == nil) {
        WS(weakself);
        //placeholder_method_call//
        _couponView = [[[NSBundle mainBundle] loadNibNamed:@"CouponView" owner:nil options:nil] lastObject];
        _couponView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _couponView.BlockSubmitClick = ^(NSString * _Nonnull couponCode) {
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:weakself.goodsType forKey:@"order_type"];
            [param setObject:weakself.goodsId forKey:@"item_id"];
            [param setObject:couponCode forKey:@"coupon_code"];
            [param setObject:weakself.btnSwitch.isOn?@"1":@"0" forKey:@"is_switch"];
            [param setObject:weakself.model.orderInfo.price forKey:@"price"];
            
            [KeyWindow showLoadingHUD];
            [APPRequest GET:@"/api/app/checkCode" parameters:param finished:^(AjaxResult *result) {
               
                [KeyWindow hideLoadingHUD];
                weakself.isSelectCoupon = YES;
                if (result.code == AjaxResultStateSuccess) {
                    
                    weakself.couponModel = [CouponFootModel mj_objectWithKeyValues:result.data];
                    weakself.integraModel = [OrderIntegralFooterModel mj_objectWithKeyValues:result.data[@"checkData"]];
                    
                    [weakself upDataView];
                    
                    weakself.lblCouponMoney.text = weakself.couponModel.minus_name;
                    weakself.lblDiscount.text = weakself.couponModel.tip;
                    NSString * coupePrice = weakself.couponModel.order_price;
                    if ([weakself.couponModel.order_price hasPrefix:@"￥"]) {
                        coupePrice =  [weakself.couponModel.order_price substringFromIndex:1];
                    }
                    weakself.lblPrice.text = [coupePrice ChangeMoney];
                    
                    [weakself.btnAddCoupons setImage:[UIImage imageNamed:@"coupon_delect"] forState:UIControlStateNormal];
                    [weakself.btnAddCoupons setTitle:@"" forState:UIControlStateNormal];
                    [weakself.couponView removeFromSuperview];
                }
            }];
        };
    }
    
    return _couponView;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//



@end

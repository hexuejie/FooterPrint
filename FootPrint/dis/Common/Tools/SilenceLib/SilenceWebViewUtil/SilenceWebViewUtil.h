//
//  SilenceWebViewUtil.h
//  webView内容自适应工具类
//
//  Created by Silence on 2016/12/22.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface SilenceWebViewUtil : NSObject

// 返回高度
@property (nonatomic , strong) void(^heightBlock)(CGFloat h);
@property (nonatomic , strong) void(^BlockClick)(NSString *url);

-(instancetype)initWithWebView:(WKWebView *)webView;

-(void)setContent:(NSString *)content heightBlock:(void(^)(CGFloat h)) heightBlock;

-(void)setRequstUrl:(NSString *)requesturl heightBlock:(void(^)(CGFloat h)) heightBlock;

@end

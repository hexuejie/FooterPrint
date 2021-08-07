//
//  JsWKWebView.m
//  GZJ
//
//  Created by 胡翔 on 2020/6/2.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "JsWKWebView.h"

@implementation JsWKWebView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    WKWebViewConfiguration *myConfiguration = [WKWebViewConfiguration new];
    self = [super initWithFrame:frame configuration:myConfiguration];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    return self;
}

@end

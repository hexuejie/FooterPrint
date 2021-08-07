//
//  MessageDetailVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"
#import "JsWKWebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailVC : BaseVC

@property (weak, nonatomic) IBOutlet JsWKWebView *webView;
//placeholder_property//
@property (nonatomic, strong) NSString *messageId;

@property (nonatomic, strong) NSString *requsetUrl;
//placeholder_property//
@property (nonatomic, strong) NSString *requsetStr;

//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

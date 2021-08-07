//
//  InformationDetailVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"
#import <WebKit/WebKit.h>
#import "JsWKWebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface InformationDetailVC : BaseVC

@property (nonatomic, strong) NSString *informationId;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNum;

@property (weak, nonatomic) IBOutlet UIView *webBGView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csWebViewHeight;
@property (weak, nonatomic) IBOutlet JsWKWebView *webView;
//placeholder_property//


@property (weak, nonatomic) IBOutlet UILabel *lblLastTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblNextTitle;
//placeholder_property//
- (IBAction)btnOperationClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewLast;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewLastHeight;

@property (weak, nonatomic) IBOutlet UIView *viewNext;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewNextHeight;
//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//

//placeholder_method_declare//


@end

NS_ASSUME_NONNULL_END

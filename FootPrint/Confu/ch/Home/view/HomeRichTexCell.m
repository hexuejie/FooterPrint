//
//  HomeRichTexCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeRichTexCell.h"
#import "SilenceWebViewUtil.h"
#import <WebKit/WebKit.h>

@interface HomeRichTexCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@property (nonatomic, assign) CGFloat webViewHeight;

@end

@implementation HomeRichTexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//


}
//placeholder_method_impl//
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //placeholder_method_call//

    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self initWebView];
    }
    return self;
}
//placeholder_method_impl//
- (void)initWebView{
    
    UIView *view = [[UIView alloc] init];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3;
    //placeholder_method_call//


    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(12);
        make.trailing.mas_equalTo(-12);
    }];

    WKWebView *webView = [[WKWebView alloc] init];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.scrollEnabled = YES;
    webView.scrollView.delegate = self;

    [view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.leading.mas_equalTo(12);
        make.trailing.mas_equalTo(-12);
    }];

    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:webView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//placeholder_method_impl//
- (void)setModel:(HomelModel *)model{
    
    _model = model;
    
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
                                   "<br/><br/><br/><br/>"
                                   "</body>"
                                   "</html>", model.text];
    

    WS(weakself);
    [self.webViewUtil setContent:contentUrl heightBlock:^(CGFloat h) {

        weakself.height = h+32;
        if (weakself.BlocHeightkClick) {
            weakself.BlocHeightkClick(h+32);
        }
    }];
}

@end

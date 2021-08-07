//
//  ShowView.m
//  MK
//
//  Created by 胡翔 on 2020/5/22.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "ShowView.h"
@interface ShowView()<UITextViewDelegate>

@end

@implementation ShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textView = [[UITextView alloc]initWithFrame:self.bounds];
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
        _textView.delegate = self;
        _textView.textColor = [UIColor colorWithHex:0x333333];
        _textView.editable = NO;//必须禁止输入，否则点击将会弹出输入键盘
        _textView.scrollEnabled = NO;//可选的，视具体情况而定
        [self addSubview:_textView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGestureRecognizer:)];
        [self.textView addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    
    NSString *fullStr = @"个人信息保护引导\n 请充分阅读并理解 \n《隐私政策》和《用户协议》";
    NSString *str1 = @"《隐私政策》";
    NSString *str2 = @"《用户协议》";
    NSString *str3 = @"服务协议和隐私政策";
    _content = fullStr;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:fullStr];
    //    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[fullStr rangeOfString:str]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 7;  //设置行间距
    
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [fullStr length])];
    

    [attStr addAttribute:NSLinkAttributeName  value:@"click1://" range:[fullStr rangeOfString:str1]];
    [attStr addAttribute:NSLinkAttributeName  value:@"click2://" range:[fullStr rangeOfString:str2]];
    [attStr addAttribute:NSFontAttributeName  value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, [fullStr length])];
    
    [attStr addAttribute:NSFontAttributeName  value:[UIFont boldSystemFontOfSize:20] range:[fullStr rangeOfString:str3]];
    
    //      [attStr addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(40, 10)];
    
    _textView.attributedText = attStr;
}



-(void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.textView];
        UITextPosition *textPosition = [self.textView closestPositionToPoint:tapLocation];
        NSDictionary *attributes = [self.textView textStylingAtPosition:textPosition inDirection:UITextStorageDirectionBackward];
        NSURL *url = attributes[NSLinkAttributeName];
        if(url) {
            NSRange range = [self.textView.text rangeOfString:@"《隐私政策》"];
            if (([url isKindOfClass:[NSString class]] && [(NSString *)url containsString:@"click1"])) {
                range = [self.textView.text rangeOfString:@"《隐私政策》"];
            }
            if (([url isKindOfClass:[NSString class]] && [(NSString *)url containsString:@"click2"])) {
                range = [self.textView.text rangeOfString:@"《用户协议》"];
            }
            
            [self  textView:self.textView shouldInteractWithURL:url inRange:range];
            
        }
        
    }
    //    [super addGestureRecognizer:gestureRecognizer];
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
    if ([(NSString *)URL containsString:@"click1"]) {
        if (self.eventBlock) {
            self.eventBlock(1);
        }
        
        return NO;
    }
    if ([(NSString *)URL containsString:@"click2"]) {
        if (self.eventBlock) {
            self.eventBlock(2);
        }
        
        return NO;
    }
    
    
    
    return YES;
}



@end

//
//  CommentView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CommentView.h"
#import "UITextView+PlaceHolder.h"
#import "UITextView+MaxLength.h"

@interface CommentView ()

@end

@implementation CommentView
//placeholder_method_impl//

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self.txtView addPlaceHolder:@"发表你的评论～"];
    self.txtView.backgroundColor  = [UIColor colorWithHex:0xf8f8f8];
    self.txtView.maxLength = 140;
    self.txtView.block = ^(UITextView *textView) {
      
        if (textView.text.length > 140) {
            
            return ;
        }
        if (textView.text.length == 0) {
            
            self.lblTextNum.textColor = [UIColor lightGrayColor];
        }else{
            
            self.lblTextNum.textColor = [UIColor blackColor];
        }
        self.lblTextNum.text = [NSString stringWithFormat:@"%ld",textView.text.length];
    };
    
    [self.viewBg addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [self removeFromSuperview];
    }];
    //placeholder_method_call//

    [self registerForKeyboard];
    [self.txtView becomeFirstResponder];
}
//placeholder_method_impl//

- (IBAction)btnZoomClick:(UIButton *)sender {
    
    sender.selected =! sender.selected;
    if (sender.selected) {
        self.csTxtViewHeight.constant = 200;
    }else{
        
        self.csTxtViewHeight.constant = 50;
    }
    //placeholder_method_call//

}
//placeholder_method_impl//

- (IBAction)btnReleasClick:(id)sender {
    
    [self.txtView resignFirstResponder];
    [self removeFromSuperview];
    //placeholder_method_call//

    if (self.BlockReleasClick) {
        self.BlockReleasClick(self.txtView.text);
    }
}
//placeholder_method_impl//


- (void)registerForKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //placeholder_method_call//

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHiddin:) name:UIKeyboardWillHideNotification object:nil];
}
//placeholder_method_impl//

- (void)keyboardWasShown:(NSNotification *)notif {
    
    NSDictionary *info = [notif userInfo];
    
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize size = [value CGRectValue].size;
    //placeholder_method_call//

    [UIView beginAnimations:@"te" context:nil];
    [UIView setAnimationDuration:[duration doubleValue]];
//    _toolView.frame = CGRectMake(0, maxHeight - size.height - 50, maxWidth, 50);
    self.csViewBottom.constant = size.height;
    
    [UIView commitAnimations];
}
//placeholder_method_impl//

- (void)keyboardWasHiddin:(NSNotification *)notif {
    
    NSDictionary *info = [notif userInfo];
    
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //placeholder_method_call//

    [UIView beginAnimations:@"re" context:nil];
    [UIView setAnimationDuration:[duration doubleValue]];
//    _toolView.frame = CGRectMake(0, maxHeight - 50, maxWidth, 50);
    self.csViewBottom.constant = 0;
    [UIView commitAnimations];
}

@end

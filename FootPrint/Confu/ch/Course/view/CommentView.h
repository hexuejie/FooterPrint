//
//  CommentView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView

- (IBAction)btnZoomClick:(id)sender;
//placeholder_property//
- (IBAction)btnReleasClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblTextNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextView *txtView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewBg;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTxtViewHeight;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csViewBottom;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, copy) void (^BlockReleasClick)(NSString *content);
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

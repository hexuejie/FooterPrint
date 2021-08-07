//
//  QRCodeView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QrCdeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIImageView *imgCode;
//placeholder_property//
- (IBAction)btnCloseClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
- (IBAction)btnSaveClick:(id)sender;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

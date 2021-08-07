//
//  CouponView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/3.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponView : UIView

- (IBAction)btnCloseClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)btnSubmitClick:(id)sender;
//placeholder_property//
@property (nonatomic, copy) void (^BlockSubmitClick)(NSString *couponCode);
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//



@end

NS_ASSUME_NONNULL_END

//
//  PayCompleteVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/9.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayCompleteVC : BaseVC

@property (nonatomic, strong) NSString *payUrl;

- (IBAction)btnSuccessClick:(id)sender;
//placeholder_property//
- (IBAction)btnAgainClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, strong) NSString *order_sn;

@end

NS_ASSUME_NONNULL_END

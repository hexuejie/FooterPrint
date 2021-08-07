//
//  AboutVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AboutVC : BaseVC

@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblVersionStatus;
//placeholder_property//
- (IBAction)btnGoUpDataClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//


@end

NS_ASSUME_NONNULL_END

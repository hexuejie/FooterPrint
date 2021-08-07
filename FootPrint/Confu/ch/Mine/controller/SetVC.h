//
//  SetVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetVC : BaseVC

- (IBAction)btnOperationClick:(id)sender;
//placeholder_property//
- (IBAction)btnGooutClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblBind;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblCache;

@property (weak, nonatomic) IBOutlet UILabel *lblVersion;

@property (weak, nonatomic) IBOutlet UISwitch *btnPlay;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UISwitch *btnDownLoad;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

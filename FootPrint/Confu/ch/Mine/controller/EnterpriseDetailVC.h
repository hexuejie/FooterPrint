//
//  EnterpriseDetailVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnterpriseDetailVC : BaseVC

@property (nonatomic, strong) NSString *sid;
//placeholder_property//
@property (nonatomic, strong) NSString *cid;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblEnterpriseName;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblCreateTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblDueTime;

- (IBAction)btnGoDetailClick:(id)sender;

@end

NS_ASSUME_NONNULL_END

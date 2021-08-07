//
//  UpVersionView.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VersionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UpVersionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
//placeholder_property//
@property (nonatomic, copy) void (^BlockClick)(void);
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, strong) VersionModel *model;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

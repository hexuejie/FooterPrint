//
//  AdudioListVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseTableViewVC.h"
#import "CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdudioListVC : BaseTableViewVC

@property (nonatomic, strong) CourseDetailModel *model;
//placeholder_property//
@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
//placeholder_property//
@property (nonatomic, assign) NSInteger playerRow;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (nonatomic, assign) long is_buy;

@property (nonatomic, copy) void (^BlockAudioClick)(NSInteger index);
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

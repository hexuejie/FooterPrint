//
//  VideoListVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseTableViewVC.h"
#import "CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoListVC : BaseTableViewVC

@property (nonatomic, strong) CourseDetailModel *model;
//placeholder_property//
@property (nonatomic, strong) CoursePlayerFootModel *playerModel;
//placeholder_property//
- (void)setPlayerSection:(NSInteger)section PlayerRow:(NSInteger)row;
//placeholder_method_declare//

//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, copy) void (^BlockVideoClick)(NSInteger section,NSInteger row);
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

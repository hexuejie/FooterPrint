//
//  HomeCourseCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
#import "LiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCourseCell : UITableViewCell
//placeholder_property//
@property (nonatomic, assign) NSInteger type;
//placeholder_property//
@property (nonatomic, strong) NSArray *dataSource;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (nonatomic, copy) void (^BlockCourseClick)(CourslModel *model);
//placeholder_property//
@property (nonatomic, copy) void (^BlockLiveClick)(LiveModel *model);
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

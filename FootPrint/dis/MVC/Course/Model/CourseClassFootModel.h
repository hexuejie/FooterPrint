//
//  CourseClassModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseClassFootModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *cate_name;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *child;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *level;

@end

NS_ASSUME_NONNULL_END

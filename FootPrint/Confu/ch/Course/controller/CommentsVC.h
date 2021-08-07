//
//  CommentsVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseTableViewVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentsVC : BaseTableViewVC

@property (nonatomic, strong) NSString *courseId;

@property (nonatomic, copy) void (^BlockReloadClick)(void);
//placeholder_property//
@property (nonatomic, assign) BOOL isBuy;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@end

NS_ASSUME_NONNULL_END

//
//  HotModel.h
//  FootPrint
//
//  Created by 胡翔 on 2021/3/17.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotModel : NSObject
@property (nonatomic, assign) int closed;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderby;
@property (nonatomic, strong) NSString *update_time;

@end

NS_ASSUME_NONNULL_END

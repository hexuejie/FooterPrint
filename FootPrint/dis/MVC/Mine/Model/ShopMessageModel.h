//
//  ShopMessageModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/20.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopMessageModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *isread;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *targetType;
@property (nonatomic, strong) NSString *tips;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *update_time;

@end

NS_ASSUME_NONNULL_END

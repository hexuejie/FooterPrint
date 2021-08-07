//
//  PayModel2.h
//  GZJ
//
//  Created by 何学杰 on 2020/3/24.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayModel2 : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,copy)NSString *order_sn;


@end

NS_ASSUME_NONNULL_END

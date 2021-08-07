//
//  VersionModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionModel : NSObject

@property (nonatomic, strong) NSString *apk_size;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *down_url;
@property (nonatomic, strong) NSString *force_update;
@property (nonatomic, strong) NSString *version;

@end

NS_ASSUME_NONNULL_END

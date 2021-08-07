//
//  LearnRecordModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LearnRecordModel : NSObject

@property (nonatomic, strong) NSString *allcount;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *course_title;

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *nocount;
@property (nonatomic, strong) NSString *percentage;
@property (nonatomic, strong) NSString *update_date;

@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END

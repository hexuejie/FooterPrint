//
//  HomeCourseModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourslModel : NSObject

@property (nonatomic, strong) NSString *vip_price_text;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *pictures; //f
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) long is_buy;
@property (nonatomic, strong) NSString *spell_price;

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *expire;
@property (nonatomic, strong) NSString *face;

@property (nonatomic, strong) NSString *thumbs;

@property (nonatomic, assign) long is_group;


@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *study_count;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *descs;//f

@property (nonatomic, strong) NSString *users;
@property (nonatomic, strong) NSString *virtual_amount;


@property (nonatomic, strong) NSString *act_status;
@property (nonatomic, strong) NSString *audit;


@property (nonatomic, strong) NSString *closed;
@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *create_time;


@property (nonatomic, assign) long end_time;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderby;

@property (nonatomic, strong) NSString *start_time;

@property (nonatomic, strong) NSString *study_number;

@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, strong) NSString *yh_price;

@property (nonatomic, assign) long diff_time;
@property (nonatomic, assign) long is_limit_course;

@end

NS_ASSUME_NONNULL_END

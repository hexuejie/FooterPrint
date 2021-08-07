//
//  LiveModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveModel : NSObject

@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *s_title;
@property (nonatomic, strong) NSString *s_time_title;
@property (nonatomic, strong) NSString *e_time_title;
@property (nonatomic, strong) NSString *join_text;
@property (nonatomic, strong) NSString *is_vip;
@property (nonatomic, strong) NSString *is_buy;
@property (nonatomic, strong) NSString *vip_switch;

@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSString *closed;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *details;

@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *hty_course_id;
@property (nonatomic, strong) NSString *hty_info;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *is_rebate;
@property (nonatomic, strong) NSString *is_usetype;
@property (nonatomic, strong) NSString *join;
@property (nonatomic, strong) NSString *live_state;
@property (nonatomic, strong) NSString *live_status;

@property (nonatomic, strong) NSString *live_title;
@property (nonatomic, strong) NSString *live_url;
@property (nonatomic, strong) NSString *online_base;
@property (nonatomic, strong) NSString *phone_binding;
@property (nonatomic, strong) NSString *playback;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *publish_url;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *remind;
@property (nonatomic, strong) NSString *score;

@property (nonatomic, strong) NSString *sell_alone;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *stream_key;
@property (nonatomic, strong) NSString *stream_time;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *wxmincode;
@property (nonatomic, strong) NSString *yend_time;

@end

@interface TeachersModel : NSObject

@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSString *username;

@end

NS_ASSUME_NONNULL_END

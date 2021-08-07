//
//  CourseDetailModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/13.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoursePlayerFootModel : NSObject

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_new;
@property (nonatomic, strong) NSString *lenght;
@property (nonatomic, assign) long duration;
@property (nonatomic, assign) long second;

@property (nonatomic, strong) NSString *study_status; // 学习状态 0未学习 1学习中 2已学完
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *timeText;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *transcoding_path;
@property (nonatomic, strong) NSString *download_path;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *live_id;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *live_state;


@property (nonatomic, assign) BOOL isSelect;

/**
 缓存唯一ID
 */
@property (nonatomic, strong) NSString *did;


@property (nonatomic, strong) NSString *audio_path;
@property (nonatomic, strong) NSString *audio_title;
@property (nonatomic, strong) NSString *audio_desc;
@property (nonatomic, strong) NSString *course_banner;
@property (nonatomic, strong) NSString *course_title;

+ (NSMutableArray <CoursePlayerFootModel *> *)getVideoListInfo:(NSArray <NSDictionary *>*)listInfos;

+ (NSData *)dateWithInfoModel:(CoursePlayerFootModel *)mo;
+ (CoursePlayerFootModel *)infoWithData:(NSData *)data;

@end


@interface CourseChapterModel : JKDBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *cate_name;
@property (nonatomic, strong) NSString *chapter_switch;
@property (nonatomic, strong) NSArray<CoursePlayerFootModel *> *video_list;

@end

@interface ChannelModel : JKDBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *is_free;
@property (nonatomic, strong) NSString *last_time;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *tid;

@end
@interface GroupUserModel:NSObject
@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *create_date;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) long is_commander;
@property (nonatomic, assign) long is_pay;
@property (nonatomic, assign) long is_robot;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *update_date;
@property (nonatomic, strong) NSString *update_time;


@end
//@interface CountModel:NSObject
//@property (nonatomic, assign) long count;
//@end
@interface JoinGroupUserModel:NSObject
@property (nonatomic, assign) long count;
@property (nonatomic, strong) NSArray<GroupUserModel *> *group_user;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *order_count;
@end

@interface GroupModel:NSObject
@property (nonatomic, assign) long end_time;
@property (nonatomic, assign) long group_status;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) JoinGroupUserModel *join_group_user;

@property (nonatomic, assign) long is_group;
@property (nonatomic, strong) NSString *join_group_id;
@property (nonatomic, assign) bool join_group_status;
@property (nonatomic, assign) long now_time;
@property (nonatomic, assign) long spell_num;
@property (nonatomic, strong) NSString *spell_price;
@property (nonatomic, assign) long start_time;
@property (nonatomic, assign) long valid_time;
@end
@interface GroupingModel:NSObject
@property (nonatomic, assign) long end_time;
@property (nonatomic, assign) long group_num;
@property (nonatomic, strong) NSString *head_face;
@property (nonatomic, strong) NSString *head_nickname;
@property (nonatomic, strong) NSString *head_uid;
@property (nonatomic, assign) long now_time;
@property (nonatomic, assign) long order_group_num;
@property (nonatomic, strong) NSString *spell_items_id;
@end
@interface CourseDetailModel : JKDBModel

@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSArray<CourseChapterModel *> *chapter_video;
@property (nonatomic, strong) NSArray<CoursePlayerFootModel *> *chapter_audio;
@property (nonatomic, strong) NSString *checkbuy;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, assign) long is_group;
@property (nonatomic, assign) long is_open;
@property (nonatomic, assign) long goods_ratio;
@property (nonatomic, assign) long is_discount;
@property (nonatomic, strong) NSString *share_url;

@property (nonatomic, strong) GroupModel *group;
@property (nonatomic, assign) long is_rebate;
@property (nonatomic, strong) NSArray<GroupingModel *> *grouping;

@property (nonatomic, strong) ChannelModel *curChannel; // 不为空说明有学习记录
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *is_vip;
@property (nonatomic, strong) NSString *yh_price;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *study_count;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *vip_switch;
@property (nonatomic, strong) NSString *virtual_amount;

@property (nonatomic, strong) NSString *content;


@property (nonatomic, strong) NSString *comment_total;
@property (nonatomic, strong) NSString *download;
@property (nonatomic, assign) long end_time;


@property (nonatomic, assign) BOOL isSelect;

@end



NS_ASSUME_NONNULL_END

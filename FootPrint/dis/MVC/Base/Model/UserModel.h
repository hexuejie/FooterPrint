//
//  UserModel.h
//  VegetableBasket
//
//  Created by 陈小卫 on 17/1/16.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "JKDBModel.h"

@interface UserInfoModel : JKDBModel

@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *uid;

@end

@interface WeekModel : JKDBModel

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *is_day;
@property (strong, nonatomic) NSString *study;
@property (strong, nonatomic) NSString *week;

@end

@interface UserModel : JKDBModel

@property (strong, nonatomic) NSString *expire_time;
@property (strong, nonatomic) NSString *havecard;
@property (strong, nonatomic) NSString *is_rebate;
@property (strong, nonatomic) NSString *is_sign;
@property (strong, nonatomic) NSString *is_agent;
@property (strong, nonatomic) NSString *agent_img;
@property (strong, nonatomic) NSString *message_num;

//@property (strong, nonatomic) NSString *new_comment_num;
@property (strong, nonatomic) NSString *now_integral;
@property (strong, nonatomic) NSString *study_complete;
@property (strong, nonatomic) UserInfoModel *user;
@property (strong, nonatomic) NSString *vip;

@property (strong, nonatomic) NSArray<WeekModel *> *week;

@end

//
//  SaleModel.h
//  FootPrint
//
//  Created by 胡翔 on 2021/4/29.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleModel : NSObject
@property (nonatomic, strong) NSString *act_status;
@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *banner;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *closed;
@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *diff_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *goods_type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderby;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *study_count;
@property (nonatomic, strong) NSString *study_number;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *virtual_amount;
@property (nonatomic, strong) NSString *yh_price;
/*
 
 "act_status" = 3;
 audit = 1;
 banner = "/public/uploads/image/course/20210205/e9fdafc00f2fae47c75cd67a1311bf42.jpeg";
 cid = 65;
 closed = 0;
 "course_id" = 65;
 "create_time" = "2021-04-27 16:24:17";
 desc = "\U5c31\U5730\U8fc7\U5e74\U2014\U2014\U5982\U4f55\U628a\U63e1\U6700\U597d\U7684\U7ecf\U8425\U65f6\U673a";
 "diff_time" = 0;
 "end_time" = 0;
 free = 0;
 "goods_type" = 1;
 id = 16;
 orderby = 9;
 price = "1.00";
 "start_time" = 0;
 "study_count" = 312;
 "study_number" = 812;
 title = "\U5c31\U5730\U8fc7\U5e74\U2014\U2014\U5982\U4f55\U628a\U63e1\U6700\U597d\U7684\U7ecf\U8425\U65f6\U673a";
 "update_time" = "2021-04-27 16:24:17";
 "virtual_amount" = 500;
 "yh_price" = "0.00";
}
 */
@end

NS_ASSUME_NONNULL_END

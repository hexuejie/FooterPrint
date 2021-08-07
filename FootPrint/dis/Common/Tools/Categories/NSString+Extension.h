//
//  NSString+Extension.h
//  Yoobaby
//
//  Created by feizhuo on 14-7-12.
//  Copyright (c) 2014年 feizhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 判断字符串是否为空 */
-(BOOL) isNullOrEmpty;

/** if null then set string @"" then return */
-(NSString *) isNullThenSetEmpty;

-(NSString *) trim;

/** MD5加密 */
- (NSString *)md5;

/** url编码 */
- (NSString *)urlencode;

/** 距离描述 */
-(NSString *) distanceDescription;
-(NSString *) remaindTimeDescription;

/** 日期字符串转时间 */
-(NSDate *) dateWithFormat:(NSString *) formatString;

/** 返回标准日期格式字符串 yyyy/MM/dd */
-(NSString *) dateString;
-(NSString *) timeString;
-(NSString *) dateTimeString:(NSString *) formatString;


//手机加密中间四位 前三后四
-(NSString *)phoneEncrypt;

//去掉小数点后0
-(NSString *) stringFormatMoney;

/**
 *  计算大小
 */
- (NSInteger)fileSize;

@end

//
//  NSString+Extension.m
//  Yoobaby
//
//  Created by feizhuo on 14-7-12.
//  Copyright (c) 2014年 feizhuo. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

-(BOOL) isNullOrEmpty {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

-(NSString *) isNullThenSetEmpty
{
    if (self == nil || self == NULL) {
        return @"";
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    return self;
}

-(NSString *) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


-(NSString *)md5
{
//    const char *cStr = [self UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]];
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

- (NSString *)urlencode
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

-(NSString *) distanceDescription
{
    CGFloat distance = [self floatValue];
    if (distance < 1000) {
        return [NSString stringWithFormat:@"%.0f米", distance];
    }
    else if (1000 <= distance)
    {
        return [NSString stringWithFormat:@"%.1f千米", distance / 1000];
    }
    else
    {
        return nil;
    }
}

-(NSString *) remaindTimeDescription
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *date = [format dateFromString:self];
    long interval = (long)date.timeIntervalSinceNow;
    
    const NSInteger day = 60 * 60 * 24;
    const NSInteger hour = 60 * 60;
    const NSInteger minitues = 60;
    
    if (interval / day > 0) {
        return [NSString stringWithFormat:@"%ld天%ld小时%ld分", interval / day, interval % day / hour, interval % hour / minitues];
    }
    else if(interval / hour > 0){
        return [NSString stringWithFormat:@"%ld小时%ld分", interval / hour, interval % hour / minitues];
    }
    else if(interval / minitues > 0){
        return [NSString stringWithFormat:@"%ld分%ld秒", interval / minitues,  interval % minitues];
    }
    else{
        return [NSString stringWithFormat:@"%ld秒", interval];
    }
}

-(NSDate *) dateWithFormat:(NSString *) formatString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init] ;
    [format setDateFormat:formatString];
    
    return [format dateFromString:self];
}

-(NSString *) dateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date = [format dateFromString:self];
    [format setDateFormat:@"yyyy/MM/dd"];
    
    if (!date) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [format dateFromString:self];
        [format setDateFormat:@"yyyy-MM-dd"];
    }
    
    
    
    NSString *dateStr = [format stringFromDate: date];
    
    return dateStr;
}

-(NSString *) timeString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date = [format dateFromString:self];
    [format setDateFormat:@"HH:mm"];
    
    if (!date) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [format dateFromString:self];
        [format setDateFormat:@"HH:mm"];
    }
    
    NSString *dateStr = [format stringFromDate: date];
    
    return dateStr;
}

-(NSString *) dateTimeString:(NSString *) formatString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date = [format dateFromString:self];
    [format setDateFormat:formatString];
    
    if (!date) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [format dateFromString:self];
        [format setDateFormat:formatString];
    }
    
    NSString *dateStr = [format stringFromDate: date];
    
    return dateStr;
}

-(NSString*)phoneEncrypt{
    NSMutableString *str = self.mutableCopy;
    if (str.length == 11) {
        [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return str;
}

//去掉小数点后0
-(NSString *) stringFormatMoney{
    NSString *str = self.mutableCopy;
    if ([str doubleValue] - [str integerValue] > 0) {
        if ([str rangeOfString:@"."].location == NSNotFound) {
            return str;
        }else{
            str = [NSString stringWithFormat:@"%.2f",[str doubleValue]];
            return [[str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@"0"];
        }
    }else{
        return [NSString stringWithFormat:@"%ld",[str integerValue]];
    }
}

// 判断一个路径是文件夹 or 文件
//    [[mgr attributesOfItemAtPath:self error:nil].fileType isEqualToString:NSFileTypeDirectory];

- (NSInteger)fileSize
{
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 是否为文件夹
    BOOL isDirectory = NO;
    // 这个路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 路径不存在
    if (exists == NO) return 0;
    
    if (isDirectory) { // 文件夹
        // 总大小
        NSInteger size = 0;
        // 获得文件夹中的所有内容
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 获得文件属性
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return size;
    } else { // 文件
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
}


@end

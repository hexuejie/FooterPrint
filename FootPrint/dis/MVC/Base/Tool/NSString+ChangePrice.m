//
//  NSString+ChangePrice.m
//  YXGJ
//
//  Created by YyMacBookPro on 2018/11/16.
//  Copyright © 2018年 cscs. All rights reserved.
//

#import "NSString+ChangePrice.h"

@implementation NSString (ChangePrice)

- (NSString *)ChangePrice{

    if (![isAudit isEqualToString:@"no"]) {
        
        if ([self containsString:@"免费"]) {
            
            return self;
        }else{
            
            NSString *gold = self;
            gold = [gold stringByReplacingOccurrencesOfString:@"¥" withString:@""];
            gold = [gold stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            
            if ([gold floatValue] <= 0) {
                
                return @"免费";
            }
            return [NSString stringWithFormat:@"%@学习金",gold];
        }

    }else{
     
        if([self containsString:@"¥"] || [self containsString:@"免费"] || [self containsString:@"￥"]) {
            
            return self;
        }else{
            
            if ([self floatValue] <= 0) {
                
                return @"免费";
            }else{
                
                return [NSString stringWithFormat:@"¥ %@",self];
            }
        }
    }
    
    return self;
}

- (NSString *)ChangeMoney{
    
    if (![isAudit isEqualToString:@"no"]) {
        
        NSString *gold = self;
        gold = [gold stringByReplacingOccurrencesOfString:@"¥" withString:@""];
        gold = [gold stringByReplacingOccurrencesOfString:@"￥" withString:@""];
        
        return [NSString stringWithFormat:@" %@学习金",gold];
        
    }else{
        
        return [NSString stringWithFormat:@"¥ %@",self];
    }
    
    return self;
}

//NSDecimalNumber *deNum = [NSDecimalNumber decimalNumberWithString:self];
//NSNumberFormatter *formort = [NSNumberFormatter new];
//formort.maximumFractionDigits = 2;
//formort.minimumFractionDigits = 0;
//formort.minimumIntegerDigits = 1;
//NSString *str = [NSString stringWithFormat:@"%@",[formort stringFromNumber:deNum]];
//
//if (str.length == 0) {
//
//    return @"";
//}
//return str;

@end

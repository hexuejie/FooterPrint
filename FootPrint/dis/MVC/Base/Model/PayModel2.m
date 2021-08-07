//
//  PayModel2.m
//  GZJ
//
//  Created by 何学杰 on 2020/3/24.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "PayModel2.h"

static PayModel2 *session;
static dispatch_once_t onceToken;

@implementation PayModel2

+ (instancetype)sharedInstance{
    dispatch_once(&onceToken, ^{
        if (session == nil) {
            session = [[PayModel2 alloc] init];
        }
    });
    return session;
}
@end

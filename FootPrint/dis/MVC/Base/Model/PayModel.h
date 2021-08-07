//
//  PayModel.h
//  Yizhen
//
//  Created by 陈小卫 on 17/5/16.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PayModel : NSObject

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *mch_id;
@property (nonatomic, strong) NSString *nonceStr;
@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *prepay_id;

@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *sign2;
@property (nonatomic, strong) NSString *signType;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *timeStamp;

@property (nonatomic, strong) NSString *mweb_url;

@end


//
//  APPNavUtil.h
//  Dy
//
//  Created by 陈小卫 on 16/6/29.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLocation.h"

@interface APPNavUtil : NSObject


-(void)navInView:(UIView *)inView fromLocation:(UserLocation *)from toLocation:(UserLocation *)to;

@end

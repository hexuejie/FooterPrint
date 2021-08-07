//
//  ShareContent.h
//  FzShop
//  分享对象
//  Created by Silence on 2017/2/16.
//  Copyright © 2017年 FzShop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareContent : NSObject
@property(nonatomic, strong) NSString *share_id;
@property(nonatomic, strong) NSString *share_logo;
@property(nonatomic, strong) NSString *share_title;
@property(nonatomic, strong) NSString *share_content;
@property(nonatomic, strong) NSString *share_url;

@property(nonatomic, strong) UIImage *shareImg;
@end


//返回字段	类型	说明
//share_id	字符串	编号
//share_logo	字符串	Logo
//share_title	字符串	标题
//share_content	字符串	内容

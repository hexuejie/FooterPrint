//
//  HomeModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomelModel : NSObject

@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *footsequences; //f

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type_name;
@property (nonatomic, strong) NSString *show_more;
@property (nonatomic, strong) NSString *footshowtime; // f
@property (nonatomic, strong) NSString *group_id;

@property (nonatomic, strong) NSString *show_type;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *content;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *footfaced;

@property (nonatomic, assign) BOOL isUpHeight;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSArray *list;
@end

NS_ASSUME_NONNULL_END

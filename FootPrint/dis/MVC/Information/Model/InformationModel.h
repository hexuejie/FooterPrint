//
//  InformationModel.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationScreeninmodel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;

@end

@interface InformationfootModel : NSObject

@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *photopath;
@property (nonatomic, strong) NSString *footphotopath;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *views;

@end

@interface InformationDetailModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *foottitle;

@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) InformationfootModel *next_article;
@property (nonatomic, strong) InformationfootModel *prev_article;

@end

NS_ASSUME_NONNULL_END

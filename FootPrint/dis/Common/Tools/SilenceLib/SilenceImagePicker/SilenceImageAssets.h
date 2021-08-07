//
//  SilenceImageAssets.h
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 16/6/27.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAsset.h>
#import <UIKit/UIKit.h>
@interface SilenceImageAssets : NSObject
//唯一标识
@property (nonatomic, strong) NSString *identifier;
//资源对象
@property (nonatomic, strong) ALAsset *asset;
//普通图片
@property (nonatomic, strong) UIImage *image;
//原始图片
@property (nonatomic, strong) UIImage *originalImage;

// 根据图片的唯一标识获取压缩后的图片
+(void)getImagesByIdentifiers:(NSArray<NSString *> *) identifiers completion:(void (^)(NSArray<UIImage *> *images))completion;

// 根据图片的唯一标识获取压缩后的图片，返回键值对
+(void)getImageMapByIdentifiers:(NSArray<NSString *> *) identifiers completion:(void (^)(NSMutableDictionary *imageValues))completion;

@end

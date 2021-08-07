//
//  SilenceImagePreview.h
//  SilenceIOS_OC
//
//  Created by SilenceMac on 16/6/29.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SilenceImagePreview : UIViewController
//用户点击的图片的索引
@property (nonatomic, assign) NSInteger currentIndex;
/**
 *  图片资源 可以是 urlString/NSURL/UIImage 对象
 */
@property (strong,nonatomic) NSArray *imgs;

@end

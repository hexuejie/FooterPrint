//
//  SilenceImagePreviewCell.h
//  SilenceIOS_OC
//
//  Created by SilenceMac on 16/6/29.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SilenceImagePreviewCell : UICollectionViewCell
@property (nonatomic, copy) void (^singleTapGestureBlock)();
@property (nonatomic, copy) void (^longPressGestureRecognizerBlock)(UIImage *img);

@property (strong,nonatomic) id imgData;
@end

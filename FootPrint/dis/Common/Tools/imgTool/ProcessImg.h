//
//  ProcessImg.h
//  GZJ
//
//  Created by 胡翔 on 2020/4/16.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProcessImg : NSObject
+(UIImage *) getImageFromURL:(NSString *)fileURL;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end

NS_ASSUME_NONNULL_END

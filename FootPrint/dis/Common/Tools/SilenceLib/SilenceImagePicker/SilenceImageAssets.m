//
//  SilenceImageAssets.m
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 16/6/27.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import "SilenceImageAssets.h"
#import "TZImageManager.h"
#import "TZAssetModel.h"

@implementation SilenceImageAssets

-(UIImage *)originalImage{
    if (_originalImage == nil) {
        [[TZImageManager manager] getOriginalPhotoWithAsset:self.asset completion:^(UIImage *photo, NSDictionary *info) {
            _originalImage = photo;
        }];
    }
    return _originalImage;
}

-(NSString *)identifier{
    
    return [self getAssetIdentifier:self.asset];
}

- (NSString *)getAssetIdentifier:(id)asset {
    if (iOS8Later) {
        PHAsset *phAsset = (PHAsset *)asset;
        return phAsset.localIdentifier;
    } else {
        ALAsset *alAsset = (ALAsset *)asset;
        NSURL *assetUrl = [alAsset valueForProperty:ALAssetPropertyAssetURL];
        return assetUrl.absoluteString;
    }
}

+(void)getImagesByIdentifiers:(NSArray<NSString *> *)identifiers completion:(void (^)(NSArray<UIImage *> *images))completion{
    if (identifiers != nil && [identifiers isKindOfClass:[NSArray class]]) {
        [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:YES completion:^(TZAlbumModel *model) {

            [[TZImageManager manager] getAssetsFromFetchResult:model.result completion:^(NSArray<TZAssetModel *> *models) {
                NSMutableArray *images = [NSMutableArray array];
                for (TZAssetModel *assetModel in models) {
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded) {
                            if (photo) {
                                [images addObject:photo];
                            }
                        }
                        if (models.count == images.count) {
                            if(completion) completion(images);
                        }
                    }];

                }
            }];
        }];
    }else{
        if(completion) completion(nil);
    }
}

+(void)getImageMapByIdentifiers:(NSArray<NSString *> *) identifiers completion:(void (^)(NSMutableDictionary *imageValues))completion{
    if (identifiers != nil && [identifiers isKindOfClass:[NSArray class]]) {

        [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:YES completion:^(TZAlbumModel *model) {
            
            [[TZImageManager manager] getAssetsFromFetchResult:model.result completion:^(NSArray<TZAssetModel *> *models) {
                NSMutableDictionary *images = [[NSMutableDictionary alloc] init];
                for (TZAssetModel *assetModel in models) {
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded) {
                            if (photo) {
                                
                                [images setObject:photo forKey:assetModel.asset.localIdentifier];
                            }
                        }
                        if (models.count == images.count) {
                            if(completion) completion(images);
                        }
                    }];
                }
            }];
        }];

    }else{
        if(completion) completion(nil);
    }
}

/// Scale image / 缩放图片
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

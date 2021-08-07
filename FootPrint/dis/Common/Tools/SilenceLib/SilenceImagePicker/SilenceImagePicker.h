//
//  SilenceImagePicker.h
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 16/6/24.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SilenceImageAssets.h"
#import "ImportHeader.h"
/**
 *  图片选择类型
 */
typedef NS_ENUM(NSInteger, ImagePickerType) {
    /**
     *  多选
     */
    ImagePickerTypeSelectMuiltImage,
    /**
     *  单选
     */
    ImagePickerTypeSelectSingleImage,
    /**
     *  单选裁剪
     */
    ImagePickerTypeSelectSingleImageAndCuting
};

// 图片选择完成后的回调
typedef void(^ImagePickerBlock)(NSArray<SilenceImageAssets *> *assets);


@interface SilenceImagePicker : BaseVC

// 默认是多选 9张
@property (assign,nonatomic) ImagePickerType imagePickerType;

//照片排列按修改时间升序 默认是
@property (nonatomic,assign) BOOL sortAscendingByModificationDate;
// 是否允许选择原图  默认否
@property (nonatomic,assign) BOOL allowPickingOriginalPhoto;
//允许选择图片的最大数量  默认9
@property (assign,nonatomic) NSInteger maxImagesCount;
// 裁剪比例
@property (assign,nonatomic) CGFloat cutRate;
// 图片选择完成后的回调
@property (strong,nonatomic) ImagePickerBlock imagePickerBlock;

//显示图片选择器
-(void)showImagePicker:(ImagePickerType)imagePickerType andPickerBlock:(ImagePickerBlock)block;

//如果子类实现了sheet代理，请调用此方法来设置下
-(void)silenceImagePickerActionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
//如果子类实现了alert代理，请调用此方法来设置下
- (void)silenceImagePickerAlertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

//选择图片
-(void)selectImagePicker:(ImagePickerType)imagePickerType andPickerBlock:(ImagePickerBlock)block;

//拍照
-(void)takeImagePicker:(ImagePickerType)imagePickerType andPickerBlock:(ImagePickerBlock)block;

@end

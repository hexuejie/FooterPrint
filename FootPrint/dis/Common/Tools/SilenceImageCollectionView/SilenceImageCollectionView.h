//
//  SilenceImageCollectionView.h
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import <UIKit/UIKit.h>

// 高度计算回调block
typedef void (^ImgViewsHeigh)(CGFloat height);

// 图片点击事件回调
typedef void (^ImgClickBlock)(NSInteger index);

// 删除点击事件回调
typedef void (^DelClickBlock)(NSInteger index);

// 添加点击事件回调
typedef void (^AddClickBlock)();

// 改变添加按钮的样式
typedef void (^ChangeAddBtnStyleBlock)(UIButton *addbtn);
// 改变删除按钮的样式
typedef void (^ChangeDelBtnStyleBlock)(UIButton *delbtn);

/**
 使用说明，创建此view时必须 指定  frame的宽度
 */
@interface SilenceImageCollectionView : UIView

@property(assign,nonatomic)  CGFloat hSpac; // 水平直方向的间距（即每列的间距）默认是4
@property(assign,nonatomic)  CGFloat vSpac;  // 垂直方向的间距（即每行的间距） 默认是4
@property(assign,nonatomic)  NSInteger numInRow; // 每行几个元素 默认是3
@property (assign, nonatomic) CGFloat imageCollectionViewWidh; //宽度

/**
 *  图片资源 可以是 urlString/NSURL/UIImage 对象
 */
@property (strong,nonatomic) NSArray *imgs;

/**
 *  是否需要添加按钮默认不需要
 */
@property (assign,nonatomic) BOOL isNeedAddBtn;
/**
 *  添加按钮是否在第一个 默认否 在最末尾
 */
@property (assign,nonatomic) BOOL addBtnAtFirst;

/**
 *  是否需要 删除按钮按钮 默认不需要
 */
@property (assign,nonatomic) BOOL isNeedDelBtn;

/**
 *  是否在一张图的时候最大化 默认不是
 */
@property (assign,nonatomic) BOOL isOnlyOneLarge;

/**
 *  改变添加按钮的样式
 *
 *  @param changeBtnStyleBlock
 */
-(void)setAddBtnStyle:(ChangeAddBtnStyleBlock)changeAddBtnStyleBlock;

/**
 *  改变删除按钮的样式
 *
 *  @param changeBtnStyleBlock
 */
-(void)setDelBtnStyle:(ChangeDelBtnStyleBlock)changeDelBtnStyleBlock;

/**
 *  加载数据
 *
 *  @param imageCollectionViewWidh 这个view容器的宽度
 *  @param imgViewsHeigh           返回加载完成后的高度
 */
-(void)reload:(CGFloat)imageCollectionViewWidh imgViewsHeigh:(ImgViewsHeigh)imgViewsHeigh;

/**
 *  加载数据
 */
-(void)reload;

/**
 *  添加相关事件 全部都是可选项
 *
 *  @param imgClickBlock 图片点击事件
 *  @param addClickBlock 添加按钮点击事件
 *  @param delClickBlock 删除按钮点击事件
 */
-(void)addImageCollectionViewEvent:(ImgClickBlock)imgClickBlock addClickBlock:(AddClickBlock)addClickBlock delClickBlock:(DelClickBlock)delClickBlock;

@end

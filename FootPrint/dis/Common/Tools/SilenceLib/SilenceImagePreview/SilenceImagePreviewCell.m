//
//  SilenceImagePreviewCell.m
//  SilenceIOS_OC
//
//  Created by SilenceMac on 16/6/29.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import "SilenceImagePreviewCell.h"

#import "UIImageView+WebCache.h"
#import "UIView+Frame.h"
@interface SilenceImagePreviewCell()<UIGestureRecognizerDelegate,UIScrollViewDelegate> {
    CGFloat _aspectRatio;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *imageContainerView;
@end
@implementation SilenceImagePreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, VIEW_W(self), VIEW_H(self));
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        [_scrollView addSubview:_imageContainerView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [_imageContainerView addSubview:_imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self addGestureRecognizer:tap2];
        /*第一次创建手势识别器*/
       UILongPressGestureRecognizer * longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(handleLongPressGestures:)];
        /* numberOfTouchesRequired这个属性保存了有多少个手指点击了屏幕,因此你要确保你每次的点击手指数目是一样的,默认值是为 0. */
        longPressGestureRecognizer.numberOfTouchesRequired = 1;
        /* Maximum 100 pixels of movement allowed before the gesture is recognized */
        /*最大100像素的运动是手势识别所允许的*/
        longPressGestureRecognizer.allowableMovement = 100.0f;
        /*这个参数表示,两次点击之间间隔的时间长度。*/
        longPressGestureRecognizer.minimumPressDuration = 1.0;
        [self.imageView addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

-(void)setImgData:(id)imgData{
    _imgData = imgData;
    [_scrollView setZoomScale:1.0 animated:NO];
    [self loadImage];
}

-(void)loadImage{
    // 字符串路径类型
    if ([_imgData isKindOfClass:[NSString class]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imgData] placeholderImage:[UIImage imageNamed:@"square_default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self resizeSubviews];
        }];
        
    }
    //NSURL类型
    else if ([_imgData isKindOfClass:[NSURL class]]) {
        [self.imageView sd_setImageWithURL:_imgData placeholderImage:[UIImage imageNamed:@"square_default_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self resizeSubviews];
        }];
    }
    // 图片类型
    else if ([_imgData isKindOfClass:[UIImage class]]) {
        self.imageView.image = _imgData;
        [self resizeSubviews];
    }
    
}

- (void)resizeSubviews {
    _imageContainerView.origin = CGPointZero;
    CGFloat w = self.frame.size.width;
    CGSize size = _imageContainerView.size;
    size.width = self.width;
    _imageContainerView.size = size;
    
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.height / w) {
        _imageContainerView.height = floor(image.size.height / (image.size.width / w));
    } else {
        CGFloat height = image.size.height / image.size.width * w;
        if (height < 1 || isnan(height)) height = self.height;
        height = floor(height);
        CGSize size = _imageContainerView.size;
        size.height = height;
        _imageContainerView.size = size;
        _imageContainerView.centerY = self.height / 2;
    }
    if (_imageContainerView.height > self.height && _imageContainerView.height - self.height <= 1) {
        _imageContainerView.height = self.height;
    }
    _scrollView.contentSize = CGSizeMake(w, MAX(_imageContainerView.height, self.height));
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _scrollView.alwaysBounceVertical = _imageContainerView.height <= self.height ? NO : YES;
    _imageView.frame = _imageContainerView.bounds;
}

#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (_scrollView.zoomScale > 1.0) {
        [_scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
    if (self.singleTapGestureBlock) {
        self.singleTapGestureBlock();
    }
}

- (void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{

    if (self.longPressGestureRecognizerBlock) {
        self.longPressGestureRecognizerBlock(self.imageView.image);
    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.width > scrollView.contentSize.width) ? (scrollView.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.height > scrollView.contentSize.height) ? (scrollView.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageContainerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end


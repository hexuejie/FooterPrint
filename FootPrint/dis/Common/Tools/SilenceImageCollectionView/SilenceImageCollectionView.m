//
//  SilenceImageCollectionView.m
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 16/6/28.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import "SilenceImageCollectionView.h"
#import "UIImageView+WebCache.h"


@interface SilenceImageCollectionView()
/**
 *  回调计算完成后的高度
 */
@property (strong,nonatomic) ImgViewsHeigh imgViewsHeigh;

// 图片点击事件回调
@property (strong,nonatomic) ImgClickBlock imgClickBlock;
// 删除点击事件回调
@property (strong,nonatomic) DelClickBlock delClickBlock;
// 添加点击事件回调
@property (strong,nonatomic) AddClickBlock addClickBlock;

//改变添加按钮的样式
@property (strong,nonatomic) ChangeAddBtnStyleBlock changeAddBtnStyleBlock;

//改删除按钮的样式
@property (strong,nonatomic) ChangeDelBtnStyleBlock changeDelBtnStyleBlock;

@end

@implementation SilenceImageCollectionView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initParam];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParam];
    }
    return self;
}

-(void)initParam{
    self.vSpac = 4;
    self.hSpac = 4;
    self.numInRow = 3;
}

-(void)setAddBtnStyle:(ChangeAddBtnStyleBlock)changeAddBtnStyleBlock{
    self.changeAddBtnStyleBlock = changeAddBtnStyleBlock;
}
-(void)setDelBtnStyle:(ChangeDelBtnStyleBlock)changeDelBtnStyleBlock{
    self.changeDelBtnStyleBlock = changeDelBtnStyleBlock;
}

-(void)addImageCollectionViewEvent:(ImgClickBlock)imgClickBlock addClickBlock:(AddClickBlock)addClickBlock delClickBlock:(DelClickBlock)delClickBlock{
    self.imgClickBlock = imgClickBlock;
    self.addClickBlock = addClickBlock;
    self.delClickBlock = delClickBlock;
}

-(void)reload{
    [self reload:self.imageCollectionViewWidh imgViewsHeigh:self.imgViewsHeigh];
}

-(void)reload:(CGFloat)imageCollectionViewWidh imgViewsHeigh:(ImgViewsHeigh)imgViewsHeigh{
    self.imageCollectionViewWidh = imageCollectionViewWidh;
    self.imgViewsHeigh = imgViewsHeigh;
    if (self.numInRow == 0) {
        [self initParam];
    }
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    CGFloat height = 0;
    if (self.imgs != nil) {
        // 图片路径大于零
//        if (self.imgs.count > 0) {
        
            // 对一张图时进行特殊处理
            if (self.imgs.count == 1 && self.isOnlyOneLarge) {
                UIImageView *imgView = [self makeImageView:0 frame:CGRectMake(0, 0, imageCollectionViewWidh, imageCollectionViewWidh)];
                height = imageCollectionViewWidh;
                [self addSubview:imgView];
            }else{
                // 元素数量
                NSInteger count = self.imgs.count;
                // 判断是否需要添加按钮
                if (self.isNeedAddBtn) {
                    count += 1;
                }
                
                NSInteger rows = count % self.numInRow == 0 ? count / self.numInRow : count / self.numInRow + 1;
                //计算高度
                height = rows * (imageCollectionViewWidh / self.numInRow) + (rows-1) * self.vSpac;
                // 计算出宽度
                CGFloat width = (imageCollectionViewWidh - (self.numInRow - 1)*self.hSpac) / self.numInRow;
                CGFloat x = 0;
                CGFloat y = 0;
                for (int i =0; i < count; i++) {
                    NSInteger index = i;
                    // 判断是否需要添加按钮
                    if (self.isNeedAddBtn) {
                        // 添加按钮是否在第一个
                        if (self.addBtnAtFirst) {
                            index = i - 1;
                            if (i == 0) {
                                UIButton *addBtn = [self makeAddBtn:CGRectMake(x, y, width, width)];
                                [self addSubview:addBtn];
                                x += (width + self.hSpac);
                                continue;
                            }
                        }
                        // 添加按钮在最后
                        else{
                            if (i == count - 1) {
                                UIButton *addBtn = [self makeAddBtn:CGRectMake(x, y, width, width)];
                                [self addSubview:addBtn];
                                continue;
                            }
                        }
                    }
                    
                    
                    UIImageView *imgView = [self makeImageView:index frame:CGRectMake(x, y, width, width)];
                    [self addSubview:imgView];
                    x += (width + self.hSpac);
                    if ((i + 1) % self.numInRow == 0) {
                        x = 0;
                        y += (width + self.vSpac);
                    }
                    //添加删除按钮
                    if (self.isNeedDelBtn) {
                        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(FRAME_TX(imgView.frame) + width - 20, FRAME_TY(imgView.frame), 20, 20)];
//                        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
//                        delBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//                        [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                        delBtn.backgroundColor = [UIColor blackColor];
//                        delBtn.alpha = 0.6;
                        [delBtn setImage:[UIImage imageNamed:@"silence_img_delete"] forState:UIControlStateNormal];
                        delBtn.tag = 100 + i;
                        [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                        if (self.changeDelBtnStyleBlock !=nil) {
                            self.changeDelBtnStyleBlock(delBtn);
                        }
                        [self addSubview:delBtn];
                    }
                }
                
                
//            }
            
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, imageCollectionViewWidh, height);
        // 回调高度
        if (self.imgViewsHeigh != nil) {
            self.imgViewsHeigh(height);
        }
    }
    
}

-(UIButton *)makeAddBtn:(CGRect)frame{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
//    [btn setTitle:@"+" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:48];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    btn.backgroundColor = RGB(232, 232, 232);
    [btn setBackgroundImage:[UIImage imageNamed:@"silence_img_add"] forState:UIControlStateNormal];
    btn.tag = 999;
    [btn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.changeAddBtnStyleBlock !=nil) {
        self.changeAddBtnStyleBlock(btn);
    }
    return btn;
}

-(UIImageView *)makeImageView:(NSInteger)tag frame:(CGRect)frame{
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.tag = tag ;
    [self loadImage:imgView];
    kImgViewFix(imgView);
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:ges];
    
    return imgView;
}


-(void)loadImage:(UIImageView *)imageView{
    // 字符串路径类型
    if ([self.imgs[imageView.tag] isKindOfClass:[NSString class]]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imgs[imageView.tag]]];
    }
    //NSURL类型
    else if ([self.imgs[imageView.tag] isKindOfClass:[NSURL class]]) {
        [imageView sd_setImageWithURL:self.imgs[imageView.tag]];
    }
    // 图片类型
    else if ([self.imgs[imageView.tag] isKindOfClass:[UIImage class]]) {
        imageView.image = self.imgs[imageView.tag];
    }
    
}

/**
 *  图片的点击事件
 *
 *  @param ges
 */
-(void)imgClick:(UIGestureRecognizer *)ges{
    if (self.imgClickBlock != nil) {
        self.imgClickBlock(ges.view.tag);
    }
}
/**
 *  删除按钮点击事件
 *
 *  @param sender
 */
-(void)delBtnClick:(UIButton *)sender{
    if (self.delClickBlock != nil) {
        self.delClickBlock(sender.tag - 100);
    }
}

/**
 *  添加按钮点击事件
 *
 *  @param sender
 */
-(void)addBtnClick:(UIButton *)sender{
    if (self.addClickBlock != nil) {
        self.addClickBlock();
    }
}

@end

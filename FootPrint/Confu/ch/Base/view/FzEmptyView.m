//
//  FzEmptyView.m
//  FzShop
//  空界面
//  Created by Silence on 2016/11/7.
//  Copyright © 2016年 FzShop. All rights reserved.
//



#import "FzEmptyView.h"

@interface FzEmptyView()
@property(strong,nonatomic) EmptyViewEventBlock eventBlock; // 点击事件处理
@property(weak,nonatomic) UIView *inView;
@property (nonatomic , assign) EmptyViewType emptyViewType;
@end

@implementation FzEmptyView

-(instancetype)initEmptyViewType:(EmptyViewType)emptyViewType showInView:(UIView *)view eventBlock:(EmptyViewEventBlock)eventBlock{
    self = [super init];
    if (self) {
        self.inView = view;
        self.eventBlock = eventBlock;
        self.emptyViewType = emptyViewType;
        [self initView];
    }
    return self;
}
//placeholder_method_impl//

-(instancetype)initEmptyViewWithAjaxResultState:(AjaxResultState)ajaxResultState showInView:(UIView *)view eventBlock:(EmptyViewEventBlock)eventBlock{
    self = [super init];
    if (self) {
        self.inView = view;
        self.eventBlock = eventBlock;
        //placeholder_method_call//

        self.emptyViewType = EmptyViewTypeCommon;
        [self initView];
    }
    return self;
}
//placeholder_method_impl//

-(void)show:(CGFloat)height{
    
    self.backgroundColor = [UIColor clearColor];
    [self.inView addSubview:self];
    //placeholder_method_call//

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(self.inView);
        make.centerX.mas_equalTo(self.inView);
        make.centerY.mas_equalTo(self.inView);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
}

-(void)hide{
    [self removeFromSuperview];
}
//placeholder_method_impl//

#pragma mark - 生成视图内容的私有方法
-(void)initView{
    self.backgroundColor = kColor_BG;
    // 加载中……
    if (self.emptyViewType == EmptyViewTypeLoading) {
//        UILabel *label = [FzUIFactory labelMakeWithTitle:@"努力加载中..." titleColor:self.fzShopTheme.Font_Color_Gray fontSize:self.fzShopTheme.Font_Size_Title_Large isBold:YES align:NSTextAlignmentCenter];
        UILabel *label = [[UILabel alloc] init];
        //placeholder_method_call//

        label.text = @"努力加载中...";
        label.textColor = RGB(144, 147, 153);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }else if (self.emptyViewType == EmptyViewTypeCommon){
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGE(@"no_data")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-16);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"暂无数据,触摸刷新!" titleColor:RGB(144, 147, 153) fontSize:15 isBold:YES align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(16);
        }];
    }else if (self.emptyViewType == EmptyViewTypeMessage){ //暂无消息公告

        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_message")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {

            self.eventBlock(EmptyViewEventTypeReload);
        }];

        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有任何消息" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeRecord){ //没有学习记录
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_record")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有学习记录，赶快去学习吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeCourse){ //暂无课程内容
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_search")];
        // IMAGENAME nodata_search
        
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"暂无课程" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeSearch){ //暂无搜索内容

        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_search")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {

            self.eventBlock(EmptyViewEventTypeReload);
        }];

        UILabel *label = [UIFactory labelMakeWithTitle:@"未搜索到相关内容" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeShop){ //暂无购买商品
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_shop")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有购买任何课程，赶快去学习吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeEnterprise){ //暂无企业开通
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_shop")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有企业开通，赶快去学习吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeComplete){ //暂无完成课程
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_record")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有完成课程，赶快去学习吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeComments){ //暂无评论
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_comments")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有任何评论，赶快来评论吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeNetFail){ //网络请求错误
       
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"ic_netfail")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"暂无网络 点击图片刷新" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeDownLoad){ //课程下载
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_download")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"还没有下载任何课程，赶快去学习吧～" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeInformation){ //资讯
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_search")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"暂无资讯" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }else if (self.emptyViewType == EmptyViewTypeLive){ //直播
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:IMAGENAME(@"nodata_search")];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [imgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            self.eventBlock(EmptyViewEventTypeReload);
        }];
        
        UILabel *label = [UIFactory labelMakeWithTitle:@"暂无直播" titleColor:RGB(144, 147, 153) fontSize:14 isBold:NO align:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(imgView.mas_bottom).offset(32);
        }];
    }
}

@end

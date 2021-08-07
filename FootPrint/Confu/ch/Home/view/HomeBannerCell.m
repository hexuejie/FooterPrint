//
//  HomeBannerCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeBannerCell.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface HomeBannerCell ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>

@property (nonatomic, strong)NewPagedFlowView *pageFlowView;

@property (nonatomic, assign) CGFloat bannerWidth;

@end

@implementation HomeBannerCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
//placeholder_method_impl//

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //placeholder_method_call//
        self.backgroundColor = [UIColor clearColor];
        [self initPageBannerView];
    }
    return self;
}
//placeholder_method_impl//

- (void)initPageBannerView{
    
    self.pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*140/345.0)];
    self.pageFlowView.delegate = self;
    self.pageFlowView.dataSource = self;
    self.pageFlowView.minimumPageAlpha = 0.1;
    //placeholder_method_call//
    self.pageFlowView.isCarousel = YES;
    self.pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    self.pageFlowView.isOpenAutoScroll = YES;
    
    [self.contentView addSubview:self.pageFlowView];
}
//placeholder_method_impl//

- (void)setDataSource:(NSArray<HomeBannelModel *> *)dataSource{
    
    self.bannerWidth = dataSource.count == 1?SCREEN_WIDTH-30:SCREEN_WIDTH-50;
    _dataSource = [HomeBannelModel mj_objectArrayWithKeyValuesArray:dataSource];
    //placeholder_method_call//
    [self setLineIncycleScrollView:dataSource.count];
    [self.pageFlowView reloadData];
}
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//placeholder_method_impl//

//自定义banner下标按钮
-(void)setLineIncycleScrollView:(NSInteger )imgCount{
    
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//
//            [view removeFromSuperview];
//        }
//    }
    //placeholder_method_call//
    for (int i = 0; i<imgCount; i++) {
        UIButton *imagePagebtn = [self.contentView viewWithTag:i+ 9527];
        if (!imagePagebtn) {
            imagePagebtn = [[UIButton alloc]init];
        }
        if (i ==0) {
            imagePagebtn.selected = YES;
        }else{
            imagePagebtn.selected = NO;
        }
        imagePagebtn.tag = i+9527;
        imagePagebtn.frame = CGRectMake((SCREEN_WIDTH - ((imgCount-1)+20*imgCount))/2+23*i, self.pageFlowView.height-30, 23, 18);
        [imagePagebtn setImage:[UIImage imageNamed:@"scroll_btn"] forState:UIControlStateNormal];
        [imagePagebtn setImage:[UIImage imageNamed:@"scroll_btn_status"] forState:UIControlStateSelected];
        [self.contentView addSubview:imagePagebtn];
    }
    
    // 后面的视图移除
    for (NSInteger i = imgCount; i < 10 + imgCount;i ++ ) {
        UIButton *imagePagebtn = [self.contentView viewWithTag:i+ 9527];
        if (imagePagebtn) {
            [imagePagebtn removeFromSuperview];
        }
    }
}

#pragma mark --NewPagedFlowView Delegate
//banner滑动代理，按钮跟着滑动
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView{
    
    for (int  i = 0; i<self.dataSource.count; i++) {
        UIButton *btn_1 =(UIButton*) [self viewWithTag:9527+i];
        btn_1.selected = NO;
    }
    UIButton *btn_5 =(UIButton*) [self viewWithTag:9527+pageNumber];
    btn_5.selected = YES;
}
//placeholder_method_impl//

//设置banner中间cell大小
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    //placeholder_method_call//
    return CGSizeMake(self.bannerWidth, self.pageFlowView.height - 10);
}

#pragma mark --NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.dataSource.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //placeholder_method_call//
    [bannerView.mainImageView sd_setImageWithURL:APP_IMG(self.dataSource[index].img) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    
    return bannerView;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    //placeholder_method_call//
    if (self.BlockBannerClick) {
        self.BlockBannerClick(self.dataSource[subIndex]);
    }
}

@end

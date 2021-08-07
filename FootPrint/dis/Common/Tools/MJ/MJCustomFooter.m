//
//  MJCustomFooter.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/6.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MJCustomFooter.h"

@interface MJCustomFooter()

@property (weak, nonatomic) UIActivityIndicatorView *loading;

/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end

@implementation MJCustomFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    // 添加label
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.font = MJRefreshLabelFont;
    self.stateLabel.textColor = MJRefreshLabelTextColor;
    self.stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.stateLabel];
    
    // 初始化文字
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterIdleText] forState:MJRefreshStateIdle];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterRefreshingText] forState:MJRefreshStateRefreshing];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterNoMoreDataText] forState:MJRefreshStateNoMoreData];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
    
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 40)];
//    footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    lblTitle.textAlignment = NSTextAlignmentCenter;
//    lblTitle.text = @"cn";
//    lblTitle.font = [UIFont systemFontOfSize:13.0];
//    lblTitle.textColor = [UIColor grayColor];
//    [footerView addSubview:lblTitle];
//    
//    [self addSubview:footerView];
}

#pragma mark - 私有方法
- (void)stateLabelClick
{
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.stateLabel.center = CGPointMake(self.mj_w*0.5, 0);
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
    }];
    [self.loading mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.stateLabel);
        make.trailing.mas_equalTo(self.stateLabel.mas_leading).mas_offset(-15);
    }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    if ([title isEqualToString:@"已经全部加载完毕"] || [title isEqualToString:@"点击或上拉加载更多"]) {
        
        title = @"";
    }
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (self.isRefreshingTitleHidden && state == MJRefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        switch (state) {
            case MJRefreshStateIdle:
                [self.loading stopAnimating];
                break;
            case MJRefreshStateRefreshing:
                [self.loading startAnimating];
                break;
            case MJRefreshStateNoMoreData:
                [self.loading stopAnimating];
                break;
            default:
                break;
        }
        self.stateLabel.text = self.stateTitles[@(state)];
    }
}

- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

@end

//
//  HomeTipBgView.m
//  FootPrint
//
//  Created by 何学杰 on 2021/8/6.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "HomeTipBgView.h"

@implementation HomeTipBgView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    
    _allBgView = [[UIView alloc] init];
    _allBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_allBgView];
    _allBgView.clipsToBounds = YES;
    _allBgView.layer.cornerRadius = 8.0;
    [_allBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(22);
        make.trailing.equalTo(self).offset(-22);
        make.centerY.equalTo(self);
    }];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_allBgView addSubview:_closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.equalTo(_allBgView).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _finishButton = [[UIButton alloc] init];
    _finishButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_finishButton setTitle:@"提前进入直播间" forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _finishButton.clipsToBounds = YES;
    _finishButton.layer.cornerRadius = 22.0;
    _finishButton.backgroundColor = UIColorFromRGB(0xF3803F);
    [_allBgView addSubview:_finishButton];
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_allBgView).offset(37);
        make.trailing.equalTo(_allBgView).offset(-37);
        make.bottom.equalTo(_allBgView).offset(-25);
        make.height.mas_equalTo(44);
    }];
}

- (void)closeButtonClick{
    [self removeFromSuperview];
}

@end

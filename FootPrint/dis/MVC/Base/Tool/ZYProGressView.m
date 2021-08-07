//
//  ZYProGressView.m
//  ProgressBar
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYProGressView.h"

@interface ZYProGressView()
{
    UIView *viewTop;
    UIView *viewBottom;
}

@end
@implementation ZYProGressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self buildUI];
        
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    [self buildUI];
}

- (void)buildUI
{
    viewBottom = [[UIView alloc]initWithFrame:self.bounds];
    viewBottom.backgroundColor = [UIColor grayColor];
    viewBottom.layer.cornerRadius = 3;
    viewBottom.layer.masksToBounds = YES;
    [self addSubview:viewBottom];
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.bottom.trailing.mas_equalTo(self);
    }];
    
    viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, viewBottom.frame.size.height)];
    viewTop.backgroundColor = [UIColor redColor];
    viewTop.layer.cornerRadius = 3;
    viewTop.layer.masksToBounds = YES;
    [viewBottom addSubview:viewTop];
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.bottom.mas_equalTo(viewBottom);
    }];
}

-(void)setTime:(float)time{
    
    _time = time;
}

-(void)setProgressValue:(NSString *)progressValue{
    
    if (!_time) {
        _time = 3.0f;
    }
    _progressValue = progressValue;
//    [UIView animateWithDuration:_time animations:^{
//    viewTop.width = viewBottom.frame.size.width*[progressValue floatValue];
//    CGRectMake(0, viewTop.frame.origin.y, viewBottom.frame.size.width*[progressValue floatValue], viewTop.frame.size.height);
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(viewBottom.width*[progressValue floatValue]);
    }];
    [viewBottom layoutIfNeeded];
//    }];
}


-(void)setBottomColor:(UIColor *)bottomColor{
    
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor{
    
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
}

@end

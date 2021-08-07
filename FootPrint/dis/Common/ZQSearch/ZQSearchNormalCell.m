//
//  ZQSearchNormalCell.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/25.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchNormalCell.h"
#import "UIColor+ZQSearch.h"

@interface ZQSearchNormalCell()

@property (weak, nonatomic) UILabel *titleLabel;

@end

@implementation ZQSearchNormalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self changeStyleWith:NO];
    }
    return self;
}

- (void)configUI {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    self.titleLabel = label;
    
    self.layer.cornerRadius = 14;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)changeStyleWith:(BOOL)heightLight {
    self.backgroundColor = heightLight ? [UIColor colorWithHexString:@"#f6f6f6" alpha:1] : [UIColor colorWithHexString:@"f6f6f6" alpha:1];
    self.titleLabel.textColor = heightLight ? [UIColor colorWithHexString:@"#333333" alpha:1] : [UIColor colorWithHexString:@"333333" alpha:1];
}

- (void)setHeightLight:(BOOL)heightLight {
    _heightLight = heightLight;
    [self changeStyleWith:heightLight];
}

- (void)setTitle:(NSString *)title {
    _title = title.copy;
    self.titleLabel.text = title;
}

@end

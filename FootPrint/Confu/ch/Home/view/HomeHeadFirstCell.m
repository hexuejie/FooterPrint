//
//  HomeHeadFirstCell.m
//  FootPrint
//
//  Created by 何学杰 on 2021/8/7.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "HomeHeadFirstCell.h"

@implementation HomeHeadFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    
    [self.coverImageView sd_setImageWithURL:_model[@"liveUrl"] placeholderImage:[UIImage imageNamed:@"mydefault"]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_model[@"title"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@人已预约",_model[@"subscribeCount"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model[@"liveTime"]];
//    @property (weak, nonatomic) IBOutlet UIButton *sureButton;//isSubscribe是否预约过
}

@end

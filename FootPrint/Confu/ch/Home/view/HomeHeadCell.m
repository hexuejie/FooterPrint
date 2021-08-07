//
//  HomeHeadCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeHeadCell.h"

@implementation HomeHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    lblLiveTime
    // gradient
CAGradientLayer *gl = [CAGradientLayer layer];
    //placeholder_method_call//
    gl.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 36)/2.0, 28);
gl.startPoint = CGPointMake(0.5, 0);
gl.endPoint = CGPointMake(0.5, 1);
gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6].CGColor];
gl.locations = @[@(0), @(1.0f)];
    [self.lblLiveTime.layer addSublayer:gl];
    
}

- (void)setCourseModel:(CourslModel *)courseModel{
    
    _courseModel = courseModel;
    
    self.lblLiveTime.hidden = YES;
    self.lblLiveStatus.hidden = YES;
    
    [self.imgView sd_setImageWithURL:APP_IMG(courseModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = courseModel.title;
    self.lblPrice.text = [courseModel.price ChangePrice];
    //placeholder_method_call//
    self.lblNum.text = [NSString stringWithFormat:@"%ld人在学",[courseModel.virtual_amount integerValue] + [courseModel.study_count integerValue]];
//    if ([courseModel.goods_type integerValue] == 1) { //视频
//
//        self.imgType.image = [UIImage imageNamed:@"course_video"];
//    }else if ([courseModel.goods_type integerValue] == 2){
//        
//        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
//    }
}
//placeholder_method_impl//
- (void)setLiveModel:(LiveModel *)liveModel{
    
    _liveModel = liveModel;
    
    self.lblLiveTime.hidden = NO;
    self.lblLiveStatus.hidden = NO;
//    self.lblLiveTime.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];

    [self.imgView sd_setImageWithURL:APP_IMG(liveModel.image) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = liveModel.title;
    self.lblPrice.text = [liveModel.price ChangePrice];
    self.lblLiveTime.text = [NSString stringWithFormat:@"    %@ %@ %@",liveModel.s_title,liveModel.s_time_title,liveModel.e_time_title];
    //placeholder_method_call//
//    状态 1-直播中 2-待直播 3-已结束
    NSInteger liveStatus = [liveModel.live_status integerValue];
    
    self.lblLiveStatus.text = liveStatus == 1?@"正在直播":liveStatus == 2?@"即将直播":liveStatus == 3?@"已结束":liveStatus == 4?@"可回放":@"";
    self.lblLiveStatus.backgroundColor = liveStatus == 1?RGB(103, 194, 58):liveStatus == 2?RGB(4, 134, 254):liveStatus == 3?RGB(255, 164, 0):liveStatus == 4?RGB(255, 164, 0):[UIColor clearColor];
    NSString *string = liveStatus == 1?@"在看":liveStatus == 2?@"预约":liveStatus == 3?@"观看":liveStatus == 4?@"观看":@"";
    self.lblNum.text = [NSString stringWithFormat:@"已有%@人%@",liveModel.join,string];
    self.imgType.image = [UIImage imageNamed:@"course_live"];
}
//placeholder_method_impl//
//placeholder_method_impl//
@end

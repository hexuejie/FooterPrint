//
//  LearnRecordCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LearnRecordCell.h"
#import "ZYProGressView.h"

@interface LearnRecordCell ()

@property (nonatomic,strong) ZYProGressView *progress;

@end

@implementation LearnRecordCell
//placeholder_method_impl//
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.progress = [[ZYProGressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60-75, 6)];
    self.progress.progressColor = RGB(4, 134, 254);
    self.progress.bottomColor = RGB(238, 238, 238);
    self.progress.time = 0.5;
    //placeholder_method_call//

    [self.progressView addSubview:self.progress];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//placeholder_method_impl//
//placeholder_method_impl//

- (void)setModel:(LearnRecordModel *)model{
    
    _model = model;
    
    [self.imgView sd_setImageWithURL:APP_IMG(model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = model.course_title;
    self.lblContent.text = model.desc;
    //placeholder_method_call//

    self.lblTime.text = model.update_time;
//    课程类型1:视频；2:音频
    //placeholder_method_call//

    if ([model.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
    }else{
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
    }
   
    self.progress.progressValue = [NSString stringWithFormat:@"%lf",[model.percentage floatValue]];
    self.lblProgress.text = [NSString stringWithFormat:@"已学习%.0f%%",[model.percentage doubleValue]*100];
}

- (void)setIsEdit:(BOOL)isEdit{
    
    if (isEdit) { //编辑
        
        self.btnSelect.hidden = NO;
        self.csBtnSelectWidth.constant = 40;
        self.progress.frame = CGRectMake(0, 0, SCREEN_WIDTH-60-75-40, 6);
        //placeholder_method_call//

//        [self.progress layoutSubviews];
//        self.progress.progressValue = [NSString stringWithFormat:@"%lf",[self.model.percentage floatValue]];
    }else{
        
        self.btnSelect.hidden = YES;
        self.csBtnSelectWidth.constant = 0;
        self.progress.frame = CGRectMake(0, 0, SCREEN_WIDTH-60-75, 6);
//        [self.progress layoutSubviews];
//        self.progress.progressValue = [NSString stringWithFormat:@"%lf",[self.model.percentage floatValue]];
    }
}

@end

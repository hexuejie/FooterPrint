//
//  CourseAudioView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/21.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseAudioView.h"

@implementation CourseAudioView
//placeholder_method_impl//

- (void)setModel:(CourseDetailModel *)model{
    
    [self.imgBg sd_setImageWithURL:APP_IMG(model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = model.title;
    self.lblContent.text = model.desc;
    self.lblPrice.text = [model.price ChangePrice];
    //placeholder_method_call//

    self.lblNum.text = [NSString stringWithFormat:@"已有%ld人在学",[model.virtual_amount integerValue] + [model.study_count integerValue]];
    [self.btnConment setTitle:[NSString stringWithFormat:@"  %@",model.comment_total] forState:UIControlStateNormal];
}

@end

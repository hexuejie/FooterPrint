//
//  OrderCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "OrderCell.h"
#import "NSMutableAttributedString+Attributes.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OrderModel *)model{
    
    _model = model;
   
    self.csViewHeight.constant = 50;
    self.bottomView.hidden = NO;
    //placeholder_method_call//

    [self.btnPrice setImage:nil forState:UIControlStateNormal];
    self.lblOldPrice.hidden = YES;
    self.lblStatus.hidden = YES;
    self.imgSpell.hidden = YES;
    
    self.lblTitle.text = model.title;
    [self.btnPrice setTitle:[NSString stringWithFormat:@"  %@",[model.pay_price ChangePrice]] forState:UIControlStateNormal];
//    订单类型 usercard会员卡 package套餐 course课程 live直播 question题库
    if ([model.order_type isEqualToString:@"usercard"]) { //会员卡
        
        self.imgView.image = [UIImage imageNamed:@"ic_vip"];
    }else{
      
        [self.imgView sd_setImageWithURL:APP_IMG(model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    }
    if ([model.order_type isEqualToString:@"package"]) { //套餐
        
        self.lblStatus.hidden = NO;
        self.lblStatus.text = [NSString stringWithFormat:@"包含%@门课程",model.course_counts];
    }else if ([model.order_type isEqualToString:@"course"]) { //课程
        
        if ([model.is_spell integerValue] == 1) { //是否为拼团 0不是 1是
            
            self.lblStatus.hidden = NO;
            self.imgSpell.hidden = NO;
            self.lblOldPrice.hidden = NO;
            NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.price]];
            [oldPrice addMidlineForSubstring:[NSString stringWithFormat:@"¥%@",model.price]];
            self.lblOldPrice.attributedText = oldPrice;
            
            if ([model.spell_state integerValue] == 1) { //拼团状态 1成功 2拼团中 3拼团失败
                
                self.lblStatus.textColor = [UIColor colorWithHex:0x479298];
                self.lblStatus.text = @"拼团成功";
                self.csViewHeight.constant = 50;
                self.bottomView.hidden = NO;
            }else if ([model.spell_state integerValue] == 2) {
                
                self.lblStatus.textColor = RGB(255, 164, 0);
                self.lblStatus.text = @"待成团";
                self.csViewHeight.constant = 0;
                self.bottomView.hidden = YES;
            }else if ([model.spell_state integerValue] == 3) {
                
                self.lblStatus.textColor = RGB(245, 108, 108);
                self.lblStatus.text = @"拼团失败";
                self.csViewHeight.constant = 0;
                self.bottomView.hidden = YES;
            }
        }
        //    课程类型 0:无类型；1:视频；2:音频
        NSInteger type = [model.c_type integerValue];
        if (type == 1){
            
            [self.btnPrice setImage:[UIImage imageNamed:@"course_small_video"] forState:UIControlStateNormal];
        }else if (type == 2){
            
            [self.btnPrice setImage:[UIImage imageNamed:@"course_small_audio"] forState:UIControlStateNormal];
        }
    }else if ([model.order_type isEqualToString:@"live"]) { //直播
        
        [self.btnPrice setImage:[UIImage imageNamed:@"course_live"] forState:UIControlStateNormal];
        self.lblStatus.hidden = NO;
        if ([model.is_spell integerValue] == 1) { //是否为拼团 0不是 1是
            
            [self.btnPrice setTitle:[NSString stringWithFormat:@"  %@",[model.old_price ChangePrice]] forState:UIControlStateNormal];
            
            self.imgSpell.hidden = NO;
            [self.btnPrice setImage:[UIImage imageNamed:@"course_live"] forState:UIControlStateNormal];
            if ([model.spell_state integerValue] == 1) { //拼团状态 1成功 2拼团中 3拼团失败
                
                self.lblStatus.textColor = [UIColor colorWithHex:0x479298];
                self.lblStatus.text = @"拼团成功";
            }else if ([model.spell_state integerValue] == 2) {
                
                self.lblStatus.textColor = RGB(255, 164, 0);
                self.lblStatus.text = @"待成团";
            }else if ([model.spell_state integerValue] == 3) {
                
                self.lblStatus.textColor = RGB(245, 108, 108);
                self.lblStatus.text = @"拼团失败";
            }
        }else{
            
            self.lblStatus.text = model.live_title;
//            直播状态 1等待直播 2直播中 3已结束 4直播回放
            NSInteger liveStatus = [model.live_state integerValue];
            self.lblStatus.text = liveStatus == 1?@"等待直播":liveStatus == 2?@"直播中":liveStatus == 3?@"已结束":liveStatus == 4?@"直播回放":@"";
        }
    }else if ([model.order_type isEqualToString:@"question"]){ //题库
       
        self.lblStatus.text = [NSString stringWithFormat:@"共%@题",model.totality];
    }
}
//placeholder_method_impl//

- (void)setEnterModel:(EnterpriseModel *)enterModel{
    
    _enterModel = enterModel;

    [self.btnPrice setImage:nil forState:UIControlStateNormal];
    self.lblOldPrice.hidden = YES;
    self.lblStatus.hidden = YES;
    self.imgSpell.hidden = YES;
    
    [self.imgView sd_setImageWithURL:APP_IMG(enterModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = enterModel.title;
    [self.btnPrice setTitle:[NSString stringWithFormat:@"  %@",[enterModel.price ChangePrice]] forState:UIControlStateNormal];
    //placeholder_method_call//

    //    课程类型 0:无类型；1:视频；2:音频
    NSInteger type = [enterModel.goods_type integerValue];
    if (type == 1){
        
        [self.btnPrice setImage:[UIImage imageNamed:@"course_video"] forState:UIControlStateNormal];
    }else if (type == 2){
        
        [self.btnPrice setImage:[UIImage imageNamed:@"course_mp3"] forState:UIControlStateNormal];
    }
}
//placeholder_method_impl//

@end

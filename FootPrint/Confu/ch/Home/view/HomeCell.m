//
//  HomeCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}
//placeholder_method_impl//

- (void)setModel:(CourslModel *)model{
    
    _model = [CourslModel mj_objectWithKeyValues:model];
   
    [self.imgView sd_setImageWithURL:APP_IMG(_model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    //placeholder_method_call//

    self.lblTitle.text = _model.title;
    self.lblPrice.text = [_model.price ChangePrice];
    self.lblNum.text = [NSString stringWithFormat:@"%ld人在学",[_model.virtual_amount integerValue] + [_model.study_count integerValue]];
    if ([_model.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
    }else if ([_model.goods_type integerValue] == 2){
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
    }
}

- (void)setInfoModel:(OrderInfoFootModel *)infoModel{
    
    _infoModel = infoModel;
    
    [self.imgView sd_setImageWithURL:APP_IMG(infoModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    //placeholder_method_call//

    self.lblTitle.text = infoModel.title;
    self.lblPrice.text = [infoModel.price ChangePrice];
    self.lblNum.text = [NSString stringWithFormat:@"%@到期",infoModel.expire_month];
    if ([infoModel.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
    }else if ([infoModel.goods_type integerValue] == 2){
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
    }
}
//placeholder_method_impl//

//placeholder_method_impl//

- (void)setOrderModel:(CourslModel *)orderModel{
    
    [self.imgView sd_setImageWithURL:APP_IMG(orderModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = orderModel.title;
    self.lblPrice.text = [orderModel.price ChangePrice];
    //placeholder_method_call//

    self.lblNum.text = [NSString stringWithFormat:@"%@到期",orderModel.expire];
    if ([orderModel.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
    }else if ([orderModel.goods_type integerValue] == 2){
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
    }
}
//placeholder_method_impl//

@end

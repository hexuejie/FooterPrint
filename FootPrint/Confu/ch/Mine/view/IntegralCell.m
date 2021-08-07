//
//  IntegralCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "IntegralCell.h"

@implementation IntegralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(IntegralModel *)model{
    
    self.lblTime.text = model.create_time;
    self.lblTitle.text = model.config_name;
    
    if ([model.integral integerValue] < 0) {
        //placeholder_method_call//

        self.lblNum.text = model.integral;
        self.lblNum.textColor = [UIColor blackColor];
    }else{
        
        self.lblNum.text = [NSString stringWithFormat:@"+%@",model.integral];
        self.lblNum.textColor = RGB(4, 134, 254);
    }
}
//placeholder_method_impl//

- (void)setGoldModel:(GoldModel *)goldModel{
    
    self.lblTime.text = goldModel.create_time;
    self.lblTitle.text = goldModel.title;
    //placeholder_method_call//

    if ([goldModel.type integerValue] == 1) {
        
        self.lblNum.text = [NSString stringWithFormat:@"-%@",goldModel.gold];
        self.lblNum.textColor = [UIColor blackColor];
    }else{
        
        self.lblNum.text = [NSString stringWithFormat:@"+%@",goldModel.gold];
        self.lblNum.textColor = RGB(4, 134, 254);
    }
}
//placeholder_method_impl//

@end

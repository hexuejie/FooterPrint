//
//  InformationCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

    // Initialization code
}
//placeholder_method_impl//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}
//placeholder_method_impl//
- (void)setModel:(InformationfootModel *)model{
    
    [self.imgView sd_setImageWithURL:APP_IMG(model.photopath) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    //placeholder_method_call//

    self.lblTitle.text = model.title;
    self.lblTime.text = model.create_time;
    self.lblNum.text = model.views;
}
//placeholder_method_impl//
@end

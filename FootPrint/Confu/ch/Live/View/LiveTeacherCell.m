//
//  LiveTeacherCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LiveTeacherCell.h"

@implementation LiveTeacherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}
//placeholder_method_impl//

- (void)setModel:(TeachersModel *)model{
    
    [self.imgHead sd_setImageWithURL:APP_IMG(model.face) placeholderImage: [UIImage imageNamed:@"head_default"]];
    //placeholder_method_call//

    self.lblName.text = model.username;
    self.lblInfo.text = model.remarks;
}
//placeholder_method_impl//

@end

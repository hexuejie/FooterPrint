//
//  ShopMessageCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "ShopMessageCell.h"

@implementation ShopMessageCell

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

- (void)setModel:(ShopMessageModel *)model{
    
//    是否已读 1: 已读 0:未读
    if ([model.isread intValue] == 0) {
        //placeholder_method_call//

        self.lblTitle.textColor = [UIColor colorWithHex:0x333333];
    }else{
        
        self.lblTitle.textColor = [UIColor colorWithHex:0x479298];
    }
    self.lblTitle.text = model.title;
    self.lblTime.text = model.date;
}
//placeholder_method_impl//

@end

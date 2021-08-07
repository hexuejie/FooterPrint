//
//  ReplyMessageCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "ReplyMessageCell.h"

@implementation ReplyMessageCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)setModel:(ShopMessageModel *)model{
    
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage: [UIImage imageNamed:@"head_default"]];
    self.lblContent.text = model.content;
    //placeholder_method_call//

    self.lblTitle.text = model.date;
    self.lblType.text = model.targetType;
    self.lblTitle.text = model.tips;
}

@end

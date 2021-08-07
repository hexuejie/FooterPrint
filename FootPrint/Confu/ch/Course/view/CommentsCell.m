//
//  CommentsCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CommentsCell.h"
#import "NSMutableAttributedString+Attributes.h"

@implementation CommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

    
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}

- (void)setModel:(CommentsFootModel *)model{
    
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage: [UIImage imageNamed:@"head_default"]];
    self.lblName.text = model.nickname;
    self.lblContent.text = model.content;
    //placeholder_method_call//

    self.lblTime.text = model.create_time;
    if (model.reply.length == 0) {
        
        self.lblReply.text = @"";
        self.csSpacing.constant = 0;
        self.cslblTopSpacing.constant = 0;
        self.cslblBottomSpacing.constant = 0;
    }else{
        
        NSMutableAttributedString *reply = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"老师回复: %@",model.reply]];
        [reply addColor:[UIColor colorWithHex:0x497298] substring:@"老师回复"];
        self.lblReply.attributedText = reply;
        self.csSpacing.constant = 12;
        self.cslblTopSpacing.constant = 12;
        self.cslblBottomSpacing.constant = 12;
    }
    
    NSString *imgStr = [model.is_like integerValue] == 0?@"ic_like_n":@"ic_like_p";
    [self.btnCommentsNum setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [self.btnCommentsNum setTitle:[NSString stringWithFormat:@"  %@",model.supnum] forState:UIControlStateNormal];
}

@end

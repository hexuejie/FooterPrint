//
//  BuyVipCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyVipCell.h"

@implementation BuyVipCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)setModel:(VipModel *)model{
    
    if (model.isSelect) {
        
        self.viewBg.backgroundColor = RGB(229, 242, 254);
        self.viewBg.layer.borderColor = RGB(4, 134, 254).CGColor;
    }else{
        
        self.viewBg.backgroundColor = [UIColor whiteColor];
//        rgba(238, 238, 238, 1)
        self.viewBg.layer.borderColor = RGB(238, 238, 238).CGColor;
    }
    //placeholder_method_call//

    self.lblName.text = model.title;
    self.lblPrice.text = [NSString stringWithFormat:@"¥ %@",model.price];
}

@end

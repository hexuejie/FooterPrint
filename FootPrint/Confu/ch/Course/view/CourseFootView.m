//
//  CourseFootView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseFootView.h"

@implementation CourseFootView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.groupsView.clipsToBounds = YES;
    self.aloneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 0);
    [self.aloneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.groupBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 17, 0, 0);
    [self.groupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    
    
}
//placeholder_method_impl//

- (void)setModel:(CourseDetailModel *)model{
    
    _model = model;
    self.groupBgView.hidden = YES;
//    self.aloneBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    //placeholder_method_call//
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] init];

    //    是否是vip 1:是0:不是
    if ([self.model.is_vip integerValue] == 1) {

        self.btnIsVip.hidden = NO;
    }else{

        self.btnIsVip.hidden = YES;
    }
//    :0 下架 1:上架
    if ([model.audit integerValue] == 0) {
        
        [self.btnBuyCourse setTitle:@"已下架" forState:UIControlStateNormal];
        mutableStr  = [[NSMutableAttributedString alloc] initWithString:@"已下架"];

        self.btnBuyCourse.backgroundColor = RGB(251, 125, 51);
    }else{
        
        self.btnBuyCourse.backgroundColor = RGB(251, 125, 51);
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 1) {
            
            [self.btnBuyCourse setTitle:@"立即学习" forState:UIControlStateNormal];
            
            mutableStr  = [[NSMutableAttributedString alloc] initWithString:@"立即学习"];

        }else{
            
            self.btnBuyCourse.backgroundColor = RGB(251, 125, 51);
            
            if ([self.model.price floatValue] <= 0) {
                
                [self.btnBuyCourse setTitle:@"立即报名" forState:UIControlStateNormal];
                mutableStr  = [[NSMutableAttributedString alloc] initWithString:@"立即报名"];
            }else{
                if (model.is_discount == 1) {
                   NSString *price = [NSString stringWithFormat:@"%@优惠价购买",self.model.yh_price];
                    mutableStr = [[NSMutableAttributedString alloc]initWithString:price];
                    self.btnBuyCourse.titleLabel.font = [UIFont systemFontOfSize:20];
                    
                    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[price rangeOfString:@"优惠价购买"]];
                    
                    [self.btnBuyCourse setAttributedTitle:mutableStr forState:UIControlStateNormal];

//
//
                } else if (model.is_group == 1) {
                    self.groupBgView.hidden = NO;
                    
                    NSString *price = [NSString stringWithFormat:@"%@单独购买",self.model.price];
                     NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:price];
                     self.aloneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                     
                     [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:[price rangeOfString:@"单独购买"]];
                    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[price rangeOfString:price]];
                     
                     [self.aloneBtn setAttributedTitle:attr forState:UIControlStateNormal];
                    if (self.model.group.join_group_status == 1) {
                        price = [NSString stringWithFormat:@"%@已参加",self.model.group.spell_price];
                        
                        
                         attr = [[NSMutableAttributedString alloc]initWithString:price];
                         self.groupBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                         
                         [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:[price rangeOfString:@"已参加"]];
                        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[price rangeOfString:price]];
                    } else {
                        price = [NSString stringWithFormat:@"%@拼团购买",self.model.group.spell_price];
                        
                        
                         attr = [[NSMutableAttributedString alloc]initWithString:price];
                         self.groupBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                         
                         [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:[price rangeOfString:@"拼团购买"]];
                        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[price rangeOfString:price]];
                    }
                  
                    
                    
                     [self.groupBtn setAttributedTitle:attr forState:UIControlStateNormal];
                    
                }
                else {
                    [self.btnBuyCourse setTitle:@"立即购买" forState:UIControlStateNormal];
                    mutableStr  = [[NSMutableAttributedString alloc] initWithString:@"立即购买"];

                    


                }
                
            }
        }
    }
    [self.btnBuyCourse setAttributedTitle:mutableStr forState:UIControlStateNormal];

    self.csBtnBuyVipWidth.constant = 0;
    [self layoutSubviews];
    
//    if ([isAudit isEqualToString:@"no"]) {
//        self.csBtnBuyVipWidth.constant = SCREEN_WIDTH*0.3;
//    } else {
//        self.csBtnBuyVipWidth.constant = 0;
//    }


}
//placeholder_method_impl//

- (void)setPlayModel:(CoursePlayerFootModel *)playModel{
    //placeholder_method_call//

    _playModel = playModel;
}
//placeholder_method_impl//

- (IBAction)btnGoHomeClick:(id)sender {
    //placeholder_method_call//

    if (self.BlockOperationClick) {
        self.BlockOperationClick(1);
    }
}

- (IBAction)btnBuyVipClick:(id)sender{
    //placeholder_method_call//

    if (self.BlockOperationClick) {
        self.BlockOperationClick(2);
    }
}
//placeholder_method_impl//

- (IBAction)btnBuyCourseClick:(id)sender{
    //placeholder_method_call//

    if (self.BlockOperationClick) {
        self.BlockOperationClick(3);
    }
}
//placeholder_method_impl//

- (IBAction)btnShareClick:(id)sender {
    //placeholder_method_call//

    if (self.BlockOperationClick) {
        self.BlockOperationClick(4);
    }
}
//placeholder_method_impl//

- (IBAction)groupAction:(UIButton *)sender {
    if (self.model.group.join_group_status == 1) {
        if (self.BlockOperationClick) {
            self.BlockOperationClick(7);
        }
        return;
    }
    if (self.BlockOperationClick) {
        self.BlockOperationClick(5);
    }
}

- (IBAction)aloneAction:(UIButton *)sender {
#if 0
    if (self.model.group.join_group_status == 1) {
        return;
    }
#endif
    if (self.BlockOperationClick) {
        self.BlockOperationClick(3);
    }
    
    
}
@end

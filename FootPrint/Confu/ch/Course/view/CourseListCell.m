//
//  CourseListCell.m
//  FootPrint
//
//  Created by 胡翔 on 2021/3/16.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "CourseListCell.h"

@implementation CourseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.imgBgView.layer.cornerRadius = 10.0;
    self.imgBgView.clipsToBounds = YES;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 30, 16) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
    _vipTipLabel.layer.mask = shapeLayer2;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 80, 16) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
    _vipBgView.layer.mask = shapeLayer;//8
}
- (UIImage *)imageWithColor:(UIColor *)color andUIImageage:(UIImage *)img {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


    
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCourseModel:(CourslModel *)courseModel{
    
    _courseModel = courseModel;
//    NSMutableAttributedString*newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",courseModel.price]];
//    [newPrice addAttribute:NSForegroundColorAttributeName value:[UIColor col] range:NSMakeRange(0, 0)];
//    self.lblPrice.attributedText= newPrice;
    
    self.moneyIconImgView.image = [UIImage imageNamed:@"course_money"];
    self.lblPrice.textColor = [UIColor colorWithHex:0xF1AF48];

    [self.studyBtn setTitle:@"立即学习" forState:UIControlStateNormal];
    self.groupIconImgView.hidden = YES;
    self.groupPriceBgView.hidden = YES;
    self.homeSaleImgView.hidden = YES;
    self.lblPrice.text = courseModel.price;
   
     
    if (_courseModel.vip_price_text != nil && _courseModel.vip_price_text.length>0) {
        self.vipPriceLabel.text = _courseModel.vip_price_text;
        
        CGFloat width1 = [_courseModel.vip_price_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 11) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.width;
        self.vipBgWidth.constant = 37+width1;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 37+width1, 16) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
        _vipBgView.layer.mask = shapeLayer;//8
        _vipBgView.hidden = NO;
    }else{
        _vipBgView.hidden = YES;
    }
    

    if (courseModel.is_group == 1) { // 拼团
        self.groupIconImgView.hidden = NO;
        self.groupPriceBgView.hidden = NO;
        self.groupPriceLabel.text = courseModel.spell_price;
        self.lblPrice.textColor = [UIColor colorWithHex:0xF1AF48];

    } else  if (courseModel.is_limit_course == 1){ // 限时优惠
        self.homeSaleImgView.hidden = NO;
        //
//        self.moneyIconImgView
        self.lblPrice.textColor = [UIColor colorWithHex:0xB2B2B2];
        if (!courseModel.is_buy) {
            NSMutableAttributedString*newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",courseModel.price]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            self.lblPrice.attributedText= newPrice;
        }
    }
    
    if (courseModel.is_buy) {
        self.statusLabel.hidden = NO;
        self.studyBtn.hidden = NO  ;
        self.groupIconImgView.hidden = YES;
        self.groupPriceBgView.hidden = YES;
        self.homeSaleImgView.hidden = YES;
        self.lblPrice.text= courseModel.price;
        self.lblPrice.textColor = [UIColor colorWithHex:0xF1AF48];

        
    }  else {
        self.statusLabel.hidden = YES;
        if (courseModel.is_group == 1) {
            self.studyBtn.hidden = NO ;
            [self.studyBtn setTitle:@"拼团购买" forState:UIControlStateNormal];
        } else if (courseModel.is_limit_course == 1) {
            self.statusLabel.hidden = NO;
            self.statusLabel.text = [NSString stringWithFormat:@"优惠价 %@",courseModel.yh_price];
            UIImage *img = [UIImage imageNamed:@"course_money"];
             img = [self imageWithColor:[UIColor colorWithHex:0xB2B2B2] andUIImageage:img];
            self.moneyIconImgView.image = img;
            self.studyBtn.hidden = YES;
         
        }
        
        else {
            self.studyBtn.hidden = YES ;

        }
        
    }
   
    
    
    
    
    self.lblLiveTime.hidden = YES;
    self.lblLiveStatus.hidden = YES;
    [self.imgView sd_setImageWithURL:APP_IMG(courseModel.banner) placeholderImage:[UIImage imageNamed:@"show_replace"]];
    self.lblTitle.text = courseModel.title;
    // 168
    
    self.lblDesc.text = courseModel.desc;
  CGSize size =  [courseModel.desc sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToWidth:SCREEN_WIDTH - 168.0];
    NSLog(@"%f",size.height);
    CGFloat rate = SCREEN_WIDTH / 375.0;
    NSString *desc = courseModel.desc;
    if (desc.length > (25.0 * rate)) {
     desc = [NSString stringWithFormat:@"%@...",[courseModel.desc substringToIndex:(int)(25 *rate)]];
    }
    self.lblDesc.text = desc;
    
    
    //placeholder_method_call//
    self.lblNum.text = [NSString stringWithFormat:@"%ld人在学",[courseModel.virtual_amount integerValue] + [courseModel.study_count integerValue]];
    if ([courseModel.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
    }else if ([courseModel.goods_type integerValue] == 2){
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
    }
    

}
@end

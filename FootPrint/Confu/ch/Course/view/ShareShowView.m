//
//  ShareShowView.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/8.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "ShareShowView.h"

@implementation ShareShowView
- (void)awakeFromNib {
    
    
    
    // 底层view圆角，如：
    CALayer *roundedLayer = self.showBgView.layer;

      roundedLayer.masksToBounds= YES;
      roundedLayer.cornerRadius = 16;
    ///  自身阴影，如
       CALayer *shadowLayer = self.showBgView.layer;

       shadowLayer.shadowColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.5].CGColor;
       shadowLayer.shadowOffset = CGSizeMake(0,0);
       shadowLayer.shadowRadius = 6;
       shadowLayer.shadowOpacity = 1;
       shadowLayer.masksToBounds = NO;
     
}
- (IBAction)clickAction:(UIButton *)sender {
    [self removeFromSuperview];
    
}
@end

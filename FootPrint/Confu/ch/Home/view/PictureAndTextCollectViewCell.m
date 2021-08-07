//
//  PictureAndTextCollectViewCell.m
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/14.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "PictureAndTextCollectViewCell.h"

@implementation PictureAndTextCollectViewCell
//placeholder_method_impl//
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//
    CGFloat width = (375.0 / SCREEN_WIDTH) * 34;
    self.withConstraint.constant = width;
    self.imgView.layer.cornerRadius = width / 2.0;
    
    
}
//placeholder_method_impl//
- (void)prepareForReuse {
    //placeholder_method_call//
    [super prepareForReuse];
}
- (void)setModel:(HomeBannelModel *)model {
    _model = model;
    
    
    

     
    
    [self.imgView sd_setImageWithURL:APP_IMG(model.img) placeholderImage:[UIImage imageNamed:@""]];
    //placeholder_method_call//
   self.titleLabel.text = model.title;
}

//placeholder_method_impl//
@end

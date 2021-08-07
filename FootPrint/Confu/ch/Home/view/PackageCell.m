//
//  PackageCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/27.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "PackageCell.h"
#import "ProcessImg.h"
@implementation PackageCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
       //placeholder_method_call//
}
//placeholder_method_impl//


- (void)setModel:(HomePackaglModel *)model{
    //placeholder_method_call//

    _model = model;
   
    [self.imgView sd_setImageWithURL:APP_IMG(model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
//    NSURL *url = APP_IMG(model.banner);
//     UIImage *img = [ProcessImg getImageFromURL:url];
//    NSData *data = UIImageJPEGRepresentation(img, 0.1);
//       img = [UIImage imageWithData:data];

    

//    self.imgView.image = img;
//                 UIImage *thumbnailImg = [ProcessImg compressImage:img toByte:32765];
//                   NSData *data = UIImageJPEGRepresentation(thumbnailImg, 0.01);
//                   NSLog(@"%@",data);
//                      thumbnailImg = [UIImage imageWithData:data];
    
    
    
    
    
    self.lblTitle.text = model.title;
    self.lblPrice.text = [model.price ChangePrice];
    self.lblNum.text = [NSString stringWithFormat:@"包含%@门课程",model.course_num];
}

@end

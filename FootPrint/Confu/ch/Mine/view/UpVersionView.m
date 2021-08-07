//
//  UpVersionView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "UpVersionView.h"

@implementation UpVersionView

//placeholder_method_impl//

- (IBAction)btnUpdataClick:(id)sender {
    //placeholder_method_call//

    [self removeFromSuperview];
    if (self.BlockClick) {

        self.BlockClick();
    }
}
//placeholder_method_impl//
//placeholder_method_impl//

- (IBAction)btnCloseClick:(id)sender {
    //placeholder_method_call//

    [self removeFromSuperview];
}

- (void)setModel:(VersionModel *)model{
    
    self.lblTitle.text = [NSString stringWithFormat:@"发现新版本V%@",model.version];
    self.lblContent.text = model.desc;
}

@end

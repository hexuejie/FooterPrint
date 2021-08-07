
//
//  HomeSearchCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeSearchCell.h"

@implementation HomeSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.searchBtn setTitle:@"" forState:UIControlStateNormal];
    NSString *hotName = [[NSUserDefaults standardUserDefaults] objectForKey:kHotName];
     if (hotName) {
         [self.searchBtn setTitle:hotName forState:UIControlStateNormal];

     } else {
         [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];

     }
    self.searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHot) name: kNotification_UpdateHot object:nil];

}

- (void)updateHot {
   NSString *hotName = [[NSUserDefaults standardUserDefaults] objectForKey:kHotName];
    if (hotName) {
        [self.searchBtn setTitle:hotName forState:UIControlStateNormal];

    }
    
}


//placeholder_method_impl//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//
    // Configure the view for the selected state
}
//placeholder_method_impl//


- (IBAction)btnSearchClick:(id)sender {
    //placeholder_method_call//
    if (self.BlockSearchClick) {
        self.BlockSearchClick();
    }
}

@end

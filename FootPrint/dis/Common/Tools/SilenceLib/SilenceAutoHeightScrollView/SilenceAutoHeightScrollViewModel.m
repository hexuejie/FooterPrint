//
//  SilenceAutoHeightScrollViewModel.m
//  FzShop
//
//  Created by Silence on 2016/11/9.
//  Copyright © 2016年 FzShop. All rights reserved.
//

#import "SilenceAutoHeightScrollViewModel.h"

@implementation SilenceAutoHeightScrollViewModel


-(instancetype)initWithViewClassName:(NSString *)viewClassName viewData:(id)viewData top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self = [super init];
    if (self) {
        self.viewClassName = viewClassName;
        self.viewData = viewData;
        self.top = top;
        self.left = left;
        self.bottom = bottom;
        self.right = right;
    }
    return self;
}

-(instancetype)initWithViewClassName:(NSString *)viewClassName strongViewData:(id)viewData top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self = [super init];
    if (self) {
        self.strong_viewData = viewData;
        self.viewClassName = viewClassName;
        self.viewData = self.strong_viewData;
        self.top = top;
        self.left = left;
        self.bottom = bottom;
        self.right = right;
    }
    return self;
}
@end

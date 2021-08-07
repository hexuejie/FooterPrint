//
//  BaseView.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.userInteractionEnabled = YES;
        //placeholder_method_call//

        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
//placeholder_method_impl//


-(void)setStrong_data:(id)strong_data{
    self.data = strong_data;
}

-(void)setData:(id)data{
    //placeholder_method_call//

}
//placeholder_method_impl//


/**
 给子类去实现
 */
-(void)setupUI{
    //placeholder_method_call//

}
//placeholder_method_impl//

@end

//
//  MyButton.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/14.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    NSLog(@"titlessssssssssss%@",title);
    [super setTitle:title forState:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    NSLog(@"titlessssssssssss%@",title);

    [super setAttributedTitle:title forState:state];
}


@end

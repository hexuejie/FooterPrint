//
//  StarView.m
//  NongChengVacation
//
//  Created by 陈小卫 on 17/5/5.
//  Copyright © 2017年 Feizhuo. All rights reserved.
//

#import "StarView.h"

@implementation StarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//placeholder_method_impl//
-(void) setData:(id)data{
    NSString * score = data;
    if (score) {
        NSInteger iscore = [score integerValue];
        
        self.img01.highlighted = iscore >= 0;
        self.img02.highlighted = iscore > 1;
        //placeholder_method_call//
        self.img03.highlighted = iscore > 2;
        self.img04.highlighted = iscore > 3;
        self.img05.highlighted = iscore > 4;
    }
    self.img01.highlighted = YES;
}

@end

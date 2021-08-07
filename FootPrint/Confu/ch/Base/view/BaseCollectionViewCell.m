//
//  BaseCollectionViewCell.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}
//placeholder_method_impl//

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        //placeholder_method_call//

    }
    return self;
}
//placeholder_method_impl//

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}


/**
 给子类去实现
 */
-(void)setupUI{
    //placeholder_method_call//

}

@end

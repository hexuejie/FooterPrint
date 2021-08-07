//
//  BaseTableViewCell.m
//  VegetableBasket
//
//  Created by Silence on 2017/1/13.
//  Copyright © 2017年 YHS. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //placeholder_method_call//


    // Configure the view for the selected state
}
//placeholder_method_impl//

//
//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}
//
//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}
//
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //placeholder_method_call//

        [self setupUI];
    }
    return self;
}
//placeholder_method_impl//


/**
 给子类去实现
 */
-(void)setupUI{
    
}
//placeholder_method_impl//


#pragma mark - 计算高度
+(CGFloat)countHeight:(id)data{

    return 0;
}


@end

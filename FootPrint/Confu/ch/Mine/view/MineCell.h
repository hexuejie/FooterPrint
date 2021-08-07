//
//  MineCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblVip;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblMessageNum;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

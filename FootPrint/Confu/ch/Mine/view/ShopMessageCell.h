//
//  ShopMessageCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopMessageCell : UITableViewCell

@property (nonatomic, strong) ShopMessageModel *model;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_method_declare//
//placeholder_method_declare//

//placeholder_property//

@end

NS_ASSUME_NONNULL_END

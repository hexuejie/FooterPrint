//
//  LiveTeacherCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LiveTeacherCell : UITableViewCell

@property (nonatomic, strong) TeachersModel *model;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UILabel *lblName;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;

@end

NS_ASSUME_NONNULL_END

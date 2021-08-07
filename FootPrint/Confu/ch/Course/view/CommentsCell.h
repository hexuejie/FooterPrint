//
//  CommentsCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsFootModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsCell : UITableViewCell

@property (nonatomic, strong) CommentsFootModel *model;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnCommentsNum;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblReply;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csSpacing;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cslblTopSpacing;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cslblBottomSpacing;
//placeholder_property//
@end

NS_ASSUME_NONNULL_END

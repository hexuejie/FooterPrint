//
//  GroupJoinCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/5/10.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupJoinCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface GroupJoinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;

- (IBAction)goingToJoinAction:(UIButton *)sender;
@property (nonatomic,strong)GroupingModel *model;
@property (nonatomic,strong)GroupUserModel *userModel;
@property (weak, nonatomic) IBOutlet UILabel *commandLabel;
@property (nonatomic, copy) void (^BlockJoinClick)(GroupingModel *model);


@end

NS_ASSUME_NONNULL_END

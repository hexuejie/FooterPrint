//
//  SaleSuperCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/4/29.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SaleSuperCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *content;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (nonatomic, copy) void (^BlockClick)(CourslModel *);
- (IBAction)moreAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END

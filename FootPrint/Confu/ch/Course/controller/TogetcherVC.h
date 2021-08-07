//
//  TogetcherVC.h
//  FootPrint
//
//  Created by 胡翔 on 2021/5/8.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface TogetcherVC : BaseVC
@property (nonatomic, strong) NSString *t_id;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *spellPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *statusBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csStatusBgView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupShowLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTableView;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsType;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, copy) void (^BlockBackClick)(void);

@property (weak, nonatomic) IBOutlet UIImageView *smallImgView;
@property (nonatomic, strong) NSString *type_id;


@property (nonatomic, assign) int myCourseTypes;

@property (weak, nonatomic) IBOutlet UILabel *returnLabel;

- (IBAction)clickAction:(id)sender;

@end

NS_ASSUME_NONNULL_END

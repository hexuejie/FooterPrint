//
//  CourseListCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/3/16.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourseListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *lblPeople;

@property (weak, nonatomic) IBOutlet UILabel *lblNum;
@property (weak, nonatomic) IBOutlet UIImageView *moneyIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *topLineView;

@property (weak, nonatomic) IBOutlet UIImageView *imgType;

@property (weak, nonatomic) IBOutlet UILabel *lblLiveStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblLiveTime;
@property (nonatomic, strong) CourslModel *courseModel;

@property (weak, nonatomic) IBOutlet UIView *imgBgView;

@property (weak, nonatomic) IBOutlet UIButton *studyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *groupIconImgView;
@property (weak, nonatomic) IBOutlet UIView *groupPriceBgView;
@property (weak, nonatomic) IBOutlet UILabel *groupPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeSaleImgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csImgTop;







@end

NS_ASSUME_NONNULL_END

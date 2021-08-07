//
//  SaleListCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/4/29.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourslModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SaleListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *ImgPeople;

@property (weak, nonatomic) IBOutlet UILabel *lblNum;
@property (weak, nonatomic) IBOutlet UIImageView *moneyIconImgView;

@property (nonatomic, strong) CourslModel *courseModel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *imgBgView;

@property (weak, nonatomic) IBOutlet UIButton *lastTimeBtn;
@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csrightConst;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;

@property (weak, nonatomic) IBOutlet UIButton *studyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *saleIconImgView;






@end

NS_ASSUME_NONNULL_END

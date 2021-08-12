//
//  MineHeadView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MineHeadView.h"

@interface MineHeadView ()

@end

@implementation MineHeadView

- (void)awakeFromNib{

    [super awakeFromNib];
    
}
//placeholder_method_impl//

- (IBAction)btnCompleteClick:(id)sender {
    
    if (self.BlockOperationClick) {
        self.BlockOperationClick(1);
    }
}
//placeholder_method_impl//

- (IBAction)IntegralClick:(id)sender {
    
    if (self.BlockOperationClick) {
         //placeholder_method_call//
        self.BlockOperationClick(2);
    }
}
//placeholder_method_impl//

- (void)setModel:(UserModel *)model{
    
    _model = model;

    self.lblTitle.text = model.user.nickname;
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:model.user.face] placeholderImage: [UIImage imageNamed:@"head_default"]];
    
    if ([model.is_agent integerValue] == 1) {
        //placeholder_method_call//

        
        self.imgAgent.hidden = NO;
        [self.imgAgent sd_setImageWithURL:APP_IMG(model.agent_img)];
    }else{
        
        self.imgAgent.hidden = YES;
    }
    
//    是否是会员0未购买 -1过期 1未过期 2 终身
    if ([model.vip integerValue] == 1 || [model.vip integerValue] == 2) { //购买
        
        self.lblTime.hidden = NO;
        self.lblTime.text = [NSString stringWithFormat:@"%@到期",model.expire_time];
      
        if ([model.vip integerValue] == 2) {
           
            self.lblTime.text = @"终身";
        }
    }else if ([model.vip integerValue] == -1){ //已过期
        
       
        self.lblTime.hidden = YES;
    }else{ //未购买
        
     
        self.lblTime.hidden = YES;
    }
    self.lblCourseNum.text = model.study_complete;
    self.lblIntegral.text = model.now_integral;
    //placeholder_method_call//

    
    if ([model.vip integerValue] > 0) { //购买
        NSString *weekDayStr = @"日";
       NSInteger weekDay = [self getWeekDayFordate];
        switch (weekDay) {
            case 1:
                weekDayStr = @"一";
                break;
            case 2:
                weekDayStr = @"二";
                break;
            case 3:
                weekDayStr = @"三";
                break;
            case 4:
                weekDayStr = @"四";
                break;
            case 5:
                weekDayStr = @"五";
                break;
            case 6:
                weekDayStr = @"六";
                break;
                
            default:
                break;
        }
        self.vipTitleLabel.text = [NSString stringWithFormat:@"周%@好，脚印VIP",weekDayStr];
        self.vipContentLabel.text = @"会员中心";
    }else{ //未购买
        self.vipTitleLabel.text = @"成为脚印VIP";
        self.vipContentLabel.text = @"享多门会员课与购课优惠";
    }
    
    
    [self createLearnView];
}


- (void)createLearnView{
    
    NSArray *weekAry = self.model.week;
    
    for (UIView *view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    CGFloat width = SCREEN_WIDTH/weekAry.count;
    for (int i=0; i<weekAry.count; i++) {
        
        WeekModel *model = weekAry[i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, width, 100)];
        [self.scrollView addSubview:view];
        
        UIView *view1 = [[UIView alloc] init];
        view1.layer.cornerRadius = 12;
        view1.layer.masksToBounds = YES;
        [view addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(24);
            make.centerX.mas_equalTo(view);
            make.top.mas_equalTo(16);;
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(192, 196, 204);
        label.font = [UIFont systemFontOfSize:11.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%@\n%@",model.week,model.date];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(view1);
            make.leading.mas_equalTo(view);
            make.trailing.mas_equalTo(view);
            make.top.mas_equalTo(view1.mas_bottom).offset(8);
        }];
        //placeholder_method_call//

//        学习记录 0未到日期 1已学习 2未学习
//        是否是今天 0不是 1是
        if ([model.is_day integerValue] == 1) {
            view1.layer.borderWidth = 2;
            view1.layer.borderColor = RGB(96, 98, 102).CGColor;
            label.textColor = RGB(48, 49, 51);
        }
        if ([model.study integerValue] == 0) {
            
            view1.backgroundColor = [UIColor clearColor];
            view1.layer.borderWidth = 2;
            view1.layer.borderColor = RGB(220, 223, 230).CGColor;
        }else if ([model.study integerValue] == 1){
            
            view1.backgroundColor = RGB(4, 134, 254);
        }else if ([model.study integerValue] == 2){
            
            view1.backgroundColor = RGB(245, 108, 108);
        }
    }
}
//placeholder_method_impl//

- (IBAction)clickToLoginAction:(UIButton *)sender {
     if (self.BlockOperationClick) {
           self.BlockOperationClick(3);
       }
    
}



- (NSInteger)getWeekDayFordate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *comps = [[NSDateComponents alloc] init];

    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |

    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDate *now = [NSDate date];

    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    comps = [calendar components:unitFlags fromDate:now];

    return [comps weekday] - 1;
}
@end

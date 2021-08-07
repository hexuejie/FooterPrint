//
//  DataSelecter.h
//  Mother
//
//  Created by 陈小卫 on 15/8/20.
//  Copyright (c) 2015年 feizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DateSelecterDelegate <NSObject>
//
//-(void) didSelectedDate:(NSDate *) date;
//
//@end

@interface DataSelecter : UIView

@property (strong, nonatomic) NSDate *selectDate;
@property (strong, nonatomic) UIDatePicker *datePicker;


- (void)showInView:(UIView *)aView animated:(BOOL)animated;

- (void)showInView:(UIView *)aView :(NSDate *)selDate animated:(BOOL)animated;

//@property (weak, nonatomic) id<DateSelecterDelegate> delegate;

//选择时间block
@property (nonatomic, copy) void (^selectDateComplete)(NSDate *date);

@end

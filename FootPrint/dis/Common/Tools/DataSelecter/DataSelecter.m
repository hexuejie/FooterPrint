//
//  DataSelecter.m
//  Mother
//
//  Created by 陈小卫 on 15/8/20.
//  Copyright (c) 2015年 feizhuo. All rights reserved.
//

#import "DataSelecter.h"
#import "AppDelegate.h"
#import "NSDate+Extension.h"

@interface DataSelecter ()
@property (nonatomic, strong) UIView *mask;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UILabel *lblDate;
@end

@implementation DataSelecter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:[self CreateHeader]];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-dd-MM"];
        
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.frame = CGRectMake(0, 44, SCREEN_WIDTH, 206);
        self.datePicker.backgroundColor = [UIColor whiteColor];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePicker.locale = locale;
        
        NSDate* minDate = [self convertDateFromString:@"1900-01-01 00:00:00" withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* maxDate =  [self convertDateFromString:@"2999-01-01 00:00:00" withFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        [self.datePicker setMinimumDate:minDate];
        [self.datePicker setMaximumDate:maxDate];
        
        self.datePicker.minuteInterval = 10;
        
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_datePicker];
        
        self.date = [NSDate date];
        if (_selectDate != nil) {
            self.date = _selectDate;
        }
    }
    return self;
}

-(void) setSelectDate:(NSDate *)selectDate{
    if (selectDate) {
        self.datePicker.date = selectDate;
        _lblDate.text = [NSDate stringWithDate:selectDate format:@"YYYY年MM月dd日"];
    }
}


- (id)initWithFrame:(CGRect)frame :(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:[self CreateHeader]];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-dd-MM"];
        
        _datePicker = [[UIDatePicker alloc] init];
        self.datePicker.frame = CGRectMake(0, 44, SCREEN_WIDTH, 206);
        self.datePicker.backgroundColor = [UIColor whiteColor];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePicker.locale = locale;
        
        NSDate* minDate = [format dateFromString:@"1900-01-01 00:00:00"];
        NSDate* maxDate =  [self convertDateFromString:[self stringWithDateTimeNow] withFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        
        self.datePicker.minuteInterval = 10;
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        
        self.datePicker.minimumDate = minDate;
        self.datePicker.maximumDate = maxDate;
        

        
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_datePicker];
        
        self.date = [NSDate date];
        if (_selectDate != nil) {
            self.date = _selectDate;
        }
        
    }
    return self;
}

-(NSDate *)convertDateFromString:(NSString *)dateString withFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

-(NSString *) stringWithDateTimeNow
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init] ;
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [format stringFromDate: [NSDate date]];
    
    return dateStr;
}

-(UIView *)CreateHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = RGBA(0,150,255, 1.0);
    
    _lblDate = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 0, SCREEN_WIDTH-120, 44)];
    _lblDate.text = [NSDate stringWithDate:[NSDate date] format:@"YYYY年MM月dd日"];
    _lblDate.textColor = [UIColor whiteColor];
    _lblDate.font = [UIFont systemFontOfSize:15];
    
    UIButton *btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(8, 11, 60, 22)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btnOk = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-68, 11, 60, 22)];
    [btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(btnOkClick) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btnCancel];
    [headerView addSubview:btnOk];
    [headerView addSubview:_lblDate];
    return headerView;
}

-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    self.date = control.date;
    _lblDate.text = [NSDate stringWithDate:control.date format:@"YYYY年MM月dd日"];
}

- (void)btnOkClick {
//    [self.delegate didSelectedDate:_date];
    if(_selectDateComplete){
        _selectDateComplete(_date);
    }
    
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}

- (void)btnCancelClick {
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    CGRect rect = aView.frame;
    rect.origin.y -= 64;
    _mask = [[UIView alloc] initWithFrame:rect];
    self.mask.backgroundColor = [UIColor blackColor];
    self.mask.alpha = 0.5;
    
    [aView addSubview: _mask];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    if (animated) {
        [self fadeIn];
    }
}

- (void)showInView:(UIView *)aView :(NSDate *)selDate animated:(BOOL)animated
{
    CGRect rect = aView.frame;
    rect.origin.y -= 64;
    _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mask.backgroundColor = [UIColor blackColor];
    self.mask.alpha = 0.5;
    
    self.date = selDate;
    self.datePicker.date = selDate;
    
    [aView addSubview: _mask];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Private Methods
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end

//
//  SaleListCell.m
//  FootPrint
//
//  Created by 胡翔 on 2021/4/29.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "SaleListCell.h"

@implementation SaleListCell

- (UIImage *)imageWithColor:(UIColor *)color andUIImageage:(UIImage *)img {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *img = [UIImage imageNamed:@"course_time"];
  UIImage *newImg = [self imageWithColor:[UIColor whiteColor] andUIImageage:img];
    [self.lastTimeBtn setImage:newImg forState:UIControlStateNormal];
    // course_money
   img = [UIImage imageNamed:@"course_money"];
    newImg = [self imageWithColor:[UIColor colorWithHex:0xB2B2B2] andUIImageage:img];
    [self.moneyIconImgView setImage:newImg];
    self.imgBgView.layer.cornerRadius = 10.0;
    self.imgBgView.clipsToBounds = YES;
//    self.imgView.layer.cornerRadius = 10.0;
//    self.imgView.clipsToBounds = YES;
    
//    [self.lastTimeBtn setImage:newImg forState:UIControlStateNormal];
    // Initialization code
}
- (void)setCourseModel:(CourslModel *)courseModel {
    _courseModel = courseModel;
    self.lblPrice.textColor = [UIColor colorWithHex:0xB2B2B2];
    [self.imgView sd_setImageWithURL:APP_IMG(courseModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblPrice.text = [courseModel.price ChangePrice];
    self.lblDesc.text = courseModel.desc;
    //placeholder_method_call//
    self.lblNum.text = [NSString stringWithFormat:@"%ld人在学",[courseModel.virtual_amount integerValue] + [courseModel.study_count integerValue]];
    
    self.lblTitle.text = courseModel.title;
  
//    self.lblPrice
    [self.lastTimeBtn setTitle:@"" forState:UIControlStateNormal];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self startTime];
    
    if (courseModel.is_buy == 1) {
        self.statusLabel.text = @"已购买";
        self.bottomBgView.hidden = YES;
        self.studyBtn.hidden = NO;
        self.saleIconImgView.hidden = YES;
        self.lblPrice.text= courseModel.price;
       UIImage *img = [UIImage imageNamed:@"course_money"];
        [self.moneyIconImgView setImage:img];
        self.lblPrice.textColor = [UIColor colorWithHex:0xF1AF48];      
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@"优惠价 %@",courseModel.yh_price];
        self.bottomBgView.hidden = NO;
        self.studyBtn.hidden = YES;
        self.saleIconImgView.hidden = NO;
        NSMutableAttributedString*newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",courseModel.price]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.lblPrice.attributedText= newPrice;
    }
    //
    
    
    
   
}

- (void)startTime {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    
    // 如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
- (void)refreshLessTime {
    // SaleSuperCell
    
    
//    self.courseModel.end_time;
//    self.courseModel.end_time
   long currentTime = (long) [[NSDate date]timeIntervalSince1970];
    long  diff =  self.courseModel.end_time - currentTime;
    if (diff > 0) {
       NSString *st = [self lessSecondToDay:diff];
        [self.lastTimeBtn setTitle:st forState:UIControlStateNormal];
    } else {
        [self.lastTimeBtn setTitle:@"活动结束" forState:UIControlStateNormal];
    }
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)lessSecondToDay:(long)seconds
{
    if (seconds <= 0) {
        return @"活动结束";
    }
    
//    NSUInteger day  = (NSUInteger)seconds/(24*3600);
    NSUInteger hour = (NSUInteger)(seconds/(3600));
    NSUInteger min  = (NSUInteger)(seconds%(3600))/60;
    NSUInteger second = (NSUInteger)(seconds%60);
    
    NSString *time = [NSString stringWithFormat:@"活动结束:%lu:%02lu:%02lu",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
    return time;
    
}

@end

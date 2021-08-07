//
//  GroupJoinCell.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/10.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "GroupJoinCell.h"
@interface GroupJoinCell()
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation GroupJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.joinBtn.layer.cornerRadius = 4;
    self.joinBtn.layer.borderColor = [UIColor colorWithHex:0x0088ff].CGColor;
    self.joinBtn.layer.borderWidth = 1.0;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GroupingModel *)model {
    _model = model;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.head_face]];
    self.nameLabel.text = model.head_nickname;
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }

//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
    
    // 如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}
- (void)setUserModel:(GroupUserModel *)userModel {
    _userModel = userModel;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:userModel.face]];
    self.nameLabel.text = userModel.nickname;
    if (userModel.is_commander == 1) {
        self.commandLabel.hidden = NO  ;
        self.detailLabel.text = [NSString stringWithFormat:@"%@ 开团",userModel.create_date];
    } else {
        self.commandLabel.hidden = YES ;
        self.detailLabel.text = [NSString stringWithFormat:@"%@ 加入",userModel.create_date];

    }
    
}
- (void)refreshLessTime {
    // SaleSuperCell
    
    
//    self.courseModel.end_time;
//    self.courseModel.end_time
   int currentTime = (int) [[NSDate date]timeIntervalSince1970];
    int end_time = self.model.end_time;
    
 int  diff =  end_time - currentTime;
    if (diff > 0) {
       NSString *st = [self lessSecondToDay:diff];
        self.detailLabel.text = st;
        self.detailLabel.textColor = [UIColor colorWithHex:0x479298];
//        [self.detailLabel addAttrbuteColorWithAttributeText:@[@"活动结束还剩",@"时",@"分",@"秒"] withAttrArrayColor:@[[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2]]];
        self.detailLabel.text = st;
     } else {
         self.detailLabel.text = @"活动结束";

    }
    
    
    
    
    
    
    
}

- (NSString *)lessSecondToDay:(long)seconds
{
    if (seconds <= 0) {
        return @"活动结束";
    }
    
    NSUInteger day  = (NSUInteger)seconds/(24*3600);
    NSInteger hour = (NSInteger)(seconds/(3600));
    NSInteger min  = (NSInteger)(seconds%(3600))/60;
    NSInteger second = (NSInteger)(seconds%60);
    
    NSString *time = [NSString stringWithFormat:@"活动结束还剩  %lu 时 %lu 分  %lu 秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
    return time;
    
}


- (IBAction)goingToJoinAction:(UIButton *)sender {
    
    if (self.BlockJoinClick) {
        self.BlockJoinClick(self.model);
    }
}
@end

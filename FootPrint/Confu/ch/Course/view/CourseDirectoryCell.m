//
//  CourseDirectoryCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseDirectoryCell.h"

@interface CourseDirectoryCell ()

@property (nonatomic, strong)UIImageView *imgNew;

@property (nonatomic, strong)UIImageView *imgFree;

@end

@implementation CourseDirectoryCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgNew = [[UIImageView alloc] init];
    self.imgNew.image = [UIImage imageNamed:@"course_new"];
    [self.contentView addSubview:self.imgNew];
    //placeholder_method_call//

    self.imgFree = [[UIImageView alloc] init];
//    self.imgFree.image = [UIImage imageNamed:@"course_free"];
    [self.contentView addSubview:self.imgFree];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}
//placeholder_method_impl//

- (void)setPlayerModel:(CoursePlayerFootModel *)playerModel{
    
    self.imgFree.hidden = YES;
    self.imgNew.hidden = YES;
    self.lblLiveStatus.hidden = YES;
    [self.imgFree setImage:nil];
    //placeholder_method_call//

    self.lblTitle.text = playerModel.title;
    
    NSInteger liveStatus = [playerModel.live_state integerValue];
    if (liveStatus == 0) {
        
        self.lblTime.text = playerModel.lenght;
        self.imgIcon.image = [UIImage imageNamed:@"course_time"];
        if ([playerModel.is_new integerValue] == 1) { //最新
            
            self.imgNew.hidden = NO;
            [self.imgNew mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.leading.mas_equalTo(self.lblTime.mas_trailing).offset(12);
                make.centerY.mas_equalTo(self.lblTime);
            }];
            
            if ([playerModel.free integerValue] == 1) { // 可以免费观看

                if (self.goodsType == 1) { //视频
                    
                    self.imgFree.image = [UIImage imageNamed:@"course_free_video"];
                }else{ //音频
                    
                    self.imgFree.image = [UIImage imageNamed:@"course_free"];
                }
                self.imgFree.hidden = NO;
                
                [self.imgFree mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.leading.mas_equalTo(self.imgNew.mas_trailing).offset(12);
                    make.centerY.mas_equalTo(self.imgNew);
                }];
            } else {
//                self.imgFree.hidden = YES;

            }
        }else{
            if ([playerModel.free integerValue] == 1) { // 可以免费观看
                
//                self.imgFree.hidden = NO;
                UIImageView *imgFree = [[UIImageView alloc] init];
                imgFree.tag = 888;
//                if (self.goodsType == 1) { //视频
//
//                    imgFree.image = [UIImage imageNamed:@"course_free_video"];
//                }else{ //音频
//
//                    imgFree.image = [UIImage imageNamed:@"course_free"];
//                }
//                [self.contentView addSubview:imgFree];
//                [imgFree mas_makeConstraints:^(MASConstraintMaker *make) {
//
//                    make.leading.mas_equalTo(self.lblTime.mas_trailing).offset(12);
//                    make.centerY.mas_equalTo(self.lblTime);
//                }];
                if (self.goodsType == 1) { //视频
                    
                    self.imgFree.image = [UIImage imageNamed:@"course_free_video"];
                }else{ //音频
                    
                    self.imgFree.image = [UIImage imageNamed:@"course_free"];
                }
                self.imgFree.hidden = NO;
                
                [self.imgFree mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.leading.mas_equalTo(self.lblTime.mas_trailing).offset(12);
                    make.centerY.mas_equalTo(self.lblTime);
                }];
                
                
            } else {
//               UIImageView *imgFree = (UIImageView *)[self.contentView viewWithTag:888];
//                if (imgFree) {
//                    [imgFree removeFromSuperview];
//                }
            }
        }
        
        
    }else{
        
        self.lblTime.text = playerModel.timeText;
        //    状态 1-直播中 2-待直播 3-已结束
        self.lblLiveStatus.hidden = NO;
        self.imgIcon.image = [UIImage imageNamed:@"icon_live"];
        self.lblLiveStatus.text = liveStatus == 1?@"正在直播":liveStatus == 2?@"即将直播":liveStatus == 3?@"直播回放":@"";
        self.lblLiveStatus.backgroundColor = liveStatus == 1?RGB(103, 194, 58):liveStatus == 2?RGB(4, 134, 254):liveStatus == 3?RGB(255, 164, 0):[UIColor clearColor];
    }
}
//placeholder_method_impl//

@end

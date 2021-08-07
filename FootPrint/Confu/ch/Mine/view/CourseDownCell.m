//
//  CourseDownCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/17.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseDownCell.h"
#import "YCDownloadManager.h"

@interface CourseDownCell ()<YCDownloadItemDelegate>

@property (nonatomic, assign) NSInteger FinishedNum;

@end

@implementation CourseDownCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//placeholder_method_impl//

- (void)setModel:(CourseDetailModel *)model{
    
    _model = model;
    
    [self reloadCell];
    //placeholder_method_call//

}

- (void)downloadItemStatusChanged:(nonnull YCDownloadItem *)item{
    
    [self reloadCell];
}
//placeholder_method_impl//
- (void)downloadItem:(nonnull YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize{
    
}

- (void)downloadItem:(nonnull YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc{
    
}

- (void)reloadCell{
    
    [self.imgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = self.model.title;
    //placeholder_method_call//

    NSArray *downAry = [YCDownloadManager itemsWithDownloadCid:self.model.cid];
    //    课程类型1:视频；2:音频
    if ([self.model.goods_type integerValue] == 1) { //视频
        
        self.imgType.image = [UIImage imageNamed:@"course_video"];
        self.lblCount.text = [NSString stringWithFormat:@"%ld个视频",downAry.count];
    }else{
        
        self.imgType.image = [UIImage imageNamed:@"course_mp3"];
        self.lblCount.text = [NSString stringWithFormat:@"%ld个音频",downAry.count];
    }
    
    CGFloat downSize = 0;
    BOOL isDownloading = NO;
    self.FinishedNum = 0;
    for (YCDownloadItem *item in downAry) {
        
        item.delegate = self;
        CoursePlayerFootModel *downModel = [CoursePlayerFootModel infoWithData:item.extraData];
        downSize = downSize + [downModel.size floatValue];
        if (item.downloadStatus == YCDownloadStatusFinished) {
            self.FinishedNum ++;
        }else if (item.downloadStatus == YCDownloadStatusDownloading) {
            
            isDownloading = YES;
        }
    }
    //placeholder_method_call//

    self.lblContent.text = [NSString stringWithFormat:@"%.2fM",downSize];
    
    if (self.FinishedNum == downAry.count) { //全部下载完成
        
        self.imgDownStatus.hidden = YES;
    }else {
        
        if (isDownloading){
            
            self.imgDownStatus.image = [UIImage imageNamed:@"down_start_g"];
        }else{
            
            self.imgDownStatus.image = [UIImage imageNamed:@"down_waiting_g"];
        }
    }
}

- (void)setIsEdit:(BOOL)isEdit{
    
    if (isEdit) { //编辑
        //placeholder_method_call//

        self.btnSelect.hidden = NO;
        self.csBtnSelectWidth.constant = 40;
    }else{
        
        self.btnSelect.hidden = YES;
        self.csBtnSelectWidth.constant = 0;
    }
}
//placeholder_method_impl//

@end

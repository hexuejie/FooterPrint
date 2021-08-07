//
//  MineDownLoadCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "MineDownLoasCell.h"
#import "YCDownloadManager.h"
#import "YZXProgressBarView.h"

@interface MineDownLoasCell ()<YCDownloadItemDelegate>

@property (nonatomic, assign) NSInteger FinishedNum;

@property (nonatomic, strong) YZXProgressBarView *progress;

@end

@implementation MineDownLoasCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
//placeholder_method_impl//

- (YZXProgressBarView *)progress{
    
    if (_progress == nil) {
        
        _progress = [[YZXProgressBarView alloc] initWithFrame:CGRectMake(6, 0, (SCREEN_WIDTH/3.8)-12, 6) type:progressBar];
        _progress.progressBarBGC = RGB(187, 187, 187);
        _progress.fillColor = [UIColor whiteColor];
        //placeholder_method_call//

        _progress.layer.cornerRadius = 3;
        _progress.layer.masksToBounds = YES;
        [self.viewDownProgress addSubview:_progress];
    }
    
    return _progress;
}
//placeholder_method_impl//

- (void)setLearnModel:(LearnRecordModel *)learnModel{
    
    [self.imgView sd_setImageWithURL:APP_IMG(learnModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = learnModel.course_title;
    self.lblProgress.text = [NSString stringWithFormat:@"已学习%.0f%%",[learnModel.percentage doubleValue]*100];
    
    self.lblSize.hidden = YES;
    self.viewHazy.hidden = YES;
    
    self.viewDownProgress.hidden = YES;
    self.csViewDownProgressHeight.constant = 0;
}
//placeholder_method_impl//

- (void)setDownModel:(CourseDetailModel *)DownModel{
    
    _DownModel = DownModel;
    //placeholder_method_call//

    [self reloadCell];
}

- (void)reloadCell{
    
    [self.imgView sd_setImageWithURL:APP_IMG(self.DownModel.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = self.DownModel.title;
    self.viewProgress.hidden = YES;
    //placeholder_method_call//

    self.FinishedNum = 0;
    CGFloat size = 0;
    BOOL isDownloading = NO;
    NSArray *downAry = [YCDownloadManager itemsWithDownloadCid:self.DownModel.cid];
    for (YCDownloadItem *item in downAry) {
        
        item.delegate = self;
        CoursePlayerFootModel *model = [CoursePlayerFootModel infoWithData:item.extraData];
        if (item.downloadStatus == YCDownloadStatusFinished) {
            self.FinishedNum ++;
            size = size + [model.size floatValue];
        }else if (item.downloadStatus == YCDownloadStatusDownloading) {
            
            isDownloading = YES;
        }
    }
    
    if (self.FinishedNum == downAry.count) { //全部下载完成
        
        self.lblSize.text = [NSString stringWithFormat:@"已下载%.1fM",size];
        self.csViewDownProgressHeight.constant = 0;
        self.viewDownProgress.hidden = YES;
    }else {
        
        CGFloat progress = (self.FinishedNum*1.0)/downAry.count;
        self.progress.loadingProgress = progress;

        self.viewDownProgress.hidden = NO;
        self.csViewDownProgressHeight.constant = 12;
        if (isDownloading){
            
            self.lblSize.text = @"下载中";
        }else{
            
            self.lblSize.text = @"等待中";
        }
    }
}

- (void)downloadItemStatusChanged:(nonnull YCDownloadItem *)item{
    //placeholder_method_call//

    [self reloadCell];
}

- (void)downloadItem:(nonnull YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize{
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)downloadItem:(nonnull YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc{
    //placeholder_method_call//

}
//placeholder_method_impl//

@end

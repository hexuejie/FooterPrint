//
//  DownLoadCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/20.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "DownLoadCell.h"
#import "YZXProgressBarView.h"

@interface DownLoadCell ()<YCDownloadItemDelegate>

@property (nonatomic, strong) YZXProgressBarView *ProgressBarView;

@property (nonatomic, strong) CoursePlayerFootModel *model;

@end

@implementation DownLoadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(YCDownloadItem *)item {
    
    _item = item;
    item.delegate = self;
    
    self.model = [CoursePlayerFootModel infoWithData:item.extraData];
    
    self.lblTitle.text = self.model.title;
    self.lblTime.text = self.model.lenght;
    self.lblMemory.text = [NSString stringWithFormat:@"%@M",self.model.size];
    
    if ([self.model.is_new integerValue] == 1) {
        
        self.lblNew.hidden = NO;
    }else{
        
        self.lblNew.hidden = YES;
    }
    
    [self changeSizeLblDownloadedSize:item.downloadedSize totalSize:item.fileSize];
    [self setDownloadStatus:item.downloadStatus];
}

- (void)changeSizeLblDownloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    
    self.lblMemory.text = [NSString stringWithFormat:@"%@/%.1fM",[YCDownloadUtils fileSizeStringFromBytes:downloadedSize], [self.model.size floatValue]];
    
    float progress = 0;
    if (totalSize != 0) {
        progress = (float)downloadedSize / totalSize;
    }
    self.ProgressBarView.loadingProgress = progress;
}

- (void)downloadItemStatusChanged:(YCDownloadItem *)item {
    [self setDownloadStatus:item.downloadStatus];
}

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    
    [self changeSizeLblDownloadedSize:downloadedSize totalSize:totalSize];
}

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
    self.lblSpeed.text = speedDesc;
}

- (void)setDownloadStatus:(YCDownloadStatus)status {
    
    self.lblSpeed.hidden = YES;
    switch (status) {
        case YCDownloadStatusWaiting:
            
            self.imgStatus.image = [UIImage imageNamed:@"down_waiting"];
            self.viewProgress.hidden = NO;
            self.csViewProgressWidth.constant = 40;
            
            break;
        case YCDownloadStatusDownloading:
            
            self.imgStatus.image = [UIImage imageNamed:@"down_stop"];
            self.viewProgress.hidden = NO;
            self.csViewProgressWidth.constant = 40;
            self.lblSpeed.hidden = NO;
            
            break;
        case YCDownloadStatusPaused:
            
            self.imgStatus.image = [UIImage imageNamed:@"down_start"];
            self.viewProgress.hidden = NO;
            self.csViewProgressWidth.constant = 40;
            
            break;
        case YCDownloadStatusFinished:
            
            self.imgStatus.image = [UIImage imageNamed:@""];
            self.viewProgress.hidden = YES;
            self.csViewProgressWidth.constant = 0;
            self.lblMemory.text = [NSString stringWithFormat:@"%@M",self.model.size];
            
            break;
        case YCDownloadStatusFailed:
            
            self.imgStatus.image = [UIImage imageNamed:@"down_start"];
            self.viewProgress.hidden = NO;
            self.csViewProgressWidth.constant = 40;
            
            break;
            
        default:
            break;
    }
}

- (YZXProgressBarView *)ProgressBarView{
    
    if (_ProgressBarView == nil) {
        
        _ProgressBarView = [[YZXProgressBarView alloc] initWithFrame:CGRectMake(0, 22, 30, 30) type:loopProgressBar];
        _ProgressBarView.progressBarBGC = [UIColor clearColor];
        _ProgressBarView.strokeColor = RGB(0, 136, 255);
        [self.viewProgress addSubview:_ProgressBarView];
    }
    
    return _ProgressBarView;
}

- (void)setIsEdit:(BOOL)isEdit{
    
    if (isEdit) { //编辑
        
        self.btnSelect.hidden = NO;
        self.csBtnSelectWidth.constant = 40;
    }else{
        
        self.btnSelect.hidden = YES;
        self.csBtnSelectWidth.constant = 0;
    }
}

@end

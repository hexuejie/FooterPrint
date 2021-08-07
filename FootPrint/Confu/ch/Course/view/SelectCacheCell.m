
//
//  SelectCacheCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/16.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SelectCacheCell.h"
#import "UIImage+GIF.h"

@interface SelectCacheCell ()<YCDownloadItemDelegate>

@property (nonatomic, strong) UIImage *gifImg;

@end

@implementation SelectCacheCell
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //placeholder_method_call//

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}

- (void)setPlayerModel:(CoursePlayerFootModel *)playerModel{
    
    _playerModel = playerModel;
    
    self.lblTitle.text = playerModel.title;
    //placeholder_method_call//

    self.lblTime.text = [NSString stringWithFormat:@"%@ | %@M",playerModel.lenght,playerModel.size];
    self.imgDownStatus.image = [UIImage imageNamed:@""];
    
////    1正在缓存 2暂停 3缓存成功
//    if (playerModel.downLoadStatus == 0) {
//
//        self.imgDownStatus.image = [UIImage imageNamed:@""];
//    }else if (playerModel.downLoadStatus == 1){
//
//        self.imgDownStatus.image = self.gifImg;
//    }else if (playerModel.downLoadStatus == 2) {
//
//        self.imgDownStatus.image = [UIImage imageNamed:@"down_load"];
//    }else if (playerModel.downLoadStatus == 3) {
//
//        self.imgDownStatus.image = [UIImage imageNamed:@"down_succes"];
//    }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)setItem:(YCDownloadItem *)item {
    
    _item = item;
    
    item.delegate = self;
    //placeholder_method_call//

    CoursePlayerFootModel *playerModel = [CoursePlayerFootModel infoWithData:item.extraData];
    self.lblTitle.text = playerModel.title;
    self.lblTime.text = [NSString stringWithFormat:@"%@ | %@M",playerModel.lenght,playerModel.size];
    
    [self setDownloadStatus:item.downloadStatus];
}

- (UIImage *)gifImg{

    if (_gifImg == nil) {

        NSString *path = [[NSBundle mainBundle] pathForResource:@"download" ofType:@"gif"];
       //placeholder_method_call//

        NSData *data = [NSData dataWithContentsOfFile:path];
        _gifImg = [UIImage sd_animatedGIFWithData:data];
    }

    return _gifImg;
}

- (void)downloadItemStatusChanged:(YCDownloadItem *)item {
    //placeholder_method_call//

    [self setDownloadStatus:item.downloadStatus];
}

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    //placeholder_method_call//

}

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
    //placeholder_method_call//

}

- (void)setDownloadStatus:(YCDownloadStatus)status {
    NSString *imgStr = @"";
    //placeholder_method_call//

    switch (status) {
        case YCDownloadStatusWaiting:
            self.imgDownStatus.image = [UIImage imageNamed:@"down_load"];
            break;
        case YCDownloadStatusDownloading:
            self.imgDownStatus.image = self.gifImg;
            break;
        case YCDownloadStatusPaused:
            self.imgDownStatus.image = [UIImage imageNamed:@"down_load"];
            break;
        case YCDownloadStatusFinished:
            self.imgDownStatus.image = [UIImage imageNamed:@"down_succes"];
            break;
        case YCDownloadStatusFailed:
            self.imgDownStatus.image = [UIImage imageNamed:@""];
            break;
            
        default:
            break;
    }
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

@end

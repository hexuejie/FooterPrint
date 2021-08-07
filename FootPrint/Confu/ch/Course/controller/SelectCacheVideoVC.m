//
//  SelectCacheVideoVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SelectCacheVideoVC.h"
#import "SelectCacheCell.h"
#import "CourseDirectoryGroupView.h"
#include <sys/param.h>
#include <sys/mount.h>
#import "UIAlertController+Blocks.h"
#import "DownLoadVC.h"
#import "YCDownloadManager.h"
#import "SLYDESCryptor.h"
#import "UIAlertController+Blocks.h"
#import "SetVC.h"
#import "CoreStatus.h"
#import "ChapterModel.h"
@interface SelectCacheVideoVC ()<YCDownloadItemDelegate>

/** 展开合并状态*/
@property (nonatomic, strong) NSMutableArray *stateAry;

@property (nonatomic, strong) CourseDirectoryGroupView *groupView;

@property (nonatomic, strong) CourseDetailModel *model;

@end

@implementation SelectCacheVideoVC

#pragma mark - yy类注释逻辑
//placeholder_method_impl//

- (void)viewWillAppear:(BOOL)animated{
    //placeholder_method_call//

    [self.tableView reloadData];
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title = @"选择缓存的视频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.stateAry = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight-75)];
    self.additionalHeight = 0; //设置额外高度
    //placeholder_method_call//

    [self addDefaultFootView];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectCacheCell" bundle:nil] forCellReuseIdentifier:@"SelectCacheCell"];
    
    [self createMemoryView];
    
    [self loadData];
}
//placeholder_method_impl//

#pragma mark - 生命周期

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//placeholder_method_call//

    return self.model.chapter_video.count;
}
//placeholder_method_impl//

#pragma mark- 展开分区核心代码(1)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.stateAry[section] isEqualToString:@"1"]) {
        //placeholder_method_call//

        return self.model.chapter_video[section].video_list.count;
    } else {
        return 0;
    }
}
//placeholder_method_impl//

#pragma mark - 设置分组的高度
// 必须设置分区头高度，否则不显示。
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    return 75;
}
//placeholder_method_impl//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCacheCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //placeholder_method_call//

    CoursePlayerFootModel *model = self.model.chapter_video[indexPath.section].video_list[indexPath.row];
    cell.playerModel = model;
    YCDownloadItem *item = [YCDownloadManager itemWithFileId:model.did];
    if (item) {
        [cell setDownloadStatus:item.downloadStatus];
    }
 
    cell.lblNumber.text = [NSString stringWithFormat:@"%ld.%ld",indexPath.section+1,indexPath.row+1];
    
    return cell;
}
//placeholder_method_impl//

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.groupView = [[[NSBundle mainBundle] loadNibNamed:@"CourseDirectoryGroupView" owner:nil options:nil] lastObject];
    self.groupView.lblTitile.text = self.model.chapter_video[section].cate_name;
    self.groupView.lblNumber.text = [NSString stringWithFormat:@"%ld",section+1];
    self.groupView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
  //placeholder_method_call//

    self.groupView.btn.tag = section+1;
    [self.groupView.btn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.stateAry[section] isEqualToString:@"1"]) {

        self.groupView.imgStatus.image = [UIImage imageNamed:@"ic_open"];
    }else{
        self.groupView.imgStatus.image = [UIImage imageNamed:@"ic_close"];
    }

    return self.groupView;
}
//placeholder_method_impl//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CoursePlayerFootModel *model = self.model.chapter_video[indexPath.section].video_list[indexPath.row];
    
    CourseDetailModel *detailM = [CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",self.model.cid]];
    //placeholder_method_call//

    NSData * data = [[NSData alloc] initWithBase64EncodedString:model.download_path options:0];
    NSString * key = @"12345678";
    SLYDESCryptor * decry = [[SLYDESCryptor alloc] initToDecryptInputData:data keyData:[key dataUsingEncoding:NSUTF8StringEncoding] completionHandle:^(NSData *outputData, NSError *error) {
        
        NSString *outputStr = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
        NSString *downLoadPath = [outputStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
        
        if (downLoadPath.length == 0) {
            
            [KeyWindow showTip:@"找不到下载路径"];
            return ;
        }
        YCDownloadItem *item = [YCDownloadManager itemWithFileId:model.did];
        if (!item) {
            item = [YCDownloadItem itemWithUrl:downLoadPath fileId:model.did downloadCid:model.cid];
            item.extraData = [CoursePlayerFootModel dateWithInfoModel:model];
            item.enableSpeed = true;
            item.delegate = self;
            [YCDownloadManager startDownloadWithItem:item];
            
            if (!detailM) {
                
                [self.model save];
            }
        }else{
            
            [KeyWindow showTip:@"已存在缓存列表"];
        }
        [self.tableView reloadData];
        if (![[CoreStatus currentNetWorkStatusString] isEqualToString:@"Wifi"]) { //非wifi
            if (![YCDownloadManager isAllowsCellularAccess]){
                
                [UIAlertController showAlertInViewController:self withTitle:@"" message:@"添加成功，当前设置仅在WiFi下缓存 如仍需下载请至「设置」开启" cancelButtonTitle:@"仅WiFi下载" destructiveButtonTitle:@"去设置" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    
                    if (buttonIndex == 1) {
                        
                        SetVC *next = [[SetVC alloc] init];
                        [self.navigationController pushViewController:next animated:YES];
                    }
                }];
            }
        }
    }];
    
    [[NSOperationQueue new] addOperation:decry];
}
//placeholder_method_impl//

#pragma mark 自定义代理

- (void)downloadItemStatusChanged:(YCDownloadItem *)item{
    //placeholder_method_call//

    [self.tableView reloadData];
}
//placeholder_method_impl//

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
    //placeholder_method_call//

}
//placeholder_method_impl//

#pragma mark - 事件

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    NSInteger currentTag = sender.tag - 1;
    //placeholder_method_call//

    if ([self.stateAry[currentTag] isEqual:@"1"]) {
        [self.stateAry replaceObjectAtIndex:currentTag withObject:@"0"];
    }else if([self.stateAry[currentTag] isEqual:@"0"]){
        [self.stateAry replaceObjectAtIndex:currentTag withObject:@"1"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:currentTag] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)AllDownLoadClick{
    
    NSInteger downCount = 0;
    for (CourseChapterModel *chapModel in self.model.chapter_video) {
        
        downCount = downCount + chapModel.video_list.count;
    }
    
    [UIAlertController showAlertInViewController:self withTitle:[NSString stringWithFormat:@"确定要缓存%ld个视频吗？",downCount] message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部缓存" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            if (![[CoreStatus currentNetWorkStatusString] isEqualToString:@"Wifi"]) { //非wifi
                if (![YCDownloadManager isAllowsCellularAccess]){
                    
                    [UIAlertController showAlertInViewController:self withTitle:@"" message:@"添加成功，当前设置仅在WiFi下缓存 如仍需下载请至「设置」开启" cancelButtonTitle:@"仅WiFi下载" destructiveButtonTitle:@"去设置" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        if (buttonIndex == 1) {
                            
                            SetVC *next = [[SetVC alloc] init];
                            [self.navigationController pushViewController:next animated:YES];
                        }
                    }];
                }
            }
            CourseDetailModel *detailM = [CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",self.model.cid]];
            if (!detailM) {
                
                [self.model save];
            }
            
            for (CourseChapterModel *chapModel in self.model.chapter_video) {
                
                for (CoursePlayerFootModel *downModel in chapModel.video_list) {
                    
                   __block YCDownloadItem *item = [YCDownloadManager itemWithFileId:downModel.did];
                    if (!item) {
                        
                        NSData * data = [[NSData alloc] initWithBase64EncodedString:downModel.download_path options:0];
                        NSString * key = @"12345678";
                        SLYDESCryptor * decry = [[SLYDESCryptor alloc] initToDecryptInputData:data keyData:[key dataUsingEncoding:NSUTF8StringEncoding] completionHandle:^(NSData *outputData, NSError *error) {
                            
                            NSString *outputStr = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
                            NSString *downLoadPath = [outputStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                            if (downLoadPath.length == 0) {
                                
                                [KeyWindow showTip:@"找不到下载路径"];
                                return ;
                            }
                            item = [YCDownloadItem itemWithUrl:downLoadPath fileId:downModel.did downloadCid:downModel.cid];
                            item.extraData = [CoursePlayerFootModel dateWithInfoModel:downModel];
                            item.enableSpeed = true;
                            item.delegate = self;
                            [YCDownloadManager startDownloadWithItem:item];
                        }];
                        
                        [[NSOperationQueue new] addOperation:decry];
                    }
                }
            }
            
            [self.tableView reloadData];
        }
    }];
}
//placeholder_method_impl//

- (void)LookDownLoadClick{
    //placeholder_method_call//

    DownLoadVC *next = [[DownLoadVC alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}
//placeholder_method_impl//

#pragma mark - 公开方法

- (void)loadData{
    //placeholder_method_call//
    
    
     [APPRequest GET:@"/courseDetail" parameters:@{@"id":self.cid} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [CourseDetailModel mj_objectWithKeyValues:result.data];
            for (NSInteger i = 0; i < self.model.chapter_video.count; i ++) {
                
                [self.stateAry addObject:@"1"];
            }
            //创建下载唯一id
            for (ChapterModel *chapM in self.model.chapter_video) {
                
                for (CoursePlayerFootModel *model in chapM.video_list) {
                    
                    model.did = [NSString stringWithFormat:@"%@%@",model.cid,model.id];
                }
            }
            [self.tableView reloadData];
        }
    }];
    
    
    
    /*
    

    [APPRequest GET:@"/courseDetail" parameters:@{@"id":self.cid} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [CourseDetailModel mj_objectWithKeyValues:result.data];
//            for (NSInteger i = 0; i < self.model.chapter_video.count; i ++) {
//
//                 [self.stateAry addObject:@"1"];
//            }
            
            
            NSMutableArray<CourseChapterModel *> *mutableChapter_video = [NSMutableArray array];
            
            
            // select the non-live video
            for (NSInteger i = 0; i < self.model.chapter_video.count; i ++) {

                [self.stateAry addObject:@"1"];
                CourseChapterModel *chapter_video = self.model.chapter_video[i];
                NSMutableArray<CoursePlayerModel *> *mutable_course_player_model = [NSMutableArray array];
                for (int j = 0; j < chapter_video.video_list.count; j ++) {
                    CoursePlayerModel *coursePlayerModel = chapter_video.video_list[j];
                    // if the video is not live, so I add to the download list.
                    if ([coursePlayerModel.live_state isEqualToString:@"0"]) {
                        [mutable_course_player_model addObject:coursePlayerModel];
                    }

                }
                [chapter_video setVideo_list:mutable_course_player_model];
                [mutableChapter_video addObject:chapter_video];
            }
            [self.model setChapter_video:mutableChapter_video];
            
            
            
            
            
            //创建下载唯一id
            for (CourseChapterModel *chapM in self.model.chapter_video) {
                
                for (CoursePlayerModel *model in chapM.video_list) {
                    
                    model.did = [NSString stringWithFormat:@"%@%@",model.cid,model.id];
                }
            }
            [self.tableView reloadData];
        }
    }];
     
    */
}

- (void)createMemoryView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, 75)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    //placeholder_method_call//

    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 10, (SCREEN_WIDTH-36)/2, 35)];
    [allBtn setTitle:@"全部缓存" forState:UIControlStateNormal];
    allBtn.backgroundColor = RGB(246, 246, 246);
    allBtn.layer.masksToBounds = YES;
    allBtn.layer.cornerRadius = 3;
    [allBtn setTitleColor:RGB(48, 49, 51) forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [footView addSubview:allBtn];
    [allBtn addTarget:self action:@selector(AllDownLoadClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBtn.frame = CGRectMake(allBtn.right+12, 10, (SCREEN_WIDTH-36)/2, 35);
    [lookBtn setTitle:@" 查看缓存列表" forState:UIControlStateNormal];
    lookBtn.backgroundColor = RGB(246, 246, 246);
    lookBtn.layer.masksToBounds = YES;
    lookBtn.layer.cornerRadius = 3;
    [lookBtn setTitleColor:RGB(48, 49, 51) forState:UIControlStateNormal];
    [lookBtn setImage:[UIImage imageNamed:@"down_look"] forState:UIControlStateNormal];
    lookBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [footView addSubview:lookBtn];
    [lookBtn addTarget:self action:@selector(LookDownLoadClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *memoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 20)];
    memoryView.backgroundColor = RGB(238, 238, 238);
    [footView addSubview:memoryView];
    
    UIView *usedView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 0, 20)];
    usedView.backgroundColor = RGB(204, 204, 204);
    [footView addSubview:usedView];
    
    UILabel *lblMemory = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 20)];
    lblMemory.font = [UIFont systemFontOfSize:12.0];
    lblMemory.textAlignment = NSTextAlignmentCenter;
    lblMemory.textColor = RGB(144, 147, 153);
    [footView addSubview:lblMemory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    CGFloat memory = [attributes[NSFileSystemSize] doubleValue] / (powf(1024, 3));
    CGFloat Usedmemory = [attributes[NSFileSystemFreeSize] doubleValue] / powf(1024, 3);
    
    CGFloat Allmemory = 0;
    if (memory > 0 && memory < 20) { //16g
        
        Allmemory = 16;
    }else if (memory > 20 && memory < 40){ //32g
        
        Allmemory = 32;
    }else if (memory > 40 && memory < 80){ //64
        
        Allmemory = 64;
    }else if (memory > 80 && memory < 140){ //128
        
        Allmemory = 128;
    }else if (memory > 140 && memory < 280){ //256
        
        Allmemory = 256;
    }else if (memory > 280 && memory < 540){ //512
        
        Allmemory = 512;
    }
    
    Usedmemory = Allmemory - memory + Usedmemory;
    
    usedView.width = SCREEN_WIDTH*((Allmemory-Usedmemory)/Allmemory);
    lblMemory.text = [NSString stringWithFormat:@"总空间%.1fG/剩余%.1fG",Allmemory,Usedmemory];
}

#pragma mark - 私有方法

#pragma mark - get set

- (void)setModel:(CourseDetailModel *)model{
    //placeholder_method_call//

    _model = model;
}
//placeholder_method_impl//

@end

//
//  SelectCacheAudioVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/14.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SelectCacheAudioVC.h"
#import "SelectCacheCell.h"
#include <sys/param.h>
#include <sys/mount.h>
#import "UIAlertController+Blocks.h"
#import "DownLoadVC.h"
#import "YCDownloadManager.h"
#import "SetVC.h"

@interface SelectCacheAudioVC ()<YCDownloadItemDelegate>

@property (nonatomic, strong) NSArray<CoursePlayerFootModel *> *dataSource;

@property (nonatomic, strong) NSArray<CoursePlayerFootModel *> *downAry;

@property (nonatomic, strong) CourseDetailModel *model;

@end

@implementation SelectCacheAudioVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewWillAppear:(BOOL)animated{
    //placeholder_method_call//

    [self.tableView reloadData];
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择缓存的音频";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    //placeholder_method_call//

    self.dataSource = [NSArray array];
    self.downAry = @[];
   
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight-75)];
    self.additionalHeight = 0; //设置额外高度
    [self addDefaultFootView];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectCacheCell" bundle:nil] forCellReuseIdentifier:@"SelectCacheCell"];
    
    [self.tableView reloadData];
    
    [self createMemoryView];
    //placeholder_method_call//

    [self loadData];
}
//placeholder_method_impl//

#pragma mark - 代理

#pragma mark 系统代理
//placeholder_method_impl//

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //placeholder_method_call//

    return self.dataSource.count;
}
//placeholder_method_impl//

#pragma mark - 设置分组的高度
// 必须设置分区头高度，否则不显示。
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //placeholder_method_call//

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

    CoursePlayerFootModel *model = self.dataSource[indexPath.row];
    cell.playerModel = model;

    YCDownloadItem *item = [YCDownloadManager itemWithFileId:model.did];
    if (item) {
        [cell setDownloadStatus:item.downloadStatus];
    }
    
    cell.lblNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    return cell;
}
//placeholder_method_impl//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    CoursePlayerFootModel *model = self.dataSource[indexPath.row];

    CourseDetailModel *detailM = [CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",self.model.cid]];
    //placeholder_method_call//

    YCDownloadItem *item = [YCDownloadManager itemWithFileId:model.did];
    if (!item) {
        item = [YCDownloadItem itemWithUrl:model.transcoding_path fileId:model.did downloadCid:model.cid];
        item.extraData = [CoursePlayerFootModel dateWithInfoModel:model];
        item.enableSpeed = true;
        item.delegate = self;
        [YCDownloadManager startDownloadWithItem:item];
        
        if (!detailM) {
            
            [self.model save];
        }
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
    }else{
        
        [KeyWindow showTip:@"已存在缓存列表"];
    }
    
    [self.tableView reloadData];
}

#pragma mark 自定义代理
//placeholder_method_impl//

- (void)downloadItemStatusChanged:(YCDownloadItem *)item {
    
    [self.tableView reloadData];
    //placeholder_method_call//

}

- (void)downloadItem:(YCDownloadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize {
    
}
//placeholder_method_impl//

- (void)downloadItem:(YCDownloadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc {
    
}
//placeholder_method_impl//

#pragma mark - 事件

- (void)AllDownLoadClick{
    //placeholder_method_call//

    [UIAlertController showAlertInViewController:self withTitle:[NSString stringWithFormat:@"确定要缓存%ld个音频吗？",self.model.chapter_audio.count] message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"全部缓存" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            CourseDetailModel *detailM = [CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",self.model.cid]];
            if (!detailM) {
                
                [self.model save];
            }
            
            for (CoursePlayerFootModel *downModel in self.dataSource) {
                
                YCDownloadItem *item = [YCDownloadManager itemWithFileId:downModel.did];
                if (!item) {
                    
                    item = [YCDownloadItem itemWithUrl:downModel.transcoding_path fileId:downModel.did downloadCid:downModel.cid];
                    item.extraData = [CoursePlayerFootModel dateWithInfoModel:downModel];
                    item.enableSpeed = true;
                    item.delegate = self;
                    [YCDownloadManager startDownloadWithItem:item];
                }
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
            self.dataSource = self.model.chapter_audio;
            
            //创建下载唯一id
            for (CoursePlayerFootModel *model in self.model.chapter_audio) {
                
                model.did = [NSString stringWithFormat:@"%@%@",model.cid,model.id];
            }  
            [self.tableView reloadData];
        }
    }];
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
//placeholder_method_impl//

- (void)setModel:(CourseDetailModel *)model{
    //placeholder_method_call//

    _model = model;
}

@end

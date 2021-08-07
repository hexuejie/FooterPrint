//
//  VideoListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "VideoListVC.h"
#import "CourseDirectoryCell.h"
#import "CourseDirectoryGroupView.h"
#import "UIImage+GIF.h"

@interface VideoListVC ()

/** 展开合并状态*/
@property (nonatomic, strong) NSMutableArray *stateAry;

@property (nonatomic, strong) NSArray<CourseChapterModel *> *dataSource;

@property (nonatomic, strong) CourseDirectoryGroupView *groupView;

@property (nonatomic, strong) UIImage *gifImg;

@property (nonatomic, assign) NSInteger playerRow;

@property (nonatomic, assign) NSInteger playerSection;

@property (nonatomic, strong) AppDelegate *app;

@end

@implementation VideoListVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ic_audio" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.gifImg = [UIImage sd_animatedGIFWithData:data];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 45)];
    view.backgroundColor = kColor_BG;
    [self.view addSubview:view];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"视频目录";
    //placeholder_method_call//

    lbl.font = [UIFont systemFontOfSize:13.0];
    lbl.textColor = RGB(144, 147, 153);
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(16);
        make.centerY.mas_equalTo(view);
    }];
    
    [self setTableViewFram:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-50-50-KNavAndStatusHight-KSafeAreaHeight-45)];
    self.additionalHeight = 50; //设置额外高度
    [self addDefaultFootView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDirectoryCell" bundle:nil] forCellReuseIdentifier:@"CourseDirectoryCell"];
    
   
    
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    WS(weakself);
    
    [self judgePlayerStatus:self.app.playerView.player.status];
    self.app.playerView.BlockVideoVCPlayerStatus = ^(PLPlayerStatus status) {
        
        [weakself judgePlayerStatus:status];
    };
    


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setDataTrans {
    self.dataSource = self.model.chapter_video;
    self.stateAry = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataSource.count; i ++) {

        [self.stateAry addObject:@"1"];
    }
    [self.tableView reloadData];
}

- (void)setModel:(CourseDetailModel *)model {
    _model = model;
    //placeholder_method_call//

    
}
- (void)setPlayerModel:(CoursePlayerFootModel *)playerModel {
    _playerModel = playerModel;
    [self setDataTrans];
    
}

//placeholder_method_impl//

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

#pragma mark - 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //placeholder_method_call//

    return self.dataSource.count;
}

#pragma mark- 展开分区核心代码(1)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //placeholder_method_call//

    if ([self.stateAry[section] isEqualToString:@"1"]) {
        
        return self.dataSource[section].video_list.count;
    } else {
        return 0;
    }
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

    return 60;
}
//placeholder_method_impl//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDirectoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseDirectoryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //placeholder_method_call//

    CoursePlayerFootModel *model = self.dataSource[indexPath.section].video_list[indexPath.row];
    if (model.id == self.playerModel.id) {
        
        cell.lblTitle.textColor = [UIColor colorWithHex:0x479298];
        cell.imgMp3.hidden = NO;
       UIImage *img = [UIImage imageNamed:@"course_video_show"];
//        img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
        cell.imgMp3.image = img;
        cell.lblNumber.hidden = YES;
//        cell.backgroundColor = RGB(229, 242, 254);
//        cell.layer.borderColor = [UIColor colorWithHex:0x000000].CGColor;
//        cell.layer.borderWidth = 1.0;
        cell.lblTitle.font = [UIFont systemFontOfSize:15.0];
    }else{
        cell.layer.borderWidth = 0.0;

        cell.lblTitle.textColor = [UIColor blackColor];
        // 学完就变暗
        if ([model.study_status isEqualToString:@"2"]) {
            cell.lblTitle.textColor = [UIColor colorWithHex:0x888888];

        }
        
        cell.imgMp3.hidden = YES;
        cell.imgMp3.image = nil;
        cell.lblNumber.hidden = NO;
        cell.backgroundColor = kColor_BG;
        cell.lblTitle.font = [UIFont systemFontOfSize:15.0];
    }
    
    
    
    cell.goodsType = 1;
    cell.playerModel = model;
    cell.lblNumber.text = [NSString stringWithFormat:@"%ld.%ld",indexPath.section+1,indexPath.row+1];
    
    return cell;
}
//placeholder_method_impl//
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.groupView = [[[NSBundle mainBundle] loadNibNamed:@"CourseDirectoryGroupView" owner:nil options:nil] lastObject];
    self.groupView.lblTitile.text = self.dataSource[section].cate_name;
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
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![CoreStatus isNetworkEnable]) {
        [KeyWindow showTip:@"网络貌似有问题..."];
        return;
    }

    CoursePlayerFootModel *playerModel = self.dataSource[indexPath.section].video_list[indexPath.row];
    //placeholder_method_call//

    if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
        
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 0) { //未购买
            
            if ([self.model.price floatValue] <= 0) { //免费 需要报名
                
                if ([playerModel.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要报名，请先报名"];
                    return ;
                }
            }else{
                
                if ([playerModel.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要付费，请先购买"];
                    return ;
                }
            }
        }
    }
    
    if ([self.app.playerView.playerModel.id isEqualToString:playerModel.id]) {
        
        if (self.app.playerView.player.status == PLPlayerStatusPlaying) {//如果是点击相同的 又是在播放这个视频 不做处理
            
            return;
        }
    }
    
    self.playerRow = indexPath.row;
    self.playerSection = indexPath.section;
    
    self.playerModel = playerModel;
    
    if ([playerModel.live_state integerValue] == 0) { //课程才刷新，直播直接点进去就行了
        
        [self.tableView reloadData];
    }
    if (self.BlockVideoClick) {
        self.BlockVideoClick(self.playerSection, self.playerRow);
    }
}

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark -action
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
//placeholder_method_impl//

#pragma mark - 公开方法
//placeholder_method_impl//

- (void)judgePlayerStatus:(PLPlayerStatus)status{
    //placeholder_method_call//

    NSIndexPath *index = [NSIndexPath indexPathForRow:self.playerRow inSection:self.playerSection];
    CourseDirectoryCell *cell = [self.tableView cellForRowAtIndexPath:index];
    
    if (status == PLPlayerStatusPlaying) { //正在播放
        
        cell.imgMp3.image = self.gifImg;
    }else{
        
        cell.imgMp3.image = [UIImage imageNamed:@"ic_mp3"];
    }
}

#pragma mark - 私有方法

#pragma mark - get set



- (void)setPlayerSection:(NSInteger)section PlayerRow:(NSInteger)row{
    //placeholder_method_call//

    _playerSection = section;
    _playerRow = row;
    self.dataSource = self.model.chapter_video;
    [self.tableView reloadData];
}

@end

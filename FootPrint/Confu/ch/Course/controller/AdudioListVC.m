//
//  AdudioListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "AdudioListVC.h"
#import "CourseDirectoryCell.h"
#import "SilenceAutoHeightTableViewUtil.h"
#import "UIImage+GIF.h"

@interface AdudioListVC ()

//@property (nonatomic, strong) NSMutableArray<CoursePlayerFootModel *> *dataSource;


@property (nonatomic, strong) SilenceAutoHeightTableViewUtil *tableUtil;

@property (nonatomic, strong) UIImage *gifImg;

@property (nonatomic, strong) AppDelegate *app;

@end

@implementation AdudioListVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.dataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ic_audio" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.gifImg = [UIImage sd_animatedGIFWithData:data];
    //placeholder_method_call//

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 45)];
    view.backgroundColor = kColor_BG;
    [self.view addSubview:view];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"音频目录";
    lbl.font = [UIFont systemFontOfSize:15.0];
    lbl.textColor = [UIColor darkGrayColor];
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(16);
        make.centerY.mas_equalTo(view);
    }];
    WS(weakself)
    [self setTableViewFram:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-50-50-KNavAndStatusHight-KSafeAreaHeight-45)];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDirectoryCell" bundle:nil] forCellReuseIdentifier:@"CourseDirectoryCell"];
    /*
    self.tableUtil = [[SilenceAutoHeightTableViewUtil alloc] initWithTableView:self.tableView dataSource:self.dataSource identifier:@"CourseDirectoryCell" estimatedHeight:100 cellConfig:^(CourseDirectoryCell *cell, NSIndexPath *indexPath, id data) {
        
        CoursePlayerFootModel *model = self.dataSource[indexPath.row];
        
        if (model.id == self.playerModel.id) {

            cell.lblTitle.textColor = RGB(4, 134, 254);
            cell.imgMp3.hidden = NO;
            cell.imgMp3.image = [UIImage imageNamed:@"ic_mp3"];
            cell.lblNumber.hidden = YES;
        }else{
            
            cell.lblTitle.textColor = [UIColor blackColor];
            cell.imgMp3.hidden = YES;
            cell.imgMp3.image = nil;
            cell.lblNumber.hidden = NO;
        }
        cell.goodsType = 2;
        cell.playerModel = model;
        cell.lblNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.backgroundColor = [UIColor whiteColor];
        
    } didSelectedRow:^(NSIndexPath *indexPath, id data) {
        
        CoursePlayerFootModel *model = self.dataSource[indexPath.row];
        
        if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
            
            //    是否购买,如果是VIP默认购买状态
            if ([self.model.checkbuy integerValue] == 0) { //未购买
                
                if ([self.model.price floatValue] <= 0) { //免费 需要报名
                    
                    if ([model.free integerValue] == 0) { //不是试看
                        
                        [KeyWindow showTip:@"该课程需要报名，请先报名"];
                        return ;
                    }
                }else{
                    
                    if ([model.free integerValue] == 0) { //不是试看
                        
                        [KeyWindow showTip:@"该课程需要付费，请先购买"];
                        return ;
                    }
                }
            }
        }
        
        self.playerModel = model;
        [self.tableView reloadData];
    
        
        if ([self.app.playerView.playerModel.id isEqualToString:model.id]) { //如果是点击相同的 不做处理
            
//            if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//                
//                return;
//            }
        }
        
        
       
        
        if (self.BlockAudioClick) {
            self.BlockAudioClick(indexPath.row);
        }
    }];
     
   */
//    self.app.playerView.BlockAudeoVCPlayRow = ^(NSInteger playRow) {
//        weakself.playerRow = playRow;
//
//       weakself.playerModel = weakself.model.chapter_audio[playRow];
//        [weakself.tableView reloadData];
//
//    };

    
    self.tableUtil.scrollViewDidScrollBlock = ^(UIScrollView *scrollView) {
        
        [weakself setFootViewoffset:scrollView];
    };
//    self.additionalHeight = 50; //设置额外高度
//    [self addDefaultFootView];
    //placeholder_method_call//

//    [self.dataSource removeAllObjects];
//    [self.dataSource addObjectsFromArray:[CoursePlayerFootModel mj_objectArrayWithKeyValuesArray:self.model.chapter_audio]];
//    [self.tableView reloadData];
    
    
    self.app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self judgePlayerStatus:self.app.playerView.player.status];
    self.app.playerView.BlockAdudioVCPlayerStatus = ^(PLPlayerStatus status) {
        
        [weakself judgePlayerStatus:status];
    };
    
    self.app.audioDetailVC.BlockSwitchAdudioClick = ^(CoursePlayerFootModel * _Nonnull playerModel, NSInteger playerRow) {
        weakself.playerRow = playerRow;
        weakself.playerModel = playerModel;
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

#pragma mark - 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //placeholder_method_call//

    return 1;
}

#pragma mark- 展开分区核心代码(1)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //placeholder_method_call//

    return self.model.chapter_audio.count;
}
//placeholder_method_impl//

#pragma mark - 设置分组的高度
// 必须设置分区头高度，否则不显示。
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //placeholder_method_call//

    return 0;
}
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    return 60;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDirectoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseDirectoryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //placeholder_method_call//
    CoursePlayerFootModel *model = self.model.chapter_audio[indexPath.row];

    if (model.id == self.playerModel.id) {

        cell.lblTitle.textColor = [UIColor colorWithHex:0x479298];
        cell.imgMp3.hidden = NO;
        UIImage *img = [UIImage imageNamed:@"ic_mp3"];
       img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
        cell.imgMp3.image = img;
             
        cell.lblNumber.hidden = YES;
    }else{
        
        cell.lblTitle.textColor = [UIColor blackColor];
        cell.imgMp3.hidden = YES;
        cell.imgMp3.image = nil;
        cell.lblNumber.hidden = NO;
    }
    cell.goodsType = 2;
    cell.playerModel = model;
    cell.lblNumber.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.backgroundColor = [UIColor whiteColor];
    

//    CoursePlayerFootModel *model = self.dataSource[indexPath.row];
//    if (model.id == self.playerModel.id) {
//
//        cell.lblTitle.textColor = RGB(4, 134, 254);
//        cell.imgMp3.hidden = NO;
//        cell.lblNumber.hidden = YES;
//        cell.backgroundColor = RGB(229, 242, 254);
//        cell.layer.borderColor = [UIColor colorWithHex:0x000000].CGColor;
//        cell.layer.borderWidth = 1.0;
//        cell.lblTitle.font = [UIFont systemFontOfSize:15.0];
//    }else{
//        cell.layer.borderWidth = 0.0;
//
//        cell.lblTitle.textColor = [UIColor blackColor];
//        // 学完就变暗
//        if ([model.study_status isEqualToString:@"2"]) {
//            cell.lblTitle.textColor = [UIColor colorWithHex:0x888888];
//
//        }
//
//        cell.imgMp3.hidden = YES;
//        cell.imgMp3.image = nil;
//        cell.lblNumber.hidden = NO;
//        cell.backgroundColor = kColor_BG;
//        cell.lblTitle.font = [UIFont systemFontOfSize:15.0];
//    }
//
//
//
//    cell.goodsType = 1;
//    cell.playerModel = model;
//    cell.lblNumber.text = [NSString stringWithFormat:@"%ld.%ld",indexPath.section+1,indexPath.row+1];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CoursePlayerFootModel *model = self.model.chapter_audio[indexPath.row];
    
    if ([self.model.is_vip integerValue] == 0 || [self.model.is_vip integerValue] == -1) { //不是vip
        
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.checkbuy integerValue] == 0) { //未购买
            
            if ([self.model.price floatValue] <= 0) { //免费 需要报名
                
                if ([model.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要报名，请先报名"];
                    return ;
                }
            }else{
                
                if ([model.free integerValue] == 0) { //不是试看
                    
                    [KeyWindow showTip:@"该课程需要付费，请先购买"];
                    return ;
                }
            }
        }
    }
    
    self.playerModel = model;
    [self.tableView reloadData];

    
    if ([self.app.playerView.playerModel.id isEqualToString:model.id]) { //如果是点击相同的 不做处理
        
//            if (self.app.playerView.player.status == PLPlayerStatusPlaying) {
//
//                return;
//            }
    }
    
    
   
    
    if (self.BlockAudioClick) {
        self.BlockAudioClick(indexPath.row);
    }
}
#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)judgePlayerStatus:(PLPlayerStatus)status{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.playerRow inSection:0];
    CourseDirectoryCell *cell = [self.tableView cellForRowAtIndexPath:index];
    //placeholder_method_call//

    if (status == PLPlayerStatusPlaying) { //正在播放
        
        cell.imgMp3.image = self.gifImg;
    }else{
        
        cell.imgMp3.image = [UIImage imageNamed:@"ic_mp3"];
    }
}

#pragma mark - 私有方法

#pragma mark - get set

- (void)setModel:(CourseDetailModel *)model{
    
    _model = model;
    
}
- (void)setPlayerRow:(NSInteger)playerRow{
    
    _playerRow = playerRow;
}
- (void)setPlayerModel:(CoursePlayerFootModel *)playerModel{
    //placeholder_method_call//
    _playerModel = playerModel;
    
    [self.tableView reloadData];
}
//placeholder_method_impl//
//placeholder_method_impl//


//placeholder_method_impl//

@end

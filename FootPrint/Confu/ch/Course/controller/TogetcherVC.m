//
//  TogetcherVC.m
//  FootPrint
//
//  Created by 胡翔 on 2021/5/8.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "TogetcherVC.h"
#import "TogetcherModel.h"
#import "GroupJoinCell.h"
#import "UILabel+Attribute.h"
@interface TogetcherVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)TogetcherModel *model;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TogetcherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"拼团详情";
    self.statusBgView.hidden = YES;
    UIImage *img = [UIImage imageNamed:@"course_small_icon"];
     img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
    self.smallImgView.image = img;
    self.spellPriceLabel.textColor = [UIColor colorWithHex:0x479298];
    if (self.myCourseTypes == 1) {
        UIImage *img = [UIImage imageNamed:@"course_small_video"];
//         img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
        self.smallImgView.image = img;
      
    } else  {
        UIImage *img = [UIImage imageNamed:@"course_small_audio"];
//         img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
        self.smallImgView.image = img;
      
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.statusImgView.hidden = YES;
    self.lastTimeLabel.hidden = YES;
    self.numberLabel.hidden = YES;
    self.returnLabel.hidden = YES;
    self.groupShowLabel.hidden = YES;
    [self.bottomBtn setTitle:@"" forState:UIControlStateNormal];
    [self loadData];
}
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


- (void)loadData {
    NSMutableDictionary *param = @{
        @"t_id":self.t_id
    }.mutableCopy;
    WS(weakself)
    [APPRequest GET:@"/spellGroupItem" parameters:param finished:^(AjaxResult *result) {

        if (result.code == AjaxResultStateSuccess) {
            weakself.model = [TogetcherModel mj_objectWithKeyValues:result.data];
            [weakself updateUI];
         /*
          {
              end = 0;
              missing = 0;
              now = 1620631954;
              see = 0;
              shop = "<null>";
              "succcess_time" = "";
              "u_isitem" = 0;
              "u_isitem_msg" = noalljoin;
              user =     (
              );

          */
           
           
        }
    }];
    
}
- (void)refreshLessTime {
    // SaleSuperCell
    
    
//    self.courseModel.end_time;
//    self.courseModel.end_time
   long currentTime = (long) [[NSDate date]timeIntervalSince1970];
    long end_time = self.model.end;
   
 long  diff =  end_time - currentTime;
    if (diff > 0) {
       NSString *st = [self lessSecondToDay:diff];
        self.lastTimeLabel.text = st;
        self.lastTimeLabel.textColor = [UIColor colorWithHex:0x479298];
        [self.lastTimeLabel addAttrbuteColorWithAttributeText:@[@"活动结束还剩",@"时",@"分",@"秒"] withAttrArrayColor:@[[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2],[UIColor colorWithHex:0xb2b2b2]]];
        self.lastTimeLabel.text = st;
     } else {
         self.lastTimeLabel.text = @"活动结束";

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
- (void)updateUI {
    self.statusBgView.hidden = NO;

    [self.bgImgView sd_setImageWithURL:APP_IMG(self.model.shop.banner)];
    self.titleLabel.text = self.model.shop.title;
    self.groupCountLabel.text = [NSString stringWithFormat:@"%ld人团",self.model.shop.spell_num];
    self.spellPriceLabel.text = [self.model.shop.spell_price ChangePrice];
    
    
     NSString *price = [self.model.shop.price ChangePrice];
     NSMutableAttributedString*newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",price]];
     [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
     self.originPriceLabel.attributedText= newPrice;
     
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupJoinCell" bundle:nil] forCellReuseIdentifier:@"GroupJoinCell"];
    self.csTableView.constant = self.model.user.count * 58.0;
    //   //0:进行中；1:已拼团成功；2:拼团失败',
    if (self.model.shop.status == 2) {
        self.csStatusBgView.constant = 115;

        self.statusImgView.hidden = NO;
        self.statusImgView.image = [UIImage imageNamed:@"course_error_icon"];
        self.groupShowLabel.text = @"成团人数不足，拼团失败";
        self.groupShowLabel.hidden = NO;
        self.returnLabel.hidden = NO;
        [self.bottomBtn setTitle:@"继续逛逛" forState:UIControlStateNormal];

    } else {
        self.csStatusBgView.constant = 94;
      
        
    //  UserModel *userModel =  [APPUserDefault getCurrentUserFromLocal];
        if (self.model.shop.status == 1) { // 拼团成功
            [self.bottomBtn setTitle:@"开始学习" forState:UIControlStateNormal];
            self.statusImgView.hidden = NO;
            self.statusImgView.image = [UIImage imageNamed:@"course_right_icon"];
            self.groupShowLabel.hidden = NO;
            self.groupShowLabel.text = [NSString stringWithFormat:@"%@ 已拼团成功",self.model.succcess_time];
            
        } else {
            /*
             u_isitem  用户参团情况；0:未参团/曾经参团失败；1：表示用户在该团中；2:表示用户正参与别的团中/用户参与别的团成功
             */
            if (self.model.u_isitem == 0) {
                [self.bottomBtn setTitle:@"我要参团" forState:UIControlStateNormal];
            }else if (self.model.u_isitem == 1) {
                [self.bottomBtn setTitle:@"邀请好友参团" forState:UIControlStateNormal];
            }
            
            
            self.lastTimeLabel.hidden = NO;
            self.numberLabel.hidden = NO;
       
            [self.numberLabel setImage:[UIImage imageNamed:@"course_time_icon"] forState:UIControlStateNormal];
            UIImage *img = [UIImage imageNamed:@"course_time_icon"];
             img = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
            [self.numberLabel setImage:img forState:UIControlStateNormal];
            
            [self.numberLabel setTitle:[NSString stringWithFormat:@"开团成功，离成团还差%ld人",self.model.missing] forState:UIControlStateNormal];
            
            if ([_timer isValid]) {
                [_timer invalidate];
                _timer = nil;
            }
            
            //    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
            self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
            
            // 如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            
            
        }
    }
    
   
    
    
    
    
    
}

#pragma mark - uitableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.user.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupJoinCell"];
    cell.userModel =self.model.user[indexPath.row];
    cell.joinBtn.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}








- (IBAction)clickAction:(UIButton *)sender {
   NSString *title = [sender titleForState:UIControlStateNormal];
    if (title.length > 0) {
        if ([title isEqualToString:@"邀请好友参团"]) {
//            [self ShareGroupshareImgUrl:nil shareUrl:self.model.share_url Success:^(OSMessage *message) {
//
//                        } Fail:^(OSMessage *message, NSError *error) {
//
//                        }];
            [self ShareGroupshareImgUrl:self.model.shop.banner shareUrl:self.model.share_url withTitle:self.model.shop.title Success:^(OSMessage *message) {
                            
                        } Fail:^(OSMessage *message, NSError *error) {
                            
                        }];
            
        }else if ([title isEqualToString:@"我要参团"]) {
            AddOrderVC *next = [[AddOrderVC alloc] init];
            next.goodsId = self.goodsId;
            next.goodsType = self.goodsType;
            next.group = @"join";
            next.group_join_id = self.t_id;
            next.BlockBackClick = ^{
                
//                [weakself loadData];
            };
            [self.navigationController pushViewController:next animated:YES];
        } else if ([title isEqualToString:@"开始学习"]) {
            if (self.BlockBackClick) {
                self.BlockBackClick();
            }
            NSArray *arr = self.navigationController.viewControllers;
          UIViewController *cont =  arr[arr.count - 2];
            if ([cont isKindOfClass:[CourseDetailVC class]]) {
                [self.navigationController popViewControllerAnimated:YES];

            } else {
                CourseDetailVC *next = [[CourseDetailVC alloc] init];
                     next.goodsType = [self.goodsType integerValue];
                     next.courseId = self.type_id;
                     next.is_buy = 1;
                     [self.navigationController pushViewController:next animated:YES];
            }
          
            
            
            
        } else {
            [self.navigationController popViewControllerAnimated:YES];

        }
       
        
    }
    
}
@end

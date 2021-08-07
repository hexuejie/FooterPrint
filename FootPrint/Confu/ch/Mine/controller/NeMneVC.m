//
//  NewMineVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/28.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "NeMneVC.h"
#import "MineHeadView.h"
#import "MineCell.h"
#import "MessageCenterVC.h"
#import "LearnRecordVC.h"
#import "BuyVipVC.h"
#import "SetVC.h"
#import "IntegralVC.h"
#import "CompleteCouseVC.h"
#import "OrderListVC.h"
#import "EnterpriseLisrVC.h"
#import "ShopMessageVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "BuyGoldVC.h"
#import "MineDownLoasCell.h"
#import "LearnRecordModel.h"
#import "DownLoadVC.h"
#import "CourseDetailModel.h"
#import "NeinexCell.h"
#import "CourseDetailVC.h"
#import "DownLoadListVC.h"
#import "CoreStatus.h"
#import "GoldVC.h"
#import "WebsVC.h"
@interface NeMneVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) MineHeadView *headView;

@property (nonatomic, strong) NSMutableArray *titleAry;

@property (nonatomic, strong) NSMutableArray *imgAry;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UserModel *model;

@property (nonatomic, strong) NSArray<LearnRecordModel *> *LearnRecordAry;

@property (nonatomic, strong) NSArray<CourseDetailModel *> *DownLoadAry;

@end

@implementation NeMneVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.LearnRecordAry = [NSArray array];
    
    self.leftButton.hidden = YES;
    self.fd_prefersNavigationBarHidden = YES;
    //placeholder_method_call//
    
    [self loadData];
    
    [self createNavView];
    
    [self createCollectionView];
    
    CGFloat height = [self.headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.view.frame;
    frame.size.height = height;
    self.headView.frame = frame;
    self.csHeadBgViewHeight.constant = height;
    [self.headBGView addSubview:self.headView];
    
}
//placeholder_method_impl//

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent; //白色
    //placeholder_method_call//
    [self initData];
    if (Ktoken) {
        self.headView.loginBtn.hidden = YES;
        if (self.model) {
            self.headView.model = self.model;
        }
        [self loadData];
        
        
    } else {
        self.headView.loginBtn.hidden = NO;

        // 数据都要清掉
        self.headView.lblTitle.text = @"未登录";
        self.headView.lblTime.text = @"点击登录";
        self.LearnRecordAry = [NSArray array];
        [self.collectionView1 reloadData];
        [self.collectionView2 reloadData];
        self.model = nil;
    }
    
    [self judgeHeight];
    
    
    
}
- (void)initData{
    
    
    
    //    [self.titleAry insertObject:@"购买猫币" atIndex:0];
    //                       [self.imgAry insertObject:@"mine_new_gold" atIndex:0];
    if ([isAudit isEqualToString:@"no"]) {
        self.titleAry = @[@"我的订单",@"消息中心",@"设置",@"联系客服",@"我的收益"].mutableCopy;
        self.imgAry = @[@"mine_order",@"mine_message",@"mine_set",@"mine_service",@"mine_income"].mutableCopy;
    } else {
        self.titleAry = @[@"购买学习金",@"我的订单",@"消息中心",@"设置",@"联系客服"].mutableCopy;
        self.imgAry = @[@"mine_gold",@"mine_order",@"mine_message",@"mine_set",@"mine_service"].mutableCopy;
    }
    
    [self.collectionView3 reloadData];
    
}



//placeholder_method_impl//

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //placeholder_method_call//
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault; //黑色
    
}
//placeholder_method_impl//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//placeholder_method_impl//

#pragma mark - 代理
//placeholder_method_impl//

#pragma mark 系统代理
//placeholder_method_impl//

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //placeholder_method_call//
    
    if (collectionView == self.collectionView1) {
        
        if (self.LearnRecordAry.count > 5) {
            return 6;
        }
        return self.LearnRecordAry.count;
    }else if (collectionView == self.collectionView2){
        
        if (self.DownLoadAry.count > 5) {
            return 6;
        }
        return self.DownLoadAry.count;
    }else if (collectionView == self.collectionView3){
        
        return self.titleAry.count;
    }
    return 0;
}
//placeholder_method_impl//

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.collectionView1) {
        
        MineDownLoasCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineDownLoasCell" forIndexPath:indexPath];
        //placeholder_method_call//
        
        cell.learnModel = self.LearnRecordAry[indexPath.row];
        cell.viewBg.hidden = YES;
        if (indexPath.row == 5) {
            
            cell.viewBg.hidden = NO;
            cell.lblNum.text = [NSString stringWithFormat:@"%ld+",self.LearnRecordAry.count];
            cell.lblTitle.text = @"全部学习记录";
        }
        
        return cell;
    }else if (collectionView == self.collectionView2){
        
        MineDownLoasCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineDownLoasCell" forIndexPath:indexPath];
        cell.DownModel = self.DownLoadAry[indexPath.row];
        cell.viewBg.hidden = YES;
        if (indexPath.row == 5) {
            
            cell.viewBg.hidden = NO;
            cell.lblNum.text = [NSString stringWithFormat:@"%ld+",self.DownLoadAry.count];
            cell.lblTitle.text = @"全部下载记录";
        }
        
        return cell;
    }else if (collectionView == self.collectionView3){
        
        NeinexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NeinexCell" forIndexPath:indexPath];
        NSString *title  = self.titleAry[indexPath.row];
        //placeholder_method_call//
        
        cell.lblTitle.text = self.titleAry[indexPath.row];
        // self.imgAry = @[@"order",@"enterprise",@"message",@"set"]
        cell.imgView.image = [UIImage imageNamed: self.imgAry[indexPath.row]];
        
        return cell;
    }
    
    return [[UICollectionViewCell alloc] init];
}
//placeholder_method_impl//

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //placeholder_method_call//
    
    return UIEdgeInsetsMake(0, 12, 0, 12);
}
//placeholder_method_impl//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!Ktoken) {
        [self loginAction];
        return;
    }
    
    
    if (collectionView == self.collectionView1) {
        //placeholder_method_call//
        
        
        if (indexPath.row == 5) {
            
            LearnRecordVC *next = [[LearnRecordVC alloc] init];
            [self.navigationController pushViewController:next animated:YES];
        }else{
            
            CourseDetailVC *next = [[CourseDetailVC alloc] init];
            next.courseId = self.LearnRecordAry[indexPath.row].cid;
            next.goodsType = [self.LearnRecordAry[indexPath.row].goods_type integerValue];
            [self.navigationController pushViewController:next animated:YES];
        }
    }else if (collectionView == self.collectionView2) {
        
        if (indexPath.row == 5) {
            
            DownLoadVC *next = [[DownLoadVC alloc] init];
            [self.navigationController pushViewController:next animated:YES];
        }else{
            
            DownLoadListVC *next = [[DownLoadListVC alloc] init];
            next.cid = self.DownLoadAry[indexPath.row].cid;
            next.goodsType = [self.DownLoadAry[indexPath.row].goods_type integerValue];
            [self.navigationController pushViewController:next animated:YES];
        }
    }else if (collectionView == self.collectionView3) {
        
        if ([isAudit isEqualToString:@"no"]) {// 审核  通      过
            
            
            //placeholder_method_call//
            
//            if (indexPath.row == 0) { // vip
//                BuyVipVC *next = [[BuyVipVC alloc] init];
//                [self.navigationController pushViewController:next animated:YES];
//            }
            
             if (indexPath.row == 0){ //我的订单
                
                OrderListVC *next = [[OrderListVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
            }else if (indexPath.row == 1){ //我的消息
                
                
                ShopMessageVC *next = [[ShopMessageVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
                
            }
//            else if (indexPath.row == 2){ //企业开通
//                
//                EnterpriseLisrVC *next = [[EnterpriseLisrVC alloc] init];
//                [self.navigationController pushViewController:next animated:YES];
//                
//            }
            else if (indexPath.row == 2){ //设置
                
                SetVC *next = [[SetVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
            } else if (indexPath.row == 3) {
                WebsVC *w = [[WebsVC alloc] init];
                 w.index = 3;
                 [self.navigationController pushViewController:w animated:YES];
            } else if (indexPath.row == 4) {
                WebsVC *w = [[WebsVC alloc] init];
                 w.index = 4;
                 [self.navigationController pushViewController:w animated:YES];
            }
            
            
            
        }else{            //   审核  状态
            
            
            if (indexPath.row == 0) { //购买学习金
                
                GoldVC *next = [[GoldVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
            }else if (indexPath.row == 1){ //我的订单
                
                OrderListVC *next = [[OrderListVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
            }else if (indexPath.row == 2){ //
                //MessageCenterVC *next = [[MessageCenterVC alloc] init];
                ShopMessageVC *next = [[ShopMessageVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
                
                
            }else if (indexPath.row == 3){ //
                SetVC *next = [[SetVC alloc] init];
                [self.navigationController pushViewController:next animated:YES];
               
            }else if (indexPath.row == 4){ //
                WebsVC *w = [[WebsVC alloc] init];
                 w.index = 3;
                 [self.navigationController pushViewController:w animated:YES];
              
            }
            
            
            
        }
    }
}
//placeholder_method_impl//

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (collectionView == self.collectionView3) {
        //placeholder_method_call//
        
        return 0;
    }
    return 10;
}
//placeholder_method_impl//

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

#pragma mark 自定义代理

#pragma mark - 事件
//placeholder_method_impl//

- (void)SignClick:(UIButton *)sender{
    if (!Ktoken) {
        [self loginAction];
        return;
    }
    if ([self.model.is_sign integerValue] == 1) { //已签到
        
        [self.view showTip:@"已签到"];
        return;
    }
    //placeholder_method_call//
    
    [APPRequest GET:@"/sign" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            [KeyWindow showTip:result.data[@"msg"]];
            [self loadData];
        }
    }];
}
//placeholder_method_impl//

- (IBAction)btnGoDetailClick:(UIButton *)sender {
    if (!Ktoken) {
        [self loginAction];
        return;
    }
    if (sender.tag == 101) {
        
        LearnRecordVC *next = [[LearnRecordVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }else if (sender.tag == 102){
        
        DownLoadVC *next = [[DownLoadVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }else if (sender.tag == 103){
        
        SetVC *next = [[SetVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark - 公开方法

- (void)createNavView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KNavHight + KStatusHight)];
    NSLog(@"%f",SCREEN_HEIGHT);
    view.backgroundColor = RGB(68, 143, 153);
   
    [self.view addSubview:view];
    //placeholder_method_call//
    
    CGFloat offset = 10;
    if (KISIPHONEX) {
        
        offset = 20;
    }
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人主页";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:17.0];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(view).offset(offset);
        make.centerX.mas_equalTo(view);
    }];
    
    self.rightBtn = [UIButton new];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];

    [self.rightBtn setImage:[UIImage imageNamed:@"mine_sign_n"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@" 签到" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.rightBtn addTarget:self action:@selector(SignClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.rightBtn];

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(view).offset(offset);
        make.trailing.mas_equalTo(view).offset(-16);
    }];
}

- (void)judgeHeight {
    if (self.LearnRecordAry.count <= 0) {
        
        self.csCollectionViewHeight1.constant = 55;
    }else{
        
        self.csCollectionViewHeight1.constant = 150;
    }
    
    if (self.DownLoadAry.count <= 0) {
        
        self.csCollectionViewHeight2.constant = 55;
    }else{
        
        self.csCollectionViewHeight2.constant = 150;
    }
    
    
    
}

- (void)loadData{
    if (!Ktoken) {
        return;
    }
    if ([CoreStatus isNetworkEnable]) {
        
        [APPRequest GET:@"/studyList/recordList" parameters:nil finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
                
                self.LearnRecordAry = [LearnRecordModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
                if (self.LearnRecordAry.count <= 0) {
                    
                    self.csCollectionViewHeight1.constant = 55;
                }else{
                    
                    self.csCollectionViewHeight1.constant = 150;
                }
                [self.collectionView1 reloadData];
            }
        }];
        //placeholder_method_call//
        
        [APPRequest GET:@"/userIndex" parameters:nil finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
                
                //                self.titleAry = @[@"我的订单",@"企业开通",@"消息中心",@"设置"].mutableCopy;
                //                self.imgAry = @[@"mine_new_order",@"mine_new_enterprise",@"mine_new_message",@"mine_new_set"].mutableCopy;
                
                self.model = [UserModel mj_objectWithKeyValues:result.data];
                [APPUserDefault saveUserToLocal:self.model];
                
                self.headView.model = self.model;
                CGFloat height = [self.headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                CGRect frame = self.view.frame;
                frame.size.height = height;
                self.headView.frame = frame;
                self.csHeadBgViewHeight.constant = height;
                [self.headBGView addSubview:self.headView];
                
                //            是否签到 0未签到 1签到
                if ([self.model.is_sign integerValue] == 1) {
                    
                    [self.rightBtn setImage:[UIImage imageNamed:@"mine_sign_p"] forState:UIControlStateNormal];
                    [self.rightBtn setTitle:@" 已签到" forState:UIControlStateNormal];
                    [self.rightBtn setTitleColor:RGB(155, 156, 157) forState:UIControlStateNormal];
                    
                    [self.rightBtn sizeToFit];
                }
                
                
                if (self.titleAry.count <= 4) {
                    
                    self.csCollectionViewHeight3.constant = 130;
                }else{
                    
                    self.csCollectionViewHeight3.constant = 200;
                }
                [self.collectionView3 reloadData];
            }
        }];
    }
    
    //    else{
    //
    //        self.titleAry = @[@"我的订单",@"企业开通",@"消息中心",@"设置"].mutableCopy;
    //        self.imgAry = @[@"mine_new_order",@"mine_new_enterprise",@"mine_new_message",@"mine_new_set"].mutableCopy;
    //        [self.collectionView3 reloadData];
    //    }
    
    self.DownLoadAry = [CourseDetailModel findAll];
    //placeholder_method_call//
    
    if (self.DownLoadAry.count <= 0) {
        
        self.csCollectionViewHeight2.constant = 55;
    }else{
        
        self.csCollectionViewHeight2.constant = 150;
    }
    [self.collectionView2 reloadData];
}

- (void)createCollectionView{
    
    CGFloat width = SCREEN_WIDTH/3.8;
    UICollectionViewFlowLayout *layout1 = [UICollectionViewFlowLayout new];
    layout1.itemSize = CGSizeMake(width, 85);
    
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.collectionView1 setCollectionViewLayout:layout1];
    self.collectionView1.backgroundColor = [UIColor clearColor];
    self.collectionView1.delegate = self;
    self.collectionView1.dataSource = self;
    self.collectionView1.scrollsToTop = NO;
    self.collectionView1.showsVerticalScrollIndicator = NO;
    self.collectionView1.showsHorizontalScrollIndicator = NO;
    [self.collectionView1 registerNib:[UINib nibWithNibName:@"MineDownLoasCell" bundle:nil] forCellWithReuseIdentifier:@"MineDownLoasCell"];
    
    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.itemSize = CGSizeMake(width, 85);
    
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.collectionView2 setCollectionViewLayout:layout2];
    self.collectionView2.backgroundColor = [UIColor clearColor];
    self.collectionView2.delegate = self;
    self.collectionView2.dataSource = self;
    self.collectionView2.scrollsToTop = NO;
    self.collectionView2.showsVerticalScrollIndicator = NO;
    self.collectionView2.showsHorizontalScrollIndicator = NO;
    [self.collectionView2 registerNib:[UINib nibWithNibName:@"MineDownLoasCell" bundle:nil] forCellWithReuseIdentifier:@"MineDownLoasCell"];
    
    UICollectionViewFlowLayout *layout3 = [UICollectionViewFlowLayout new];
    layout3.itemSize = CGSizeMake((SCREEN_WIDTH-36)/4, 70);
    
    layout3.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView3 setCollectionViewLayout:layout3];
    self.collectionView3.backgroundColor = [UIColor clearColor];
    self.collectionView3.delegate = self;
    self.collectionView3.dataSource = self;
    self.collectionView3.scrollsToTop = NO;
    self.collectionView3.showsVerticalScrollIndicator = NO;
    self.collectionView3.showsHorizontalScrollIndicator = NO;
    [self.collectionView3 registerNib:[UINib nibWithNibName:@"NeinexCell" bundle:nil] forCellWithReuseIdentifier:@"NeinexCell"];
}

#pragma mark - 私有方法

#pragma mark - get set

- (MineHeadView *)headView{
    
    WS(weakself);
    if (_headView == nil) {
        
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"MineHeadView" owner:nil options:nil] lastObject];
        _headView.BlockOperationClick = ^(NSInteger type) {
            if (!Ktoken) {
                [weakself loginAction];
                return;
            }
            
            if (type == 1) { //已完成课程
                
                CompleteCouseVC *next = [[CompleteCouseVC alloc] init];
                [weakself.navigationController pushViewController:next animated:YES];
            }else if (type == 2) { //积分
                IntegralVC *next = [[IntegralVC alloc] init];
                [weakself.navigationController pushViewController:next animated:YES];
            }
        };
    }
    return _headView;
}

@end

//
//  LiveDetaileVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LiveDetaileVC.h"
#import "LiveModel.h"
#import "SilenceWebViewUtil.h"
#import "LiveTeacherCell.h"
#import "TalkfunViewController.h"
#import "TalkfunPlaybackViewController.h"
#import "BuyVipVC.h"
#import "AddOrderVC.h"

@interface LiveDetaileVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LiveModel *model;

@property (nonatomic, strong) TeachersModel *mainTeacherModel;

@property (nonatomic, strong) NSMutableArray <TeachersModel *>* teacherAry;

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@end

@implementation LiveDetaileVC {
    WKWebView *_webView;
}

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"直播详情";
    //placeholder_method_call//

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LiveTeacherCell" bundle:nil] forCellReuseIdentifier:@"LiveTeacherCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;

    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.scrollEnabled = YES;
    webView.scrollView.delegate = self;
   //placeholder_method_call//
//placeholder_method_call//

    
    
    
    [self.webBGView addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.leading.mas_equalTo(12);
        make.trailing.mas_equalTo(-12);
    }];
    
    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:webView];
    
    self.teacherAry = [NSMutableArray array];
    
    //顶部导航栏右侧按钮
    UIBarButtonItem *rightBarBtn = [UIFactory barBtnMakeWithImage:[UIImage imageNamed:@"ic_shar"] event:^{
        // - (void)showShareViews:(NSInteger)shareType shareId:(NSString *)shareid shareImgUrl:(NSString *)imgUrl shareTitle:(NSString *)title Success:(shareSuccess)success Fail:(shareFail)fail
      
        [self showShareViews:4 shareId:self.model.id shareImgUrl:self.model.banner shareTitle:self.model.title Success:^(OSMessage *message) {
            
            NSLog(@"");
        } Fail:^(OSMessage *message, NSError *error) {
            
            NSLog(@"");
        }];
    }];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    [self loadData];
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.teacherAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   

    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveTeacherCell"];
    //placeholder_method_call//

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.teacherAry[indexPath.row];
    
    return cell;
}

#pragma mark 自定义代理
//placeholder_method_impl//

#pragma mark - 事件
//placeholder_method_impl//

- (IBAction)btnGoHomeClick:(id)sender {
    
    [self BackHome:0];
}
//placeholder_method_impl//

- (IBAction)btnSharClick:(id)sender {
    //placeholder_method_call//

    [self showShareViews:4 shareId:self.model.id shareImgUrl:self.model.banner shareTitle:self.model.title Success:^(OSMessage *message) {
        
        NSLog(@"");
    } Fail:^(OSMessage *message, NSError *error) {
        
        NSLog(@"");
    }];
}

- (IBAction)btnBuyCourseClick:(id)sender {
    //placeholder_method_call//

    
    if ([self.model.audit integerValue] == 0) { //已下架
        
        [KeyWindow showTip:@"该课程已下架"];
        return ;
    }else{
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.is_buy integerValue] == 1) { //已购买  播放
            if ([self.model.live_status integerValue] == 3) {
                
                return;
            }
            
            [self GoLiveRoom:self.liveId liveState:[self.model.live_state integerValue]];
        }else{ //未购买
            
            if ([self.model.price floatValue] <= 0) {
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setObject:@"ios" forKey:@"source"];
                [param setObject:self.model.id forKey:@"item_id"];
                [param setObject:@"live" forKey:@"order_type"];
                
                [APPRequest GET:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
                    
                    if (result.code == AjaxResultStateSuccess) {
                        
                        [KeyWindow showTip:@"报名成功"];
                        [self loadData];
                    }
                }];
            }else{
               
                AddOrderVC *next = [[AddOrderVC alloc] init];
                next.goodsId = self.model.id;
                next.goodsType = @"live";
                next.BlockBackClick = ^{
                    
                    [self loadData];
                };
                [self.navigationController pushViewController:next animated:YES];
            }
        }
    }
}
//placeholder_method_impl//

- (IBAction)btnBuyVipClick:(id)sender {
    
    BuyVipVC *next = [[BuyVipVC alloc] init];
    //placeholder_method_call//

    [self.navigationController pushViewController:next animated:YES];
}
//placeholder_method_impl//

#pragma mark - 公开方法

- (void)loadData{
    
    [APPRequest GET:@"/livedetail" parameters:@{@"id":self.liveId} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [LiveModel mj_objectWithKeyValues:result.data[@"live"]];
            self.teacherAry = [TeachersModel mj_objectArrayWithKeyValuesArray:result.data[@"lecturer"]];
            self.mainTeacherModel = self.teacherAry[0];
            [self.teacherAry removeObjectAtIndex:0];
            
            [self loadDataView];
        }
    }];
}
//placeholder_method_impl//

- (void)loadDataView{
    
    [self.imgBanner sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    //placeholder_method_call//

    self.lblTitle.text = self.model.title;
    self.lblContent.text = self.model.details;
    self.lblPrice.text = [self.model.price ChangePrice];
    self.lblNum.text =  self.model.join_text;
    self.lblTime.text = [NSString stringWithFormat:@"%@ %@ %@",self.model.s_title,self.model.s_time_title,self.model.e_time_title];
    
    [self.ImgHead sd_setImageWithURL:APP_IMG(self.mainTeacherModel.face) placeholderImage: [UIImage imageNamed:@"head_default"]];
    self.lblName.text = [NSString stringWithFormat:@"主讲老师: %@",self.mainTeacherModel.username];
    self.lblIntroduce.text = self.mainTeacherModel.remarks;
    
    WS(weakself);
    //
    
    NSString *contentUrl = [NSString stringWithFormat:@"<html> \n"
                                "<head> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                                "<style type=\"text/css\"> \n"
                                "body {font-size:14px;}\n"
                                "span{line-height:20px;}\n"
                                "p{line-height:20px;}\n"
                                 "textarea{line-height:20px;}\n"
                                "</style> \n"
                                "</head> \n"
                                "<body>"
                                "<script type='text/javascript'>"
                                "window.onload = function(){\n"
                                "var $img = document.getElementsByTagName('img');\n"
                                "for(var p in  $img){\n"
                                " $img[p].style.width = '100%%';\n"
                                "$img[p].style.height ='auto'\n"
                                "}\n"
                                "}"
                                "</script>%@"
                                "</body>"
                                "</html>", self.model.remarks];

    
    [self.webViewUtil setContent:contentUrl heightBlock:^(CGFloat h) {
        
       
        NSLog(@"xxxxx");
        
        weakself.csWebViewHeight.constant = h + 32.0;
        
    }];
    //placeholder_method_call//

    if (self.teacherAry.count == 0) {
        
        self.csViewTeacherHeight.constant = 0;
        self.viewTeacher.hidden = YES;
        self.csTableViewHeight.constant = 0;
        self.tableView.hidden = YES;
    }else{
        
        self.csViewTeacherHeight.constant = 46;
        self.viewTeacher.hidden = NO;
        self.csTableViewHeight.constant = 60*self.teacherAry.count;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
    
    if ([self.model.vip_switch integerValue] == 1) { //开启了vip购买功能
        
        //    是否是vip 1:是0:不是
        if ([self.model.is_vip integerValue] == 1) {
            
            self.btnBuyVip.hidden = YES;
            self.csBtnBuyVipWidth.constant = 0;
        }else{
            
            self.btnBuyVip.hidden = NO;
            self.csBtnBuyVipWidth.constant = SCREEN_WIDTH*0.3;
        }
        
    }else{
        
        self.btnBuyVip.hidden = YES;
        self.csBtnBuyVipWidth.constant = 0;
    }
    //    :0 下架 1:上架
    if ([self.model.audit integerValue] == 0) {
        
        [self.btnBuyCourse setTitle:@"已下架" forState:UIControlStateNormal];
        self.btnBuyCourse.backgroundColor = RGB(144, 147, 152);
    }else{
        
        self.btnBuyCourse.backgroundColor = RGB(4, 134, 254);
        //    是否购买,如果是VIP默认购买状态
        if ([self.model.is_buy integerValue] == 1) {
            
            //    状态 1-直播中 2-待直播 3-已结束 (不能点进去)  4- (查看回放)
            if ([self.model.live_status integerValue] == 1) {
             
                [self.btnBuyCourse setTitle:@"进入直播" forState:UIControlStateNormal];
            }else if ([self.model.live_status integerValue] == 2){
                
                self.btnBuyCourse.backgroundColor = RGB(144, 147, 152);
                [self.btnBuyCourse setTitle:@"未开播" forState:UIControlStateNormal];
            }else if ([self.model.live_status integerValue] == 3){
                
                [self.btnBuyCourse setTitle:@"已结束" forState:UIControlStateNormal];
            } else if ([self.model.live_status integerValue] == 4) {
                 [self.btnBuyCourse setTitle:@"查看回放" forState:UIControlStateNormal];
            }
        }else{
            //placeholder_method_call//

            self.btnBuyCourse.backgroundColor = RGB(4, 134, 254);
            
            if ([self.model.price floatValue] <= 0) {
                
                [self.btnBuyCourse setTitle:@"立即报名" forState:UIControlStateNormal];
            }else{
                
                [self.btnBuyCourse setTitle:@"立即购买" forState:UIControlStateNormal];
            }
        }
    }
}

//placeholder_method_impl//







@end

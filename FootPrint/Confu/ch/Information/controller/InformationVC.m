//
//  InformationVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "InformationVC.h"
#import "HomeSearchCell.h"
#import "SilencePageView.h"
#import "InformationCell.h"
#import "InformationDetailVC.h"
#import "InformationfootModel.h"
#import "InformationSearchVC.h"

@interface InformationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) HomeSearchCell *searchView;

@property (nonatomic, strong) NSMutableDictionary *param;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) NSMutableArray<InformationScreeninmodel *> *ScreeningAry;

@property (nonatomic, strong) NSArray<InformationfootModel *> *dataSource;

@property (nonatomic, strong) UITableView *screeningTableView;

@end

@implementation InformationVC
//placeholder_method_impl//

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar addSubview:self.searchView];
}
//placeholder_method_impl//


- (void)viewWillDisappear:(BOOL)animated{
    
    [self.searchView removeFromSuperview];
}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    self.ScreeningAry = [NSMutableArray array];
    self.param = [NSMutableDictionary dictionary];
    
    [self createScreeningView];
    //placeholder_method_call//

    [self setTableViewFram:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-45-KSafeAreaHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
    self.additionalHeight = 20;
    [self addDefaultFootView];
    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/articles" parameters:self.param pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeInformation eventBlock:^(EmptyViewEventType eventType) {
                    
                    [self loadData];
                }];
            }else{
                
                [self hideEmptyView];
            }
            
            self.dataSource = [InformationfootModel mj_objectArrayWithKeyValuesArray:datas];
            [self.tableView reloadData];
        }
    }];
    
    [self loadData];
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.screeningTableView) {
        //placeholder_method_call//

        return self.ScreeningAry.count;
    }
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.screeningTableView) {
        //placeholder_method_call//

        return 50;
    }
    return 100;
}
//placeholder_method_impl//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.screeningTableView) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH-16, 50)];
        //placeholder_method_call//

        title.font = [UIFont systemFontOfSize:14.0];
        title.numberOfLines = 0;
        title.text = self.ScreeningAry[indexPath.row].title;
        [cell addSubview:title];
        
        return cell;
    }
    
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}
//placeholder_method_impl//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.screeningTableView) {
        
        InformationScreeninmodel *selectModel = self.ScreeningAry[indexPath.row];
        UILabel *lbl = [self.view viewWithTag:101];
        lbl.text = selectModel.title;
        [self.param setObject:selectModel.id forKey:@"id"];
        //placeholder_method_call//

        [self.pageView setParamdDic:self.param];
        [self.pageView downRefresh];
        
        self.isShow = NO;
        [self.screeningTableView removeFromSuperview];
        [self.bgView removeFromSuperview];
    }else{
        
        InformationDetailVC *next = [[InformationDetailVC alloc] init];
        next.informationId = self.dataSource[indexPath.row].id;
        UINavigationController *Navnext = [[UINavigationController alloc] initWithRootViewController:next];
        Navnext.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:Navnext animated:YES completion:nil];
    }
}
//placeholder_method_impl//

#pragma mark 自定义代理

#pragma mark - 事件
//placeholder_method_impl//

- (void)ScreeningClick:(UIButton *)sender{
    
    NSInteger type = sender.tag-200;
    //placeholder_method_call//

    for (int i=1; i<4; i++) {
        
        UILabel *label = [self.view viewWithTag:100+i];
        UIImageView *imgUp = [self.view viewWithTag:400+i];
        UIImageView *imgDown = [self.view viewWithTag:300+i];
        
        imgUp.image = [UIImage imageNamed:@"ic_up_n"];
        imgDown.image = [UIImage imageNamed:@"ic_bottom_n"];
        label.textColor = RGB(144, 147, 153);
        
        if (i == type) {
            label.textColor = RGB(14, 131, 255);
            
            if (sender.selected) { //升序
                
                imgUp.image = [UIImage imageNamed:@"ic_up_p"];
            }else{ //降序
                
                imgDown.image = [UIImage imageNamed:@"ic_bottom_p"];
            }
        }
    }
    if (type == 1) { // 全部课程
        
        [self showClassView];
    }else if (type == 2 || type == 3){ //价格
        
        self.isShow = NO;
        [self.screeningTableView removeFromSuperview];
        [self.bgView removeFromSuperview];
        
        [self.param removeObjectForKey:@"time_type"];
        [self.param removeObjectForKey:@"heat_type"];
        if (sender.selected) { //升序
            
            if (type == 2) {
                [self.param setObject:@"asc" forKey:@"time_type"];
            }else{
                [self.param setObject:@"asc" forKey:@"heat_type"];
            }
        }else { //降序
            if (type == 2) {
                [self.param setObject:@"desc" forKey:@"time_type"];
            }else{
                [self.param setObject:@"desc" forKey:@"heat_type"];
            }
        }
        [self.pageView setParamdDic:self.param];
        [self.pageView downRefresh];
        sender.selected =! sender.selected;
    }
}

#pragma mark - 公开方法
//placeholder_method_impl//

- (void)loadData{
    //placeholder_method_call//

    //placeholder_method_call//

    //placeholder_method_call//

    [APPRequest GET:@"/artcate" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.ScreeningAry = [InformationScreeninmodel mj_objectArrayWithKeyValuesArray:result.data];
            InformationScreeninmodel *model = [[InformationScreeninmodel alloc] init];
            model.title = @"全部";
            model.id = @"0";
            [self.ScreeningAry insertObject:model atIndex:0];
            [self.screeningTableView reloadData];
            
        }
        if (self.ScreeningAry && self.ScreeningAry.count > 0) {
                   [self performSelector:@selector(hideEmptyView) withObject:nil afterDelay:1];
               }
        
        
    }];
    
    [self.pageView downRefresh];
}
//placeholder_method_impl//

- (void)createScreeningView{
    
    NSArray *titleAry = @[@"全部",@"时间",@"热度"];
    CGFloat w = SCREEN_WIDTH/3;
    for (int i=0; i<titleAry.count; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(w*i, 0, w, 45)];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.font = [UIFont systemFontOfSize:14.0];
        if (i == 0) {
            lblTitle.textColor = RGB(14, 131, 255);
        }else{
            lblTitle.textColor = RGB(144, 147, 153);
        }
        lblTitle.text = titleAry[i];
        lblTitle.tag = 101+i;
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lblTitle];
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(view);
            make.centerX.mas_equalTo(view).offset(-7);
            //            make.leading.mas_equalTo(view).offset(8);
            make.top.mas_equalTo(view);
            make.bottom.mas_equalTo(view);
        }];
        
        if (i != 0) {
            
            UIImageView *imgUp = [[UIImageView alloc] init];
            imgUp.image = [UIImage imageNamed:@"ic_up_n"];
            imgUp.tag = 401+i;
            [view addSubview:imgUp];
            [imgUp mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(lblTitle).offset(-4);
                make.leading.mas_equalTo(lblTitle.mas_trailing).offset(4);
            }];
        }
        UIImageView *imgDown = [[UIImageView alloc] init];
        if (i == 0) {
            imgDown.image = [UIImage imageNamed:@"ic_bottom_p"];
        }else{
            imgDown.image = [UIImage imageNamed:@"ic_bottom_n"];
        }
        imgDown.tag = 301+i;
        [view addSubview:imgDown];
        if (i == 0) {
            [imgDown mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(lblTitle);
                make.leading.mas_equalTo(lblTitle.mas_trailing).offset(4);
                make.trailing.mas_lessThanOrEqualTo(view).offset(4);
                make.width.mas_equalTo(14);
            }];
        }else{
            [imgDown mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(lblTitle).offset(4);
                make.leading.mas_equalTo(lblTitle.mas_trailing).offset(4);
            }];
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [btn addTarget:self action:@selector(ScreeningClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 201+i;
        [view addSubview:btn];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineView];
}
//placeholder_method_impl//

- (void)showClassView{
    
    if (self.isShow) {
        //placeholder_method_call//

        self.isShow = NO;
        
        [self.screeningTableView removeFromSuperview];
        [self.bgView removeFromSuperview];
    }else{
        
        self.isShow = YES;
        
        [self.view addSubview:self.screeningTableView];
        [KeyWindow addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(KeyWindow);
            make.top.mas_equalTo(self.screeningTableView.bottom+KNavAndStatusHight);
            make.bottom.mas_equalTo(KeyWindow);
            make.trailing.mas_equalTo(KeyWindow);
        }];
    }
}
//placeholder_method_impl//

#pragma mark - 私有方法

#pragma mark - get set

- (UITableView *)screeningTableView{
    
    if (_screeningTableView == nil) {
        
        _screeningTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 400)];
        _screeningTableView.delegate = self;
        _screeningTableView.dataSource = self;
        _screeningTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _screeningTableView;
}
//placeholder_method_impl//

- (UIView *)bgView{
    
    if (_bgView == nil) {
        //placeholder_method_call//

        WS(weakself);
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        [_bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            weakself.isShow = NO;
            [weakself.bgView removeFromSuperview];
            [weakself.screeningTableView removeFromSuperview];
        }];
    }
    
    return _bgView;
}

- (HomeSearchCell *)searchView{
    
    if (_searchView == nil) {
        
        WS(weakself);
        _searchView = [[[NSBundle mainBundle] loadNibNamed:@"HomeSearchCell" owner:nil options:nil] lastObject];
        //placeholder_method_call//

        _searchView.frame = CGRectMake(0, -3, SCREEN_WIDTH, 60);
        _searchView.viewbg.backgroundColor = [UIColor clearColor];
        _searchView.BlockSearchClick = ^{
            
            InformationSearchVC *next = [[InformationSearchVC alloc] init];
            BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
            [weakself presentViewController:nav animated:YES completion:nil];
        };
    }
    
    return _searchView;
}

@end

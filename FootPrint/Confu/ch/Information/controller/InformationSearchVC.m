//
//  InformationSearchVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "InformationSearchVC.h"
#import "LCSearchBarView.h"
#import "SilencePageView.h"
#import "InformationfootModel.h"
#import "InformationCell.h"
#import "SearchRecordCell.h"
#import "InformationDetailVC.h"

@interface InformationSearchVC ()<LCSearchBarViewDelegate,UITableViewDelegate,UITableViewDataSource>

/** 搜索框 */
@property (nonatomic, strong)  LCSearchBarView *searchBarView;

@property (nonatomic, strong) NSString *keywords;

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<InformationfootModel *> *dataSource;

@property (nonatomic, strong) UITableView *recordTableView;

@property (nonatomic, strong) NSArray *recordAry;

@property (nonatomic, strong) UIView *footView;

@end

@implementation InformationSearchVC

#pragma mark - yy类注释逻辑
//placeholder_method_impl//
#pragma mark - 生命周期
//placeholder_method_impl//
- (void)viewWillAppear:(BOOL)animated{
    //placeholder_method_call//

    [self.navigationController.navigationBar addSubview:self.searchBarView];
    self.leftButton.hidden = YES;
}
//placeholder_method_impl//
- (void)viewWillDisappear:(BOOL)animated{
    
    [self.searchBarView removeFromSuperview];
    self.leftButton.hidden = NO;
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    self.recordAry = [NSArray array];
    //placeholder_method_call//

    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
    self.additionalHeight = -50;
    [self addDefaultFootView];
    
    [self createTableView];

    //顶部导航栏右侧按钮
    UIBarButtonItem *rightBarBtn = [UIFactory barBtnMakeWithTitle:@"取消" titleColor:RGB(48, 49, 51) fontSize:12 isBold:NO event:^{
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    //placeholder_method_call//

    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/articles" parameters:nil pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeSearch eventBlock:^(EmptyViewEventType eventType) {
                    
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            self.dataSource = [InformationfootModel mj_objectArrayWithKeyValuesArray:datas];
            [self.tableView reloadData];
        }
    }];
    
    [self loadRecordData];
}

#pragma mark - 代理

#pragma mark 系统代理
//placeholder_method_impl//
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.recordTableView) {
        //placeholder_method_call//

        return self.recordAry.count;
    }
    
    return self.dataSource.count;
}
//placeholder_method_impl//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.recordTableView) {
       
        SearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchRecordCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.lblContent.text = self.recordAry[indexPath.row];
        //placeholder_method_call//

//        cell.BlockDeleteClick = ^{
//
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            // 读取我们保存的数组
//            NSMutableArray *ary = [NSMutableArray arrayWithArray:[defaults objectForKey:@"InformationSearchRecord"]];
//            [ary removeObjectAtIndex:indexPath.row];
//            [defaults setObject:ary forKey:@"InformationSearchRecord"];
//            [defaults synchronize];
//
//            [self loadRecordData];
//        };
        
        return cell;
    }
    
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    //placeholder_method_call//

    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.recordTableView) {
        //placeholder_method_call//

        return 50;
    }
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.recordTableView) {
        
        return 50;
    }
    
    return 0;
}
//placeholder_method_impl//
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.recordTableView) {
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        //placeholder_method_call//

        headView.backgroundColor = kColor_BG;
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = @"搜索历史";
        lbl.font = [UIFont systemFontOfSize:15.0];
        lbl.textColor = RGB(48, 49, 51);
        [headView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(headView).offset(16);
            make.centerY.mas_equalTo(headView);
        }];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = RGB(238, 238, 238);
        [headView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(1);
            make.leading.mas_equalTo(headView).offset(16);
            make.bottom.mas_equalTo(headView);
            make.trailing.mas_equalTo(headView);
        }];
        
        return headView;
    }
    
    return nil;
}
//placeholder_method_impl//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.recordTableView) {
        //placeholder_method_call//

        self.keywords = self.recordAry[indexPath.row];
        self.searchBarView.lc_text = self.keywords;
        [self loadData];
    }else{
        
        InformationDetailVC *next = [[InformationDetailVC alloc] init];
        next.informationId = self.dataSource[indexPath.row].id;
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark 自定义代理

#pragma mark - <LCSearchBarViewDelegate>
-(void)lc_searchBarViewSearchButtonClicked:(LCSearchBarView *)searchBarView{
    
    [self loadData];
}
//placeholder_method_impl//
-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView{
    
    self.searchBarView.lc_text = nil;
    //placeholder_method_call//

    self.keywords = @"";
}

/** 输入框内容改变时触发的代理方法 */
-(void)lc_searchBarView:(LCSearchBarView *)searchBarView textDidChange:(NSString *)searchText{
    
    self.keywords = self.searchBarView.lc_text;
}
//placeholder_method_impl//
#pragma mark - 事件

#pragma mark - 公开方法

- (LCSearchBarView *)searchBarView{
    
    if (_searchBarView == nil) {
        
        _searchBarView = [[LCSearchBarView alloc] initWithFrame:(CGRectMake(16, 6, self.view.frame.size.width - 90, 32))];
        _searchBarView.lc_backgroundColor = kColor_BG;
        _searchBarView.lc_placeholder = @"搜索";
        //placeholder_method_call//

        _searchBarView.lc_placeholderColor = RGB(144, 147, 153);
        _searchBarView.lc_font = [UIFont systemFontOfSize:15];
        _searchBarView.lc_textColor = [UIColor blackColor];
        _searchBarView.lc_tintColor = RGB(144, 147, 153);
        _searchBarView.lc_isShowCloseImage = YES;
        _searchBarView.lc_delegate = self;
    }
    
    return _searchBarView;
}
//placeholder_method_impl//
- (void)createTableView{
    
    self.recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-50-KSafeAreaHeight)];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    [self.recordTableView registerNib:[UINib nibWithNibName:@"SearchRecordCell" bundle:nil] forCellReuseIdentifier:@"SearchRecordCell"];
    self.recordTableView.backgroundColor = kColor_BG;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.recordTableView];
    //placeholder_method_call//

    self.footView = [self getDefaultFootView:CGPointMake(0, self.recordTableView.bottom)];
    [self.view addSubview:self.footView];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.tag = 999;
    //placeholder_method_call//

    lbl.hidden = YES;
    lbl.text = @"你还未搜索过，去找到你想要的内容吧～";
    lbl.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.view).offset(16);
        make.top.mas_equalTo(self.view).offset(66);
    }];
}
//placeholder_method_impl//
- (void)loadData{
    
    if (self.keywords.length == 0) {
        
        [self.view showTip:@"请输入搜索内容"];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取我们保存的数组
    NSMutableArray *ary = [NSMutableArray arrayWithArray:[defaults objectForKey:@"InformationSearchRecord"]];
    
    if (ary.count >= 10) { //只保存十条
        
        [ary removeObjectAtIndex:0];
    }
    // 保存数组
    if ([ary containsObject:self.keywords]) {
        
        [ary removeObject:self.keywords];
        [ary addObject:self.keywords];
    }else{
        
        [ary addObject:self.keywords];
    }
    [defaults setObject:ary forKey:@"InformationSearchRecord"];
    [defaults synchronize];
    
    [self.pageView setParamdDic:@{@"key_word":self.keywords}];
    [self.pageView downRefresh];
    
    self.recordTableView.hidden = YES;
    self.footView.hidden = YES;
    UILabel *lbl = [self.view viewWithTag:999];
    lbl.hidden = YES;
}
//placeholder_method_impl//
- (void)loadRecordData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取我们保存的数组
    self.recordAry = [defaults objectForKey:@"InformationSearchRecord"];
    
    [self.recordTableView reloadData];
    //placeholder_method_call//

    if (self.recordAry.count == 0) {
        
        UILabel *lbl = [self.view viewWithTag:999];
        lbl.hidden = NO;
    }
}

#pragma mark - 私有方法
//placeholder_method_impl//
#pragma mark - get set

@end

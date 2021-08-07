//
//  SearchVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SearchVC.h"    
#import "LCSearchBarView.h"
#import "HomeHeadCell.h"
#import "SilencePageView.h"
#import "CourslModel.h"
#import "CourseDetailVC.h"
#import "UIView+Alert.h"
#import "SearchRecordCell.h"
#import "HotModel.h"
#import "CourseListCell.h"
@interface SearchVC()<LCSearchBarViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

/** 搜索框 */
@property (nonatomic, strong)  LCSearchBarView *searchBarView;
//placeholder_property//
@property (nonatomic, strong) NSString *keywords;
//placeholder_property//
@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<CourslModel *> *dataSource;
@property (nonatomic, strong) NSArray<HotModel *> *hotSource;
@property (nonatomic, strong) NSString *hotStr;

//placeholder_property//
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *searchTableView;

//placeholder_property//
@property (nonatomic, strong) NSArray *recordAry;

@property (nonatomic, strong) UIView *footView;
//placeholder_property//

@property (nonatomic, assign) CGFloat historyHeight;
@property (nonatomic, assign) BOOL historyAlreadyChange; // false 是需要计算高度，true是高度已经计算好
@property (nonatomic, assign) CGFloat hotHeight;
@property (nonatomic, assign) BOOL hotAlreadyChange; // false 是需要计算高度，true是高度已经计算好
@end

@implementation SearchVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//
- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar addSubview:self.searchBarView];
    self.leftButton.hidden = YES;
    
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.searchBarView removeFromSuperview];
    //placeholder_method_call//

    self.leftButton.hidden = NO;
}
//placeholder_method_impl//
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *hotName = [[NSUserDefaults standardUserDefaults] objectForKey:kHotName];
            if (hotName) {
   //             self.keywords = hotName;
   //             _searchBarView.lc_text = hotName;
                self.keywords = hotName;
                self.hotStr = hotName;


            }
    // Do any additional setup after loading the view.
    self.dataSource = [NSArray array];
    self.recordAry = [NSArray array];
    //placeholder_method_call//

//    [self initCollectionView];

    //顶部导航栏右侧按钮
    UIBarButtonItem *rightBarBtn = [UIFactory barBtnMakeWithTitle:@"取消" titleColor:RGB(48, 49, 51) fontSize:12 isBold:YES event:^{
        //placeholder_method_call//

        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    WS(weakself)
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/searchCourse" parameters:@{} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [weakself showEmptyView:EmptyViewTypeCourse eventBlock:^(EmptyViewEventType eventType) {
                    
                    [self loadData];
                }];
            }else{
                
                [weakself hideEmptyView];
            }
            weakself.dataSource = [CourslModel mj_objectArrayWithKeyValuesArray:datas];
            [weakself.tableView reloadData];
            
            
        }
        if (self.dataSource && self.dataSource.count > 0) {
                   [self performSelector:@selector(hideEmptyView) withObject:nil afterDelay:1];
               }
      
        
        
    }];
    
    
    [self createTableView];

    /*
    self.pageView = [[SilencePageView alloc] get:self.collectionView url:@"/searchCourse" parameters:@{@"empty":@"YES"} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        //placeholder_method_call//

        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeSearch eventBlock:^(EmptyViewEventType eventType) {
                   
                    
                }];
            }else{
                
                [self hideEmptyView];
            }
            self.dataSource = [CourslModel mj_objectArrayWithKeyValuesArray:datas];
            [self.collectionView reloadData];
        }
    }];
     */
    
    [self loadRecordData];
    [self loadHotData];
     
}
- (void)loadHotData {
    WS(weakself)
        [APPRequest GET:@"/getSearch" parameters:nil finished:^(AjaxResult *result) {
            
            if (result.code == AjaxResultStateSuccess) {
                if (result.data[@"search"]) {
                    weakself.hotSource = [HotModel mj_objectArrayWithKeyValuesArray:result.data[@"search"]];
                    [weakself.searchTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
                   
                }
           
//                CourseClassFootModel *model = [[CourseClassFootModel alloc] init];
//                model.cate_name = @"全部";
//                weakself.ClassAry = [NSMutableArray array];
//                [weakself.ClassAry addObject:model];
//                [weakself.ClassAry addObjectsFromArray:arr];
//                [weakself.chooseTableView reloadData];
    //           [weakself.chooseTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
               
    //           self.screeningClassView.dataSource = self.ClassAry;
            }
        }];
}


#pragma mark - 代理

#pragma mark 系统代理
//placeholder_method_impl//
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //placeholder_method_call//

    return self.dataSource.count;
}
//placeholder_method_impl//

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadCell" forIndexPath:indexPath];
    cell.courseModel = self.dataSource[indexPath.row];
    //placeholder_method_call//

    return cell;
}
//placeholder_method_impl//
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}
//placeholder_method_impl//
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //placeholder_method_call//

    return 0;
}
//placeholder_method_impl//
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(8, 12, 8, 12);
}
//placeholder_method_impl//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
    next.courseId = self.dataSource[indexPath.row].cid;
    next.is_buy = self.dataSource[indexPath.row].is_buy;
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - UITableViewDataSource
//placeholder_method_impl//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchTableView) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //placeholder_method_call//
    if (tableView == self.searchTableView) {
        return 1;
    }

    return self.dataSource.count;
}
//placeholder_method_impl//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchTableView) {
        NSString *identer = [NSString stringWithFormat:@"SearchRecordCell%ld",(long)indexPath.row];
        
            [tableView registerNib:[UINib nibWithNibName:@"SearchRecordCell" bundle:nil] forCellReuseIdentifier:identer];
            SearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identer];
           cell.section = indexPath.section;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(weakself)

        if (indexPath.section == 0) {
            if (self.hotSource.count > 0) {
                cell.hotArr = [NSArray arrayWithArray:self.hotSource];
                cell.BlockCollectViewheight = ^(CGFloat he, NSInteger row) {
                    
                    if (weakself.hotAlreadyChange == false) {
                        weakself.hotHeight = he;
                        weakself.hotAlreadyChange = YES;
                    }
                
                };
                
            }
            cell.BlockhotClick = ^(HotModel * _Nonnull model) {
                weakself.keywords = model.name;
                weakself.searchBarView.lc_text = weakself.keywords;
                [weakself preLoad];

                
            };
          
            
            
        } else if (indexPath.section == 1) {
            cell.historyArr = [NSArray arrayWithArray:self.recordAry];

        //        cell.array = @[@"1",@"2"];

        //    cell.lblContent.text = self.recordAry[indexPath.row];
            //placeholder_method_call//
            cell.BlockCollectViewheight = ^(CGFloat he, NSInteger row) {
                
                if (weakself.historyAlreadyChange == false) {
                    weakself.historyHeight = he;
                    weakself.historyAlreadyChange = YES;
                }
            
            };
            
            cell.BlockTapGestion = ^(NSString * _Nonnull name) {
                NSLog(@"%@",name);
                // 开始搜索
                weakself.keywords = name;
                //placeholder_method_call//

                weakself.searchBarView.lc_text = weakself.keywords;
                [weakself loadData];
                
            };

            cell.BlockDeleteClick = ^(NSString *name){
              
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                // 读取我们保存的数组
                NSMutableArray *ary = [NSMutableArray arrayWithArray:[defaults objectForKey:@"searchRecord"]];
                [ary removeObject:name];
                weakself.historyAlreadyChange = false;
                [defaults setObject:ary forKey:@"searchRecord"];
                [defaults synchronize];
                
                [weakself loadRecordData];
            };
        }
        
         
            
            return cell;
    } else {
        [tableView registerNib:[UINib nibWithNibName:@"CourseListCell" bundle:nil] forCellReuseIdentifier:@"CourseListCell"];
        CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseListCell" forIndexPath:indexPath];
        cell.courseModel = self.dataSource[indexPath.row];
        return cell;
        
        
    }
  
    
    return  [UITableViewCell new];
}
//placeholder_method_impl//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//
    if (tableView == self.searchTableView) {
        if (indexPath.section == 0 ) {
            return self.hotHeight;
        }
        
        
        return self.historyHeight;
    }
    return 145.0;
}
//placeholder_method_impl//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchTableView) {
        if (section == 0) {
            if (self.hotSource.count > 0) {
                return 50;
            }
            return 0;
        }
        if (section == 1) {
            if (self.recordAry.count > 0) {
                return 50;
            }
            return 0;
        }
        
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *lbl = [[UILabel alloc] init];
    //placeholder_method_call//
    if (section == 0) {
        lbl.text = @"热门搜索";
    } else {
        lbl.text = @"搜索历史";

    }
    lbl.font = [UIFont systemFontOfSize:18.0];
    lbl.textColor = [UIColor colorWithHex:0x111111];
    [headView addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.mas_equalTo(headView).offset(16);
        make.centerY.mas_equalTo(headView);
    }];
    
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = RGB(238, 238, 238);
//    [headView addSubview:view];
    //placeholder_method_call//

//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.height.mas_equalTo(1);
//        make.leading.mas_equalTo(headView).offset(16);
//        make.bottom.mas_equalTo(headView);
//        make.trailing.mas_equalTo(headView);
//    }];
    
    return headView;
}
//placeholder_method_impl//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    if (tableView == self.tableView) {
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
        next.courseId = self.dataSource[indexPath.row].cid;
        next.is_buy = self.dataSource[indexPath.row].is_buy;
        [self.navigationController pushViewController:next animated:YES];
    }
    
    //    self.keywords = self.recordAry[indexPath.row];
    //
    //    self.searchBarView.lc_text = self.keywords;
    //    [self loadData];
}

#pragma mark 自定义代理
//placeholder_method_impl//
#pragma mark - <LCSearchBarViewDelegate>
-(void)lc_searchBarViewSearchButtonClicked:(LCSearchBarView *)searchBarView{
    
    [self loadData];
}

-(void)lc_searchBarViewCancelButtonClicked:(LCSearchBarView *)searchBarView{
    
    self.searchBarView.lc_text = nil;
    self.keywords = @"";
}

/** 输入框内容改变时触发的代理方法 */
-(void)lc_searchBarView:(LCSearchBarView *)searchBarView textDidChange:(NSString *)searchText{
    
    self.keywords = self.searchBarView.lc_text;
}

#pragma mark - 事件

#pragma mark - 公开方法

- (LCSearchBarView *)searchBarView{
    
    if (_searchBarView == nil) {
        
        _searchBarView = [[LCSearchBarView alloc] initWithFrame:(CGRectMake(16, 6, self.view.frame.size.width - 90, 32))];
        _searchBarView.lc_backgroundColor = kColor_BG;
        _searchBarView.lc_placeholder = @"搜索";
        
        NSString *hotName = [[NSUserDefaults standardUserDefaults] objectForKey:kHotName];
         if (hotName) {
//             self.keywords = hotName;
//             _searchBarView.lc_text = hotName;
             self.keywords = hotName;
             _searchBarView.lc_placeholder = hotName;


         }
         else {
             self.keywords = @"";
             _searchBarView.lc_text = @"";


         }
        _searchBarView.lc_isFirstResponder = YES;
        _searchBarView.lc_placeholderColor = RGB(144, 147, 153);
        _searchBarView.lc_font = [UIFont systemFontOfSize:16.0f];
        _searchBarView.lc_textColor = [UIColor darkTextColor];
        _searchBarView.lc_tintColor = RGB(144, 147, 153);
        _searchBarView.lc_isShowCloseImage = YES;
        _searchBarView.lc_delegate = self;
    }
    
    return _searchBarView;
}

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height = width*19/17;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    [self setCollectionViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight) Layout:layout];
    //    [self addDefaultFootView];

//    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadCell"];
}

- (void)createTableView{
    
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-50-KSafeAreaHeight)];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    self.searchTableView.backgroundColor = kColor_BG;
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.searchTableView];
    
    self.footView = [self getDefaultFootView:CGPointMake(0, self.searchTableView.bottom)];
    [self.view addSubview:self.footView];
    
//    UILabel *lbl = [[UILabel alloc] init];
//    lbl.tag = 999;
//    lbl.hidden = YES;
//    lbl.text = @"你还未搜索过，去找到你想要的内容吧～";
//    lbl.font = [UIFont systemFontOfSize:14.0];
//    [self.view addSubview:lbl];
//    WS(weakself)
//    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.leading.mas_equalTo(self.view).offset(16);
//        make.bottom.mas_equalTo(weakself.searchBarView.bottom);
//    }];
}

- (void)preLoad {
    self.searchBarView.lc_isFirstResponder = NO;

   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取我们保存的数组
    NSMutableArray *ary = [NSMutableArray arrayWithArray:[defaults objectForKey:@"searchRecord"]];
    
    if (ary.count >= 10) { //只保存十条
        
        [ary removeObjectAtIndex:0];
    }
    // 保存数组
    if ([ary containsObject:self.keywords]) {
        
        [ary removeObject:self.keywords];
        [ary insertObject:self.keywords atIndex:0];
    }else{
        
        [ary insertObject:self.keywords atIndex:0];
    }
    [defaults setObject:ary forKey:@"searchRecord"];
    [defaults synchronize];
    
    
    [self.pageView setParamdDic:@{@"keywords":self.keywords}];
    [self.pageView downRefresh];
    
    self.searchTableView.hidden = YES;
    self.footView.hidden = YES;
}

- (void)loadData{
    
    if (self.keywords.length == 0) {

        
        if (self.hotStr.length > 0) {
            self.keywords = self.hotStr;
        } else {
            [KeyWindow  showTip:@"请输入搜索内容"];
            return;
        }
    }
    if (_searchBarView.lc_text.length == 0) {
        
    }
    
    self.searchBarView.lc_isFirstResponder = NO;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取我们保存的数组
    NSMutableArray *ary = [NSMutableArray arrayWithArray:[defaults objectForKey:@"searchRecord"]];
    
    if (ary.count >= 10) { //只保存十条
        
        [ary removeObjectAtIndex:0];
    }
    // 保存数组
    if ([ary containsObject:self.keywords]) {
        
        [ary removeObject:self.keywords];
        [ary insertObject:self.keywords atIndex:0];
    }else{
        
        [ary insertObject:self.keywords atIndex:0];
    }
    [defaults setObject:ary forKey:@"searchRecord"];
    [defaults synchronize];
    
    [self.pageView setParamdDic:@{@"keywords":self.keywords}];
    [self.pageView downRefresh];
    
    self.searchTableView.hidden = YES;
    self.footView.hidden = YES;
    UILabel *lbl = [self.view viewWithTag:999];
    lbl.hidden = YES;
}

- (void)loadRecordData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取我们保存的数组
    self.recordAry = [defaults objectForKey:@"searchRecord"];
    [self.searchTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1],nil] withRowAnimation:UITableViewRowAnimationNone];
    
    
    if (self.recordAry.count == 0) {
        
        UILabel *lbl = [self.view viewWithTag:999];
        lbl.hidden = NO;
    }
}

#pragma mark - 私有方法

#pragma mark - get set
- (void)setHistoryHeight:(CGFloat)historyHeight {
    _historyHeight = historyHeight;
    
    [self.searchTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1],nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)setHotHeight:(CGFloat)hotHeight {
    _hotHeight = hotHeight;
    [self.searchTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
}
@end

//
//  OrderVC.m
//  Zhongsheng
//
//  Created by YyMacBookPro on 2018/7/23.
//  Copyright © 2018年 Feizhuo. All rights reserved.
//

#import "CourseVC.h"
#import "HomeHeadCell.h"
#import "SilencePageView.h"
#import "CourslModel.h"
#import "CourseDetailVC.h"
#import "CourseClassFootModel.h"
#import "ScreeningClassView.h"
#import "HomeSearchCell.h"
#import "SearchVC.h"
#import "TagSuperCell.h"
#import "CourseListCell.h"
#define FootViewHeight 50

static NSString *const headerCollectionIdentifier = @"headerCollection";

@interface CourseVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) UITableView *chooseTableView;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray<CourslModel *> *dataSource;

@property (nonatomic, strong) NSMutableDictionary *param;

@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *ClassAry;

@property (nonatomic, strong) ScreeningClassView *screeningClassView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) HomeSearchCell *searchView;

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGFloat categoryHeight;
@property (nonatomic, assign) NSInteger categorySelectRow;
@property (nonatomic, assign) NSInteger sortSelectRow;
@property (nonatomic, strong) NSMutableArray<CourseClassFootModel *> *sortAry;

@end

@implementation CourseVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewWillAppear:(BOOL)animated{
    //placeholder_method_call//

    [self.navigationController.navigationBar addSubview:self.searchView];
}
//placeholder_method_impl//

- (void)viewWillDisappear:(BOOL)animated{
    //placeholder_method_call//

    [self.searchView removeFromSuperview];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)setCategoryHeight:(CGFloat)categoryHeight {
    _categoryHeight = categoryHeight;
   CGRect frame = self.chooseTableView.frame;
    frame.size.height = categoryHeight + 62.0;
    self.chooseTableView.frame = frame;
    [self.chooseTableView reloadData];
    if (categoryHeight > 0) {
        if (@available(iOS 11.0, *) && is_iPhoneXSerious) {
            self.tableView.frame = CGRectMake(0, self.chooseTableView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.chooseTableView.height - 49 - 34 - 10 - 24);
        } else {
            self.tableView.frame = CGRectMake(0, self.chooseTableView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.chooseTableView.height - 49 - 10);
        }
     
    }
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"课程";
    self.sortSelectRow = -1;
    self.leftButton.hidden = !self.isList;
    //placeholder_method_call//
    CourseClassFootModel *model = [[CourseClassFootModel alloc] init];
    model.cate_name = @"热度";
    CourseClassFootModel *model1 = [[CourseClassFootModel alloc] init];
    model1.cate_name = @"价格";
    self.sortAry = @[model,model1].mutableCopy;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadViewTop) name:@"reloadViewTop" object:nil];
    
    if (self.isList){
     
        self.searchView.frame = CGRectMake(30, -3, SCREEN_WIDTH-50, 60);
    }
    
    self.dataSource = [NSArray array];
    self.param = [NSMutableDictionary dictionary];
    self.ClassAry = [NSMutableArray array];

//    [self createScreeningView];
//    [self initCollectionView];
    self.chooseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62.0)];
    self.chooseTableView.scrollEnabled = NO;
    self.chooseTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.chooseTableView];
    self.chooseTableView.delegate = self;
    self.chooseTableView.dataSource = self;
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.chooseTableView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.chooseTableView.height - self.chooseTableView.height)];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    WS(weakself)    
    self.pageView = [[SilencePageView alloc] get:self.tableView url:@"/searchCourse" parameters:self.param pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
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
   
     
    
    [self loadData];

    
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)categoryChoose {
   
    [self.param removeObjectForKey:@"category"];
    if (self.categorySelectRow != 0) {
        CourseClassFootModel *model = self.ClassAry[self.categorySelectRow];
        
        [self.param setObject:[NSString stringWithFormat:@"%@,%@",model.id,@"1"] forKey:@"category"];;
    }
    [self.pageView setParamdDic:self.param];
    [self.pageView downRefresh];

}
- (void)priceChoose:(NSInteger)status andRow:(NSInteger)row {
    // row 0 热度 1 价格
    // status 0 是降序 1 升序
    //
    if (status == 1) { // 升序
        if (row == 1) { // 价格
            [self.param setObject:@"price,up" forKey:@"sort"];
        } else {
            [self.param setObject:@"hot,up" forKey:@"sort"];
        }
    } else {
        if (row == 1) { //
            [self.param setObject:@"price,down" forKey:@"sort"];
        } else {
            [self.param setObject:@"hot,down" forKey:@"sort"];
        }
        
        
    }
    
    [self.pageView setParamdDic:self.param];
    [self.pageView downRefresh];
    
    
    
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.chooseTableView) {
        return  2;
    }
    
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chooseTableView) {
        if (indexPath.row == 0) {
            return self.categoryHeight;
        }
        if (indexPath.row == 1) {
            return 62.0;
        }
    }
    return 145.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.chooseTableView) {
        NSString *identer = [NSString stringWithFormat:@"TagSuperCell%ld",(long)indexPath.row];
        [self.chooseTableView registerNib:[UINib nibWithNibName:@"TagSuperCell" bundle:nil] forCellReuseIdentifier:identer];
        
        TagSuperCell *cell = [tableView dequeueReusableCellWithIdentifier:identer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WS(weakself)
        cell.row = indexPath.row;
        if (indexPath.row == 0) {
            
            if (self.categoryHeight > 0.0) {
                cell.mainLabel.text = @"分类";
            } else {
                cell.mainLabel.text = @"";

            }
            cell.labels = self.ClassAry;
            cell.BlockCollectViewheight = ^(CGFloat he, NSInteger row) {
                
                if (weakself.categoryHeight == 0 && he > 0) {
                    weakself.categoryHeight = he + 20;
                     
                }
            
            };
            
            cell.categorySelectRow = self.categorySelectRow;
            
            cell.blockSelectRow = ^(NSInteger row) {
              // 请求网络
                if (row == self.categorySelectRow) {
                    return;
                }
                weakself.categorySelectRow = row;
                [weakself categoryChoose];
            };

        }
        if (indexPath.row == 1) {
            cell.mainLabel.text = @"排序";
            cell.labels = self.sortAry;
            cell.sortSelectRow = self.sortSelectRow;
            cell.blockSortSelectRow = ^(NSInteger status, NSInteger row) {
                weakself.sortSelectRow = row;
                // 网络请求
                // row 0 热度 1 价格
                // status 0 是降序 1 升序
                //
                [weakself priceChoose:status andRow:row];
               
            };

        }
        
        
        return cell;
    }
    if (tableView == self.tableView) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CourseListCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row]];
        CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row] forIndexPath:indexPath];
        cell.csImgTop.constant = 20.0;
//        cell.csTopConstraint.constant = 25.0;
        cell.courseModel = self.dataSource[indexPath.row];
        return cell;
    }
  
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
        next.courseId = self.dataSource[indexPath.row].cid;
        next.is_buy = self.dataSource[indexPath.row].is_buy;
        [self.navigationController pushViewController:next animated:YES];
    }
   
}



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

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //placeholder_method_call//

    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(8, 12, 8, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//
    
   
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [self.dataSource[indexPath.row].goods_type integerValue];
    next.courseId = self.dataSource[indexPath.row].cid;
    next.is_buy = self.dataSource[indexPath.row].is_buy;
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark 自定义代理

#pragma mark - 事件

- (void)ScreeningClick:(UIButton *)sender{
    
    NSInteger type = sender.tag-200;
    for (int i=1; i<4; i++) {
        //placeholder_method_call//

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
        //placeholder_method_call//

        [self showClassView];
    }else if (type == 2 || type == 3){ //价格
        
        self.isShow = NO;
        [self.screeningClassView removeFromSuperview];
        [self.bgView removeFromSuperview];
        
        if (sender.selected) { //升序
            
            if (type == 2) {
                [self.param setObject:@"price,up" forKey:@"sort"];
            }else{
                [self.param setObject:@"hot,up" forKey:@"sort"];
            }
        }else { //降序
            if (type == 2) {
                [self.param setObject:@"price,down" forKey:@"sort"];
            }else{
                [self.param setObject:@"hot,down" forKey:@"sort"];
            }
        }
        [self.pageView setParamdDic:self.param];
        [self.pageView downRefresh];
        sender.selected =! sender.selected;
    }
}

#pragma mark - 公开方法

- (void)showClassView{

    if (self.isShow) {
        //placeholder_method_call//

        self.isShow = NO;
        
        [self.screeningClassView removeFromSuperview];
        [self.bgView removeFromSuperview];
    }else{
        
        self.isShow = YES;
        // 
        [self.screeningClassView initView];
        
       
        [self.view addSubview:self.screeningClassView];
        [KeyWindow addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(KeyWindow);
            make.top.mas_equalTo(self.screeningClassView.bottom+KNavAndStatusHight);
            make.bottom.mas_equalTo(KeyWindow);
            make.trailing.mas_equalTo(KeyWindow);
        }];
    }
}

- (void)loadData{
    //placeholder_method_call//
WS(weakself)
    [APPRequest GET:@"/courseCate" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
           NSArray *arr = [CourseClassFootModel mj_objectArrayWithKeyValuesArray:result.data];
            CourseClassFootModel *model = [[CourseClassFootModel alloc] init];
            model.cate_name = @"全部";
            weakself.ClassAry = [NSMutableArray array];
            [weakself.ClassAry addObject:model];
            [weakself.ClassAry addObjectsFromArray:arr];
          [weakself.chooseTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
           

        }
    }];
    
    [self.pageView downRefresh];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)createScreeningView{
    
    NSArray *titleAry = @[@"全部课程",@"价格",@"热度"];
    CGFloat w = SCREEN_WIDTH/3;
    //placeholder_method_call//

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
}

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height = width*19/17;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat h = self.isList?SCREEN_HEIGHT-KNavAndStatusHight-45:KViewHeight-45;
    /*
    [self setCollectionViewFram:CGRectMake(0, 45, SCREEN_WIDTH, h) Layout:layout];
    [self addDefaultFootView];
    self.additionalHeight = 45;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadCell"];
     */
}

- (void)reloadViewTop{
    //placeholder_method_call//

    if (self.dataSource.count != 0) {
        //placeholder_method_call//
         /*
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
          */
    }
}

#pragma mark - 私有方法

#pragma mark - get set

- (ScreeningClassView *)screeningClassView{
    
    if (_screeningClassView == nil) {
        
        WS(weakself);
        _screeningClassView = [[ScreeningClassView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 400)];
        //placeholder_method_call//

        _screeningClassView.BlocScreeningkClick = ^(CourseClassFootModel * _Nonnull selectModel) {
            
            UILabel *lbl = [weakself.view viewWithTag:101];
            if ([selectModel.cate_name isEqualToString:@"全部"]) {
                lbl.text = selectModel.name;
            } else {
                lbl.text = selectModel.cate_name;

            }
            NSString *level = [NSString stringWithFormat:@"%@",selectModel.level];
            [weakself.param removeObjectForKey:@"category"];
            [weakself.param removeObjectForKey:@"sort"];

            if (selectModel.id != nil) {
                [weakself.param setObject:[NSString stringWithFormat:@"%@,%@",selectModel.id,level] forKey:@"category"];;
            }
                
//            }
            
            [weakself.pageView setParamdDic:weakself.param];
            [weakself.pageView downRefresh];
            
            weakself.isShow = NO;
            [weakself.screeningClassView removeFromSuperview];
            [weakself.bgView removeFromSuperview];
        };
    }
    
    return _screeningClassView;
}

- (UIView *)bgView{
    
    if (_bgView == nil) {
        
        WS(weakself);
        _bgView = [[UIView alloc] init];
        //placeholder_method_call//
//placeholder_method_call//

        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        [_bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           
            weakself.isShow = NO;
            [weakself.bgView removeFromSuperview];
            [weakself.screeningClassView removeFromSuperview];
        }];
    }
    
    return _bgView;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (HomeSearchCell *)searchView{
    
    if (_searchView == nil) {
        
        WS(weakself);
        _searchView = [[[NSBundle mainBundle] loadNibNamed:@"HomeSearchCell" owner:nil options:nil] lastObject];
        //placeholder_method_call//
       
        
        _searchView.frame = CGRectMake(0, -3, SCREEN_WIDTH, 60);
        
        _searchView.viewbg.backgroundColor = [UIColor clearColor];
        _searchView.BlockSearchClick = ^{
            
            SearchVC *next = [[SearchVC alloc] init];
            BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:next];
            [weakself presentViewController:nav animated:YES completion:nil];
        };
    }

    return _searchView;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

@end

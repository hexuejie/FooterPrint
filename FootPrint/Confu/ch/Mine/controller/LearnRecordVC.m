//
//  LaerRecordVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LearnRecordVC.h"
#import "LearnRecordCell.h"
#import "LearnRecordModel.h"
#import "CourseDetailVC.h"
#import "UIAlertController+Blocks.h"
#import "MGSwipeButton.h"

@interface LearnRecordVC ()

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSMutableArray<LearnRecordModel *> *dataSource;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UIButton *btnDelect;

@property (nonatomic, strong) UIButton *btnAll;

@property (nonatomic, strong) NSMutableArray *delectAry;

@property (nonatomic, strong) MGSwipeButton *rightButton;

@end

@implementation LearnRecordVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学习记录";
    
    self.delectAry = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];

    [self addDefaultFootView];
    //placeholder_method_call//
    self.rightBtn = [UIFactory btnMakeWithTitle:@"编辑" titleColor:[UIColor blackColor] fontSize:12 isBold:YES event:^{

        self.isEdit =! self.isEdit;
        if (self.isEdit) { //编辑状态

            [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
            [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-50-KSafeAreaHeight)];
            [self.tableView reloadData];
            self.footView.hidden = NO;
        }else{ //没在编辑状态

            [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
            [self.tableView reloadData];
            self.footView.hidden = YES;
        }
    }];
//placeholder_method_call//
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    [self addFootView];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
//placeholder_method_call//
    [super viewWillAppear:animated];
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
};

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //placeholder_method_call//
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//
    LearnRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LearnRecordCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LearnRecordCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LearnRecordModel *model = self.dataSource[indexPath.section];
    
    cell.tag = indexPath.section;
    cell.model = model;
    cell.isEdit = self.isEdit;
    cell.btnSelect.selected = model.isSelect;
    //placeholder_method_call//
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    cell.rightButtons = [self createRightButtons];
    cell.rightExpansion.fillOnTrigger = YES;
    
    [cell.btnSelect addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        model.isSelect =! model.isSelect;
        cell.btnSelect.selected = model.isSelect;
        
        if (model.isSelect) {
            
            [self.delectAry addObject:model.cid];
        }else{
            
            [self.delectAry removeObject:model.cid];
        }
        if (self.delectAry.count == self.dataSource.count) { //全选
            
            self.btnAll.selected = YES;
        }else{
            
            self.btnAll.selected = NO;
        }
        if (self.delectAry.count == 0) {
            
            self.btnDelect.selected = NO;
            [self.btnDelect setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
        }else{
            
            self.btnDelect.selected = YES;
            [self.btnDelect setTitle:[NSString stringWithFormat:@"删除(%ld)",self.delectAry.count] forState:UIControlStateNormal];
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isEdit) { //编辑状态
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LearnRecordCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        LearnRecordModel *model = self.dataSource[indexPath.section];
        //placeholder_method_call//
        model.isSelect =! model.isSelect;
        cell.btnSelect.selected = model.isSelect;
        
        if (model.isSelect) {
            
            [self.delectAry addObject:model.cid];
        }else{
            
            [self.delectAry removeObject:model.cid];
        }
        if (self.delectAry.count == self.dataSource.count) { //全选
            
            self.btnAll.selected = YES;
        }else{
            
            self.btnAll.selected = NO;
        }
        if (self.delectAry.count == 0) {
            
            self.btnDelect.selected = NO;
            [self.btnDelect setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
        }else{
            
            self.btnDelect.selected = YES;
            [self.btnDelect setTitle:[NSString stringWithFormat:@"删除(%ld)",self.delectAry.count] forState:UIControlStateNormal];
        }
    }else{ //没在编辑状态
        
        CourseDetailVC *next = [[CourseDetailVC alloc] init];
        next.goodsType = [self.dataSource[indexPath.section].goods_type integerValue];
        next.courseId = self.dataSource[indexPath.section].cid;
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark 自定义代理
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

#pragma mark - 事件

- (void)btnAllClick:(UIButton *)sender{
    
    [self.delectAry removeAllObjects];
    //placeholder_method_call//
    for (LearnRecordModel *model in self.dataSource) {
        
        if (sender.selected) {
            
            model.isSelect = NO;
        }else{
            
            model.isSelect = YES;
            [self.delectAry addObject:model.cid];
        }
    }
    sender.selected =! sender.selected;
    [self.tableView reloadData];
    if (self.delectAry.count == 0) {
        
        self.btnDelect.selected = NO;
        [self.btnDelect setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
    }else{
        
        self.btnDelect.selected = YES;
        [self.btnDelect setTitle:[NSString stringWithFormat:@"删除(%ld)",self.delectAry.count] forState:UIControlStateNormal];
    }
}

#pragma mark - 公开方法

-(NSArray *) createRightButtons{
    
    NSMutableArray * result = [NSMutableArray array];
    //placeholder_method_call//
    MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"ic_delete_learn"] backgroundColor:RGB(245, 108, 108)  callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        NSLog(@"%ld",cell.tag);
        [UIAlertController showAlertInViewController:self withTitle:@"确认删除此条学习记录吗" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [APPRequest GET:@"/studyList/cleanStudy" parameters:@{@"cid":self.dataSource[cell.tag].cid} finished:^(AjaxResult *result) {
                    
                    if (result.code == AjaxResultStateSuccess) {
                        
                        [self loadData];
                    }
                }];
            }
        }];
        return YES;
    }];
    [button setWidth:80];
    [result addObject:button];
    
    return result;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)addFootView{
    
    WS(weakself);
    
    self.footView = [[UIView alloc] init];
    self.footView.hidden = YES;
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footView];
    //placeholder_method_call//
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(50);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    
    self.btnAll = [[UIButton alloc] init];
    [self.btnAll setTitle:@"全选" forState:UIControlStateNormal];
    [self.btnAll setTitle:@"全不选" forState:UIControlStateSelected];
    [self.btnAll addTarget:self action:@selector(btnAllClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnAll.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.btnAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.footView addSubview:self.btnAll];
    [self.btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.top.bottom.mas_equalTo(self.footView);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    self.btnDelect = [[UIButton alloc] init];
    [self.btnDelect setTitle:@"删除" forState:UIControlStateNormal];
    self.btnDelect.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.btnDelect setTitleColor:RGB(192, 196, 204) forState:UIControlStateNormal];
    [self.btnDelect setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.btnDelect addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        if (weakself.delectAry.count == 0) {
            
            [KeyWindow showTip:@"请选择要删除的学习记录"];
            return ;
        }
        NSString *cid = @"";
        for (NSString *a in weakself.delectAry) {
            
            cid = [cid stringByAppendingString:[NSString stringWithFormat:@",%@",a]];
        }
        [UIAlertController showAlertInViewController:weakself withTitle:@"确认删除学习记录吗" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [APPRequest GET:@"/studyList/cleanStudy" parameters:@{@"cid":cid} finished:^(AjaxResult *result) {
                    
                    if (result.code == AjaxResultStateSuccess) {
                        
                        [weakself loadData];
                        [weakself.delectAry removeAllObjects];
                        [weakself.btnDelect setTitle:@"删除" forState:UIControlStateNormal];
                    }
                }];
            }
        }];
    }];
    [self.footView addSubview:self.btnDelect];
    //placeholder_method_call//
    [self.btnDelect mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.top.bottom.mas_equalTo(self.footView);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
}

- (void)loadData{
    
    [APPRequest GET:@"/studyList/recordList" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.dataSource = [LearnRecordModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            
            if (self.dataSource.count == 0) {
                
                [self showEmptyView:EmptyViewTypeRecord eventBlock:^(EmptyViewEventType eventType) {
                    
                }];
                self.rightBtn.hidden = YES;
                [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
                self.footView.hidden = YES;
            }else{
                
                [self hideEmptyView];
                self.rightBtn.hidden = NO;
            }
            
            [self.tableView reloadData];
        }
    }];
    //placeholder_method_call//
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

#pragma mark - 私有方法

#pragma mark - get set

@end

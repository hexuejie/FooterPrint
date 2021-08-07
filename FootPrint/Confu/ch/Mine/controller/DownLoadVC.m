//
//  DownLoadVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/17.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "DownLoadVC.h"
#import "CourseDownCell.h"
#import "CourseDetailModel.h"
#import "DownLoadListVC.h"
#import "UIAlertController+Blocks.h"
#import "MGSwipeButton.h"
#import "YCDownloadManager.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface DownLoadVC ()

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSArray<CourseDetailModel *> *dataSource;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UIButton *btnDelect;

@property (nonatomic, strong) UIButton *btnAll;

@property (nonatomic, strong) NSMutableArray *delectAry;

@property (nonatomic, strong) MGSwipeButton *rightButton;

@end

@implementation DownLoadVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

- (void)viewDidAppear:(BOOL)animated{

    [self loadData];
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"已下载";
    
    self.delectAry = [NSMutableArray array];
    self.dataSource = [NSArray array];
    
    [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight-20)];
    //placeholder_method_call//

    [self addDefaultFootView];
    
    self.rightBtn = [UIFactory btnMakeWithTitle:@"编辑" titleColor:[UIColor blackColor] fontSize:12 isBold:YES event:^{
        
        self.isEdit =! self.isEdit;
        if (self.isEdit) { //编辑状态
            
            [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
            [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-50-KSafeAreaHeight)];
            [self.tableView reloadData];
            self.footView.hidden = NO;
        }else{ //没在编辑状态
            
            [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight-20)];
            [self.tableView reloadData];
            self.footView.hidden = YES;
        }
    }];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    [self createMemoryView];
    
    [self addFootView];
}

#pragma mark - 代理

#pragma mark 系统代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //placeholder_method_call//

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //placeholder_method_call//

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //placeholder_method_call//

    return 105;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //placeholder_method_call//
    return 105;
};
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //placeholder_method_call//

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    return view;
}
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //placeholder_method_call//
    return 12;
}
//placeholder_method_impl//
//placeholder_method_impl//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseDownCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseDownCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CourseDetailModel *model = self.dataSource[indexPath.section];
    
    cell.tag = indexPath.section;
    cell.model = model;
    cell.isEdit = self.isEdit;
    cell.btnSelect.selected = model.isSelect;
    
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    cell.rightButtons = [self createRightButtons];
    cell.rightExpansion.fillOnTrigger = YES;
    //placeholder_method_call//

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
        CourseDownCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //placeholder_method_call//

        CourseDetailModel *model = self.dataSource[indexPath.section];
        
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
        
        DownLoadListVC *next = [[DownLoadListVC alloc] init];
        next.cid = self.dataSource[indexPath.section].cid;
        next.goodsType = [self.dataSource[indexPath.section].goods_type integerValue];
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark 自定义代理

#pragma mark - 事件

- (void)btnAllClick:(UIButton *)sender{
    
    [self.delectAry removeAllObjects];
    //placeholder_method_call//

    for (CourseDetailModel *model in self.dataSource) {
        
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

-(NSArray *)createRightButtons{
    
    NSMutableArray * result = [NSMutableArray array];
    //placeholder_method_call//

    MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"ic_delete_learn"] backgroundColor:RGB(245, 108, 108)  callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        
        NSLog(@"%ld",cell.tag);
        [UIAlertController showAlertInViewController:self withTitle:@"确认删除该课程吗" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [self.dataSource[cell.tag] deleteObject];
                
                NSArray *downAry = [YCDownloadManager itemsWithDownloadCid:self.dataSource[cell.tag].cid];
                for (YCDownloadItem *item in downAry) {
                    
                    [YCDownloadManager stopDownloadWithItem:item];
                }
                [self loadData];
            }
        }];
        return YES;
    }];
    [button setWidth:80];
    [result addObject:button];
    
    return result;
}

- (void)addFootView{
    
    WS(weakself);
    
    self.footView = [[UIView alloc] init];
    self.footView.hidden = YES;
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footView];
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
    //placeholder_method_call//

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
        
        [UIAlertController showAlertInViewController:weakself withTitle:@"确认删除该课程吗" message:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                for (int i = (int)weakself.delectAry.count - 1; i >= 0; i--){
                    
                    NSString *cid = weakself.delectAry[i];
                    
                    NSArray *downAry = [YCDownloadManager itemsWithDownloadCid:cid];
                    for (YCDownloadItem *item in downAry) {
                        
                        [YCDownloadManager stopDownloadWithItem:item];
                    }
                    [[CourseDetailModel findFirstByCriteria:[NSString stringWithFormat:@" WHERE cid = %@",cid]] deleteObject];
                }
                if (weakself.delectAry.count == 0) {
                    
                    weakself.btnDelect.selected = NO;
                    [weakself.btnDelect setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
                }else{
                    
                    weakself.btnDelect.selected = YES;
                    [weakself.btnDelect setTitle:[NSString stringWithFormat:@"删除(%ld)",weakself.delectAry.count] forState:UIControlStateNormal];
                }
                
                [weakself loadData];
            }
        }];
    }];
    [self.footView addSubview:self.btnDelect];
    [self.btnDelect mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.top.bottom.mas_equalTo(self.footView);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
}

- (void)loadData{
    
    self.dataSource = [CourseDetailModel findAll];
    
    if (self.dataSource.count == 0) {
        
        [self showEmptyView:EmptyViewTypeDownLoad eventBlock:^(EmptyViewEventType eventType) {
            
        }];
        self.rightBtn.hidden = YES;
        [self setTableViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight)];
        self.footView.hidden = YES;
    }else{
        //placeholder_method_call//

        [self hideEmptyView];
        self.rightBtn.hidden = NO;
    }
    
    [self.tableView reloadData];
}

- (void)createMemoryView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, 20)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIView *memoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    memoryView.backgroundColor = RGB(238, 238, 238);
    [footView addSubview:memoryView];
    
    UIView *usedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    usedView.backgroundColor = RGB(204, 204, 204);
    [footView addSubview:usedView];
    
    UILabel *lblMemory = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    lblMemory.font = [UIFont systemFontOfSize:12.0];
    lblMemory.textAlignment = NSTextAlignmentCenter;
    lblMemory.textColor = RGB(144, 147, 153);
    [footView addSubview:lblMemory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    CGFloat memory = [attributes[NSFileSystemSize] doubleValue] / (powf(1024, 3));
    CGFloat Usedmemory = [attributes[NSFileSystemFreeSize] doubleValue] / powf(1024, 3);
    
    CGFloat Allmemory = 0;
    if (memory > 0 && memory < 20) { //16g
        
        Allmemory = 16;
    }else if (memory > 20 && memory < 40){ //32g
        
        Allmemory = 32;
    }else if (memory > 40 && memory < 80){ //64
        
        Allmemory = 64;
    }else if (memory > 80 && memory < 140){ //128
        
        Allmemory = 128;
    }else if (memory > 140 && memory < 280){ //256
        
        Allmemory = 256;
    }else if (memory > 280 && memory < 540){ //512
        
        Allmemory = 512;
    }
    
    Usedmemory = Allmemory - memory + Usedmemory;
    //placeholder_method_call//

    usedView.width = SCREEN_WIDTH*((Allmemory-Usedmemory)/Allmemory);
    lblMemory.text = [NSString stringWithFormat:@"总空间%.1fG/剩余%.1fG",Allmemory,Usedmemory];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

//
//  LiveListVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/9/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "LiveListVC.h"
#import "HomeHeadCell.h"
#import "SilencePageView.h"
#import "LiveModel.h"
#import "LiveDetaileVC.h"

@interface LiveListVC ()

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<LiveModel *> *dataSource;

@end

@implementation LiveListVC

#pragma mark - yy类注释逻辑
//placeholder_method_impl//

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSArray array];
    
    [self initCollectionView];
    //placeholder_method_call//
    self.pageView = [[SilencePageView alloc] get:self.collectionView url:@"/lives" parameters:@{@"state":[NSString stringWithFormat:@"%ld",self.type]} pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            if (datas.count == 0) {
                
                [self showEmptyView:EmptyViewTypeLive eventBlock:^(EmptyViewEventType eventType) {
                    
                    [self.pageView downRefresh];
                }];
            }else{
                
                [self hideEmptyView];
            }
            self.dataSource = [LiveModel mj_objectArrayWithKeyValuesArray:datas];
            [self.collectionView reloadData];
        }
    }];
    
    [self.pageView downRefresh];
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
    cell.liveModel = self.dataSource[indexPath.row];
    //placeholder_method_call//
    return cell;
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //placeholder_method_call//
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
    //placeholder_method_call//
    return UIEdgeInsetsMake(8, 12, 8, 12);
}
//placeholder_method_impl//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//
    LiveDetaileVC *next = [[LiveDetaileVC alloc] init];
    next.liveId = self.dataSource[indexPath.row].id;
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark 自定义代理

#pragma mark - 事件
//placeholder_method_impl//
#pragma mark - 公开方法

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height = width*19/17;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //placeholder_method_call//
    [self setCollectionViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight-KSafeAreaHeight-45) Layout:layout];
    [self addDefaultFootView];
    self.additionalHeight = 0;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadCell"];
}
#pragma mark - 私有方法
//placeholder_method_impl//
#pragma mark - get set

@end

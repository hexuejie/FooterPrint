//
//  PackageVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/5.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "PackageVC.h"
#import "PackageCell.h"
#import "PackageDetailVC.h"
#import "SilencePageView.h"
#import "HomePackaglModel.h"

@interface PackageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SilencePageView *pageView;

@property (nonatomic, strong) NSArray<HomePackaglModel *> *dataSource;

@end

@implementation PackageVC


#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"套餐";
    self.dataSource = [NSArray array];
    //placeholder_method_call//

    [self initCollectionView];
    
    NSDictionary *param = @{@"sort":@"up"};
    self.pageView = [[SilencePageView alloc] get:self.collectionView url:@"/package" parameters:param pagingCallBack:^(BOOL isOk, NSMutableArray *datas, AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.dataSource = [HomePackaglModel mj_objectArrayWithKeyValuesArray:datas];
            [self.collectionView reloadData];
        }
    }];
    
    [self loadData];
}
//placeholder_method_impl//

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
    
    PackageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackageCell" forIndexPath:indexPath];
    //placeholder_method_call//

    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}
//placeholder_method_impl//

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 12, 0, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    PackageDetailVC *next = [[PackageDetailVC alloc] init];
    next.packId = self.dataSource[indexPath.row].id;
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

- (void)loadData{
    
    [self.pageView downRefresh];
    //placeholder_method_call//

}

- (void)initCollectionView{
    
    CGFloat width = SCREEN_WIDTH-24;
    CGFloat height = width*25/35;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 1);
    
    [self setCollectionViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight) Layout:layout];
    [self addDefaultFootView];
    //placeholder_method_call//

    [self.collectionView registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellWithReuseIdentifier:@"PackageCell"];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

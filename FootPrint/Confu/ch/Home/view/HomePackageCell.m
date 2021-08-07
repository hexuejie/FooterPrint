//
//  HomePackageCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomePackageCell.h"
#import "PackageCell.h"

@interface HomePackageCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat cellWidth;

@end

@implementation HomePackageCell
//placeholder_method_impl//

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//
}
//placeholder_method_impl//

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //placeholder_method_call//
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        [self initCollectionView];
    }
    return self;
}
//placeholder_method_impl//

- (void)setDataSource:(NSArray *)dataSource{
    
    _dataSource = [HomePackaglModel mj_objectArrayWithKeyValuesArray:dataSource];
    
    self.cellWidth = (SCREEN_WIDTH-24)*2/3;
    self.cellHeight = self.cellWidth*22/27;
    //placeholder_method_call//
    if (dataSource.count == 1) {
    
        self.cellHeight = self.cellWidth+20;
        self.cellWidth = (SCREEN_WIDTH-24);
    }
    self.collectionView.height = self.cellHeight + 10;
    [self.collectionView reloadData];
}
//placeholder_method_impl//

- (void)initCollectionView{

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.itemSize = CGSizeMake(width, height);

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //placeholder_method_call//
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellWithReuseIdentifier:@"PackageCell"];
    
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//placeholder_method_impl//

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PackageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackageCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    //placeholder_method_call//
    return cell;
}
//placeholder_method_impl//


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //placeholder_method_call//
    return UIEdgeInsetsMake(10, 12, 0, 12);
}
//placeholder_method_impl//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//
    if (self.BlockPackageClick) {
        self.BlockPackageClick(self.dataSource[indexPath.row]);
    }
}
//placeholder_method_impl//

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    return CGSizeMake(self.cellWidth, self.cellHeight);
}
//placeholder_method_impl//

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//placeholder_method_call//
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//
    // Configure the view for the selected state
}

@end

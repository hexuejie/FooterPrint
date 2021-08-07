//
//  HomeCourseCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeCourseCell.h"
#import "HomeHeadCell.h"
#import "HomeHeadFirstCell.h"

@interface HomeCourseCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation HomeCourseCell
//placeholder_method_impl//


- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self initCollectionView];
    }
    return self;
}
//placeholder_method_impl//


- (void)setDataSource:(NSArray *)dataSource{
    
    _dataSource = dataSource;
    
    NSInteger line = ceil(dataSource.count/2.0);
    //placeholder_method_call//

    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height = width*9.0/16.0 + 120;
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (height)*line);
    [self.collectionView reloadData];
}
//placeholder_method_impl//

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height =  width*9.0/16.0 + 110;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    //placeholder_method_call//

    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadFirstCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadFirstCell"];
    
    [self.contentView addSubview:self.collectionView];
}
//placeholder_method_impl//

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//placeholder_method_impl//


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 3) {
        HomeHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadCell" forIndexPath:indexPath];
        return cell;
    }
    
    HomeHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadCell" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    //placeholder_method_call//

    if (self.type == 1) { //课程
     
        _dataSource = [CourslModel mj_objectArrayWithKeyValuesArray:self.dataSource];
        cell.courseModel = self.dataSource[indexPath.row];
    }else if (self.type == 2){ //直播
        
        _dataSource = [LiveModel mj_objectArrayWithKeyValuesArray:self.dataSource];
        cell.liveModel = self.dataSource[indexPath.row];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    if (self.type == 3) {
        return CGSizeMake((SCREEN_WIDTH - 50), 80);
    }
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height =  width*9.0/16.0 + 110;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //placeholder_method_call//

    return UIEdgeInsetsMake(10, 12, 0, 12);
}
//placeholder_method_impl//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 1) { //课程
        //placeholder_method_call//

        if (self.BlockCourseClick) {
            self.BlockCourseClick(self.dataSource[indexPath.row]);
        }
    }else if (self.type == 2){ //直播
        
        if (self.BlockLiveClick) {
            self.BlockLiveClick(self.dataSource[indexPath.row]);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

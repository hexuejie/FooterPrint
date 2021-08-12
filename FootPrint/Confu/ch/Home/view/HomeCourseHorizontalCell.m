//
//  HomeCourseCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeCourseHorizontalCell.h"
#import "HomeHeadSecondCell.h"
#import "HomeHeadFirstCell.h"
#import "LearnRecordModel.h"

@interface HomeCourseHorizontalCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UILabel *emptyLabel;
@end

@implementation HomeCourseHorizontalCell
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
    _emptyLabel.hidden = YES;
    
    if (self.type == 4) {
        if (_dataSource.count == 0) {
            _emptyLabel.hidden = NO;
        }
        
        self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
    }else{
        self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
    }
    
    [self.collectionView reloadData];
}
//placeholder_method_impl//

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height =  width*9.0/16.0 + 110;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    //placeholder_method_call//
    layout.minimumLineSpacing = 0.01;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadSecondCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadSecondCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadFirstCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadFirstCell"];
    
    [self.contentView addSubview:self.collectionView];
    
    _emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 100)];
    _emptyLabel.text = @"您还没有记录，请开始学习吧~";
    _emptyLabel.textColor = UIColorFromRGB(0x999999);
    [self addSubview:_emptyLabel];
    _emptyLabel.hidden = YES;
}
//placeholder_method_impl//

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//placeholder_method_impl//

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 3) {
        
    HomeHeadFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadFirstCell" forIndexPath:indexPath];
        cell.sureButton.tag = indexPath.row;
        [cell.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    }else if (self.type == 4) {
        
        HomeHeadSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadSecondCell" forIndexPath:indexPath];
        LearnRecordModel *model = self.dataSource[indexPath.row];
        cell.titleLabel.text = model.course_title;
        [cell.coverImageView sd_setImageWithURL:APP_IMG(model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
        return cell;
    }
    
    return [UICollectionViewCell new];
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    if (self.type == 3) {
        return CGSizeMake((SCREEN_WIDTH - 50), 85);
    }else{
        return CGSizeMake(150*WidthRatio2, 110);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //placeholder_method_call//
    if (self.type == 3) {
        return UIEdgeInsetsMake(1, 6, 0, 6);
    }else{
        return UIEdgeInsetsMake(1, 11, 0, 11);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 4) { //课程
        //placeholder_method_call//

        if (self.BlockCourseClick) {
            self.BlockCourseClick(self.dataSource[indexPath.row]);
        }
    }else if (self.type == 3){ //直播
        
        if (self.BlockLiveClick) {
            self.BlockLiveClick(self.dataSource[indexPath.row]);
        }
    }
}
- (void)sureButtonClick:(UIButton *)button{
    if (self.BlockLiveClickYuyue) {
        self.BlockLiveClickYuyue(self.dataSource[button.tag]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

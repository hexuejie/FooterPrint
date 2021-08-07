//
//  TagSuperCell.m
//  Trillion
//
//  Created by 胡翔 on 2021/1/28.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "TagSuperCell.h"
#import "CollectionViewSpaceLayout.h"
@interface TagSuperCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<NSString *> *tagModels;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
static NSString * const cellID = @"cellID2";

@implementation TagSuperCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainLabel.layer.borderColor = [UIColor colorWithHex:0xb2b2b2].CGColor;
    self.mainLabel.textColor = [UIColor colorWithHex:0xb2b2b2];
    self.hotIndex = -1;
    self.priceIndex = -1;
    self.mainLabel.layer.borderWidth = 0.5;
    CollectionViewSpaceLayout *layout = [[CollectionViewSpaceLayout alloc] init];
          layout.sectionInsets = UIEdgeInsetsMake(0, 8, 0, 8);

//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
     self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}
- (void)setLabels:(NSArray<CourseClassFootModel *> *)labels {
    _labels = labels;
    
    [self.collectionView reloadData];
    WS(weakself)
    if (self.row == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (weakself.BlockCollectViewheight) {
                weakself.BlockCollectViewheight(weakself.collectionView.contentSize.height,weakself.row);
                
            }
            [weakself.collectionView reloadData];
            
        });
    }
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //placeholder_method_call//
    return  self.labels.count;
//    return self.model.key_labels.count;
//    return self.dataSource.count;
}
//
//placeholder_method_impl//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //placeholder_method_call//
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:8];
    if (lb == nil) {
        lb = [[UILabel alloc] init];
        lb.textColor = [UIColor colorWithHex:0x333333];
        lb.font = [UIFont systemFontOfSize:12];
//        lb.layer.cornerRadius = 3;
        lb.layer.masksToBounds = true;
        lb.layer.borderColor = [UIColor colorWithHex:0xeeeeee].CGColor;
//        lb.layer.borderWidth = 1.2;
//        lb.textAlignment = NSTextAlignmentCenter;
//        lb.backgroundColor = [UIColor colorWithHex:0x777777];
        lb.tag = 8;
        [cell.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(cell.contentView);
        }];
        
    }
   
    
    
    
    lb.text = self.labels[indexPath.row].cate_name;
    if (self.row == 0) {
        if (indexPath.row == self.categorySelectRow) {
            lb.textColor = [UIColor colorWithHex:0x479298];
            lb.font = [UIFont boldSystemFontOfSize:15.0f];
        } else {
            lb.textColor = [UIColor colorWithHex:0xb2b2b2];
            lb.font = [UIFont systemFontOfSize:12.0f];


        }
    }
    
    
    if (self.row == 1) {
        UIImageView *topImg = (UIImageView *)[cell.contentView viewWithTag:10];
        if (!topImg) {
            topImg = [[UIImageView alloc] init];
            topImg.tag = 10.0;
            [cell.contentView addSubview:topImg];
        }
        topImg.image = [UIImage imageNamed:@"ic_up_n"];

        UIImageView *bottomImg = (UIImageView *)[cell.contentView viewWithTag:12];
        if (!bottomImg) {
            bottomImg = [[UIImageView alloc] init];
            bottomImg.tag = 12.0;
            [cell.contentView addSubview:bottomImg];
        }
        bottomImg.image = [UIImage imageNamed:@"ic_bottom_n"];

        /*
         UIImage *img = [UIImage imageNamed:@"home_rache_rect"];
          [self.bgImgView setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
          self.bgImgView.tintColor = [UIColor colorWithHexString:GET_MASTER_COLOR];
         */
        
        if (indexPath.row == self.sortSelectRow) {
            lb.textColor = [UIColor colorWithHex:0x479298];
            lb.font = [UIFont boldSystemFontOfSize:15.0f];
            topImg.frame = CGRectMake(30.0, 2.0, 14.0, 7.0);
            bottomImg.frame = CGRectMake(30.0, topImg.bottom + 2.7, 14.0, 7.0);
            if (indexPath.row == 0) {
                if (self.hotIndex == 0) {
                  bottomImg.image = [[UIImage imageNamed:@"ic_bottom_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    bottomImg.tintColor = [UIColor colorWithHexString:@"#479298"];
                    
                } else if (self.hotIndex == 1) {
                    topImg.image = [[UIImage imageNamed:@"ic_up_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    topImg.tintColor = [UIColor colorWithHexString:@"#479298"];
                }
            }
            if (indexPath.row == 1) {
                if (self.priceIndex == 0) {
                  bottomImg.image = [[UIImage imageNamed:@"ic_bottom_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    bottomImg.tintColor = [UIColor colorWithHexString:@"#479298"];
                    
                } else if (self.priceIndex == 1) {
                    topImg.image = [[UIImage imageNamed:@"ic_up_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    topImg.tintColor = [UIColor colorWithHexString:@"#479298"];
                }
            }
            
        } else {
            lb.textColor = [UIColor colorWithHex:0xb2b2b2];
            lb.font = [UIFont systemFontOfSize:12.0f];
            topImg.frame = CGRectMake(25.0, 4.1, 10.0, 5.0);
            bottomImg.frame = CGRectMake(25.0, topImg.bottom + 2.6, 10.0, 5.0);

        }
    }
    
    
    
   
    


    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self.labels[indexPath.row].cate_name widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22];
    if (indexPath.section == 1) {
        return  CGSizeMake(width + 23.0 ,22.0);
    }
    return  CGSizeMake(width + 15.0 ,20.0);
    
}
//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //placeholder_method_call//
//    NewsTagResultVC *tagVC = [[NewsTagResultVC alloc] init];
//    tagVC.model =  self.tagModels[indexPath.row];
//    [self.navigationController pushViewController:tagVC animated:YES];
    if (self.row == 0) {
        self.categorySelectRow = indexPath.row;
        if (self.blockSelectRow) {
            self.blockSelectRow(indexPath.row);
        }
       
    }
    
    if (self.row == 1) {
        self.sortSelectRow = indexPath.row;
        if (indexPath.row == 0) {
            if (self.hotIndex == -1) {
                self.hotIndex = 0;
            } else {
                if (self.hotIndex == 0) {
                    self.hotIndex = 1;
                } else {
                    self.hotIndex = 0;
                }
            }
        }
        if (indexPath.row == 1) {
            if (self.priceIndex == -1) {
                self.priceIndex = 0;
            } else {
                if (self.priceIndex == 0) {
                    self.priceIndex = 1;
                } else {
                    self.priceIndex = 0;
                }
            }
        }
        NSInteger status;
        if (indexPath.row == 0) {
            status = self.hotIndex;
        } else {
            status = self.priceIndex;
        }
        
        // 先降后升
        if (self.blockSortSelectRow) {
            self.blockSortSelectRow(status, indexPath.row);
        }
       
    }
           
    
   
}

- (void)setCategorySelectRow:(NSInteger)categorySelectRow {
    _categorySelectRow = categorySelectRow;
    [self.collectionView reloadData];
}

- (void)setSortSelectRow:(NSInteger)sortSelectRow {
    _sortSelectRow = sortSelectRow;
    [self.collectionView reloadData];
}

@end

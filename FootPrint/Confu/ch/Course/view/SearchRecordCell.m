//
//  SearchRecordCell.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "SearchRecordCell.h"
#import "HistorySearchCell.h"
#import "CollectionViewSpaceLayout.h"
#import "HotCell.h"
@interface SearchRecordCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) BOOL deleteStatus;
@end
@implementation SearchRecordCell
static NSString * const cellID3 = @"cellID3";
static NSString * const cellID4 = @"cellID4";

- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//
//    self.historyArr = [NSArray arrayWithObject:@"1"];
    // Initialization code
    CollectionViewSpaceLayout *layout = [[CollectionViewSpaceLayout alloc] init];
          layout.sectionInsets = UIEdgeInsetsMake(0, 15, 0, 15);

//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
     self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID3];
}
//placeholder_method_impl//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//placeholder_method_call//

    // Configure the view for the selected state
}
//placeholder_method_impl//
- (IBAction)btnDeleteClick:(id)sender {
    //placeholder_method_call//

//    if (self.BlockDeleteClick) {
//        self.BlockDeleteClick();
//    }
}
//placeholder_method_impl//
- (void)setHistoryArr:(NSArray *)historyArr {
    _historyArr = historyArr;
        
    [self refreshHeight];

        
}

- (void)setHotArr:(NSArray<HotModel *> *)hotArr {
    _hotArr = hotArr;
    [self refreshHeight];
}
- (void)refreshHeight {
    [self.collectionView reloadData];

    WS(weakself)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakself.BlockCollectViewheight) {
            weakself.BlockCollectViewheight(weakself.collectionView.contentSize.height + 20,0);
            
        }
        [weakself.collectionView reloadData];
        
    });
}
//- (void)setHistoryArr:(NSArray<NSString *> *)historyArr {
//    _historyArr = historyArr;
//}
//- (void)setHistoryArr:(NSArray<NSString *> *)historyArr {
//    _historyArr = historyArr;
    
//    [self.collectionView reloadData];
    /*
    WS(weakself)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakself.BlockCollectViewheight) {
            weakself.BlockCollectViewheight(weakself.collectionView.contentSize.height + 20,0);
            
        }
        [weakself.collectionView reloadData];
        
    });
    */
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //placeholder_method_call//
    if (self.section == 0) {
        return  self.hotArr.count;

    }
    return  self.historyArr.count;
//    return self.model.key_labels.count;
//    return self.dataSource.count;
}
//
//placeholder_method_impl//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.section == 0) {
        [collectionView registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellWithReuseIdentifier:cellID4];
        HotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID4 forIndexPath:indexPath];
        cell.nameLabel.text = self.hotArr[indexPath.row].name;
        return cell;
        
    }
    
    if (self.section == 1) {
        [collectionView registerNib:[UINib nibWithNibName:@"HistorySearchCell" bundle:nil] forCellWithReuseIdentifier:cellID3];
       
       HistorySearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID3 forIndexPath:indexPath];
    
       
       
       cell.nameLabel.text = self.historyArr[indexPath.row];
       
       if (self.deleteStatus) {
           cell.deleteBtn.hidden = NO;
       } else {
           cell.deleteBtn.hidden = YES;

       }
       WS(weakself)

       cell.BlockTapGestion = ^(NSString *name) {
           if (weakself.BlockTapGestion) {
               weakself.BlockTapGestion(name);
           }
           
       };
       cell.BlockLongPressGestion = ^(NSString *name) {
           weakself.deleteStatus = YES;
           [weakself.collectionView reloadData];
       };
       cell.BlockDeleteClick = ^(NSString * _Nonnull name) {
           if (weakself.BlockDeleteClick) {
               weakself.BlockDeleteClick(name);
           }
       };
       
       
       return cell;
    }
    return [UICollectionViewCell new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.section == 0) {
        CGFloat width = [self.hotArr[indexPath.row].name widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22];
         return  CGSizeMake(width + 40.0 ,25.0);
    }
   CGFloat width = [self.historyArr[indexPath.row] widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22];
    return  CGSizeMake(width + 30.0 ,27.0);
    
}
//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //placeholder_method_call//
//    NewsTagResultVC *tagVC = [[NewsTagResultVC alloc] init];
//    tagVC.model =  self.tagModels[indexPath.row];
//    [self.navigationController pushViewController:tagVC animated:YES];
//    if (self.row == 0) {
//        self.categorySelectRow = indexPath.row;
//        if (self.blockSelectRow) {
//            self.blockSelectRow(indexPath.row);
//        }
//
//    }
//
//    if (self.row == 1) {
//        self.sortSelectRow = indexPath.row;
//        if (indexPath.row == 0) {
//            if (self.hotIndex == -1) {
//                self.hotIndex = 0;
//            } else {
//                if (self.hotIndex == 0) {
//                    self.hotIndex = 1;
//                } else {
//                    self.hotIndex = 0;
//                }
//            }
//        }
//        if (indexPath.row == 1) {
//            if (self.priceIndex == -1) {
//                self.priceIndex = 0;
//            } else {
//                if (self.priceIndex == 0) {
//                    self.priceIndex = 1;
//                } else {
//                    self.priceIndex = 0;
//                }
//            }
//        }
//        NSInteger status;
//        if (self.row == 0) {
//            status = self.hotIndex;
//        } else {
//            status = self.priceIndex;
//        }
//
//        // 先降后升
//        if (self.blockSortSelectRow) {
//            self.blockSortSelectRow(status, indexPath.row);
//        }
//
//    }
    
    if (self.section == 0) {
        if (self.BlockhotClick) {
            self.BlockhotClick(self.hotArr[indexPath.row]);
        }
    }
           
    
   
}

//- (void)setCategorySelectRow:(NSInteger)categorySelectRow {
//    _categorySelectRow = categorySelectRow;
//    [self.collectionView reloadData];
//}

@end

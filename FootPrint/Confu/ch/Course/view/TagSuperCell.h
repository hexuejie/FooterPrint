//
//  TagSuperCell.h
//  Trillion
//
//  Created by 胡翔 on 2021/1/28.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseClassFootModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TagSuperCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,strong)NSArray<CourseClassFootModel *> *labels;
@property (nonatomic,strong)void(^BlockCollectViewheight)(CGFloat he,NSInteger row);
@property (nonatomic,strong)void(^blockSelectRow)(NSInteger row);
@property (nonatomic,strong)void(^blockSortSelectRow)(NSInteger status, NSInteger row);

@property (nonatomic,assign)CGFloat rowHeight;
@property (nonatomic,assign)NSInteger  categorySelectRow;
@property (nonatomic, assign) NSInteger sortSelectRow;
@property (nonatomic, assign) NSInteger hotIndex; //-1 没有 0,向下，1，向上
@property (nonatomic, assign) NSInteger priceIndex; //-1 没有 0,向下，1，向上


@end

NS_ASSUME_NONNULL_END

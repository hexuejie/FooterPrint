//
//  SearchRecordCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/19.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchRecordCell : UITableViewCell
//placeholder_property//

//placeholder_property//


@property (nonatomic, copy) void (^BlockDeleteClick)(NSString *name);
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *historyArr;
@property (nonatomic, copy) void (^BlockTapGestion)(NSString *name);

@property (nonatomic, copy) void (^BlockhotClick)(HotModel *model);

@property (nonatomic,assign) NSInteger section;

@property (nonatomic,strong)void(^BlockCollectViewheight)(CGFloat he,NSInteger row);
@property (nonatomic,strong)NSArray<HotModel *> *hotArr;

@end

NS_ASSUME_NONNULL_END

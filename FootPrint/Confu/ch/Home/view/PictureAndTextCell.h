//
//  PictureAndTextCell.h
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/14.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  HomeBannelModel;
NS_ASSUME_NONNULL_BEGIN

@interface PictureAndTextCell : UITableViewCell
@property (nonatomic, strong)UICollectionView *collectionView;
//placeholder_property//
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat cellWidth;
//placeholder_property//
@property (nonatomic, strong) NSArray *dataSource;
//placeholder_property//

@property (nonatomic, assign) CGFloat gapWidth;// 行与行之间的间隙

@property (nonatomic,strong) void(^BlockClick)(HomeBannelModel *model);
//placeholder_property//
//placeholder_property//

//placeholder_property//
//placeholder_property//
//placeholder_property//

//placeholder_property//
//placeholder_property//
//placeholder_property//
//placeholder_property//
//placeholder_property//
//placeholder_property//

//placeholder_property//
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDirection:(int)driection;
@end


NS_ASSUME_NONNULL_END

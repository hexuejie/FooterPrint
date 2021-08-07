//
//  PictureAndTextCell.m
//  BusinessColleage
//
//  Created by 胡翔 on 2020/7/14.
//  Copyright © 2020 cscs. All rights reserved.
//

#import "PictureAndTextCell.h"
#import "PictureAndTextCollectViewCell.h"
#import "HomeBannelModel.h"

@interface PictureAndTextCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *bottomBgView;
@property (nonatomic,strong)UIView *bottomscrollviewView;
//placeholder_property//
@end
@implementation PictureAndTextCell {
    CGFloat _gap; // 列
}
//placeholder_method_impl//
- (void)awakeFromNib {
    [super awakeFromNib];
    //placeholder_method_call//
    self.backgroundColor = [UIColor whiteColor];

}
//placeholder_method_impl//
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDirection:(int)direction
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //placeholder_method_call//
        // Initialization code
    
         UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //    layout.itemSize = CGSizeMake(width, height);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

      
            
            self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 0, 10) collectionViewLayout:layout];
            self.collectionView.backgroundColor = [UIColor clearColor];
            
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
            //
            self.collectionView.scrollsToTop = NO;
            self.collectionView.showsVerticalScrollIndicator = NO;
            self.collectionView.showsHorizontalScrollIndicator = NO;
        
       
            
            [self.contentView addSubview:self.collectionView];
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).mas_equalTo(15.0);
            make.trailing.mas_equalTo(self.contentView).mas_equalTo(-15.0);

            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(1.0);
        }];
        
        
    }
    return self;
}
- (void)setDataSource:(NSArray *)dataSource{
    
    _dataSource = dataSource;
 
  _dataSource =  [HomeBannelModel mj_objectArrayWithKeyValuesArray:dataSource];
    
    
    NSInteger line = ceil(dataSource.count/5.0);
    //placeholder_method_call//
    CGFloat width = (375.0 / SCREEN_WIDTH) * 34;
    
//    self.backgroundColor = [UIColor redColor];
//    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.frame = CGRectMake(0, 8, SCREEN_WIDTH - 0.0,    line * (32 + width));
    [self.collectionView reloadData];
}
//placeholder_method_impl//

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        //
//        // Initialization code
//
//        [self initCollectionView];
//    }
//    return self;
//}
//
/**
   NSInteger colum = ceil(model.pictureAndTextModel.dataSource.count/(model.pictureAndTextModel.row_num + 2.0));
           if (model.pictureAndTextModel.show_type == 1) { // 图片加文字
               if (model.pictureAndTextModel.slide_type == 1) { // 固定的方式
                   if (model.pictureAndTextModel.row_num == 3) {
                      return (36 + 4 + 16) *colum;
                   } else {
                       return  (40 + 4 + 16) *colum;
                   }
               } else if (model.pictureAndTextModel.slide_type == 2) { // 滑动的方式
                   if (model.pictureAndTextModel.row_num == 3) {
                       return 36 + 4 + 16;
                   }else {
                       return 40 + 4 + 16;
                   }
               }
   
           } else if(model.pictureAndTextModel.show_type == 2)  { // 纯文字
               if (model.pictureAndTextModel.slide_type == 1) { // 固定的方式
                   if (model.pictureAndTextModel.row_num <= 4) {
                       return  49 *colum;
                   }
                   else {
                       return  42 *colum;
                   }
               } else if (model.pictureAndTextModel.slide_type == 2) { // 滑动的方式
                   return 92;
               }
           }
 */
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

//placeholder_method_impl//

//placeholder_method_impl//
//- (void)setDataSource:(NSArray *)dataSource{
//
//    _dataSource = dataSource;
//
//
//    //        return (168 / 375) *SCREEN_WIDTH + 20 + 44 + 20 + 95;
//
//
////    self.cellWidth = (SCREEN_WIDTH)*160/375;
////    self.cellHeight = self.cellWidth*89/160 + 20 + 44 + 20 ;
////    if (self.type == 5) {
////         self.cellWidth = (SCREEN_WIDTH)*300/375;
////        self.cellHeight = (SCREEN_WIDTH)*168/375 + 44 + 20 ;
////
////    }
//
//    //
////    if (dataSource.count == 1) {
////
////        self.cellHeight = self.cellWidth+20;
////        self.cellWidth = (SCREEN_WIDTH-24);
////    }
//    self.cellWidth = SCREEN_WIDTH / 5;
//    self.cellHeight = 88;
//    self.collectionView.height = self.cellHeight ;
//    [self.collectionView reloadData];
//}
//
//placeholder_method_impl//
//- (void)initCollectionView{
//
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
////    layout.itemSize = CGSizeMake(width, height);
//
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH - 30.0, 10) collectionViewLayout:layout];
//    self.collectionView.backgroundColor = [UIColor clearColor];
//    //placeholder_method_call//
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    //
//    self.collectionView.scrollsToTop = NO;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//
//
//    [self.contentView addSubview:self.collectionView];
//}
//placeholder_method_impl//

//placeholder_method_impl//
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//
//placeholder_method_impl//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [NSString stringWithFormat:@"PictureAndText"];

             [self.collectionView registerNib:[UINib nibWithNibName:@"PictureAndTextCollectViewCell" bundle:nil] forCellWithReuseIdentifier:key];
          PictureAndTextCollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:key forIndexPath:indexPath];
         cell.model = self.dataSource[indexPath.row];
          
        
        return cell;
        
    
    //placeholder_method_call//
     
        
                


   
    
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    if (cell == nil) {
//        [UITableViewCell alloc] init
//    }
  
    //
    
    
}
//placeholder_method_impl//


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //
    return UIEdgeInsetsMake(0, 17.5, 0,17.5);
}
//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.BlockClick) {
        self.BlockClick(self.dataSource[indexPath.row]);
    }
}
//

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    CGFloat width = (375.0 / SCREEN_WIDTH) * 34;

    
    return CGSizeMake((SCREEN_WIDTH - 35.0) / 5.0, (32.0 + width));
}
//

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return self.gapWidth;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//
    // Configure the view for the selected state
}

@end

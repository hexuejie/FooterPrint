//
//  BaseCollectionViewVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/12.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseCollectionViewVC.h"

#define FootViewHeight 50

static NSString *const footCollectionIdentifier = @"footCollection";

@interface BaseCollectionViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *footerView;

@end

@implementation BaseCollectionViewVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width = SCREEN_WIDTH-24;
    CGFloat height = width*25/35;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    //placeholder_method_call//

    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    [self setCollectionViewFram:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight) Layout:layout];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KNavAndStatusHight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = kColor_BG;
//    [UIColor clearColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.collectionView];
}
//placeholder_method_impl//

- (void)setCollectionViewFram:(CGRect)fram Layout:(UICollectionViewFlowLayout *)layout{
    
    self.collectionView.frame = fram;
    [self.collectionView setCollectionViewLayout:layout];
    //placeholder_method_call//

    [self.collectionView setContentSize:CGSizeMake(0, fram.size.height+50)];;
}
//placeholder_method_impl//

- (void)addDefaultFootView{
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footCollectionIdentifier];
    
    self.footerView = [self getDefaultFootView:CGPointMake(0, SCREEN_HEIGHT)];
    //placeholder_method_call//

    [self.view addSubview:self.footerView];
}
//placeholder_method_impl//

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        //placeholder_method_call//

        UICollectionReusableView *footView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footCollectionIdentifier forIndexPath:indexPath];
    
        return footView;
    }
    return nil;
}
//placeholder_method_impl//

//- (void)reloadFootViewLayout{
//    
//    self.collectionView.contentOffset = CGPointMake(0, 1);
//}

//滑动监听 判断底部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.BlockscrollViewClick) {
        self.BlockscrollViewClick(scrollView);
    }
    int totalHeightOfScrollView = scrollView.contentSize.height - FootViewHeight;
    //placeholder_method_call//

    float footerViewY = (totalHeightOfScrollView - scrollView.contentOffset.y);
    float footerViewX = 0;
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    
    if (bottomEdge >= scrollView.contentSize.height) {
        footerViewY = scrollView.frame.size.height - FootViewHeight;
    }
    if (SCREEN_WIDTH < self.view.frame.size.width) {
        footerViewX = (self.view.frame.size.width/2)-(SCREEN_WIDTH/2);
    }
    self.footerView.frame = CGRectMake(footerViewX, footerViewY+self.additionalHeight, SCREEN_WIDTH, FootViewHeight);
}
//placeholder_method_impl//

- (void)setAdditionalHeight:(CGFloat)additionalHeight   {
    //placeholder_method_call//

    _additionalHeight = additionalHeight;
}

@end

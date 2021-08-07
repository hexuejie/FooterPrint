//
//  SilenceImagePreview.m
//  SilenceIOS_OC
//
//  Created by SilenceMac on 16/6/29.
//  Copyright © 2016年 SilenceMac. All rights reserved.
//

#import "SilenceImagePreview.h"
#import "SilenceImagePreviewCell.h"

@interface SilenceImagePreview ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
    UICollectionView *_collectionView;
    
    BOOL _isHideNaviBar;
    UIView *_naviBar;
    UIButton *_backButton;
    
    UILabel *_titleLabel;
}

@end

@implementation SilenceImagePreview

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];//导航背景;
    // 导航字体色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self configCollectionView];
//    [self configCustomNaviBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = YES;
    if (_currentIndex) [_collectionView setContentOffset:CGPointMake((VIEW_W(self.view)) * _currentIndex, 0) animated:NO];
}

- (BOOL)prefersStatusBarHidden{

    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configCustomNaviBar {
    _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_W(self.view), 64)];
    _naviBar.backgroundColor = [UIColor blackColor];
//    _naviBar.alpha = 0.7;

    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    [_backButton setImage:[UIImage imageNamed:@"silence_preview_navi_back"] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = CGPointMake(SCREEN_WIDTH/2, 64/2);
    [self refreshNaviBarState];
//    
//    _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.tz_width - 54, 10, 42, 42)];
//    [_selectButton setImage:[UIImage imageNamedFromMyBundle:@"photo_def_photoPickerVc.png"] forState:UIControlStateNormal];
//    [_selectButton setImage:[UIImage imageNamedFromMyBundle:@"photo_sel_photoPickerVc.png"] forState:UIControlStateSelected];
//    [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [_naviBar addSubview:_selectButton];
    
    [_naviBar addSubview:_titleLabel];
    [_naviBar addSubview:_backButton];
    [self.view addSubview:_naviBar];
}

- (void)back {
    if (self.navigationController.childViewControllers.count < 2) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configCollectionView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(VIEW_W(self.view), SCREEN_HEIGHT - KNavAndStatusHight);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHight, VIEW_W(self.view) , SCREEN_HEIGHT - KNavAndStatusHight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.contentSize = CGSizeMake(VIEW_W(self.view) * self.imgs.count, SCREEN_HEIGHT - KNavAndStatusHight);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[SilenceImagePreviewCell class] forCellWithReuseIdentifier:@"SilenceImagePreviewCell"];

//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    _titleLabel.textColor = [UIColor whiteColor];
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    CGFloat titleY = 64;
//    if (KISIPHONEX) {
//        titleY = 88;
//    }
//    _titleLabel.center = CGPointMake(SCREEN_WIDTH/2, titleY/2);
//    [self.view addSubview:_titleLabel];
    [self refreshNaviBarState];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    _currentIndex = (offSet.x + (VIEW_W(self.view) * 0.5)) / VIEW_W(self.view);
    [self refreshNaviBarState];
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SilenceImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SilenceImagePreviewCell" forIndexPath:indexPath];
    cell.imgData = self.imgs[indexPath.row];
    
//    __block BOOL _weakIsHideNaviBar = _isHideNaviBar;
//    __weak typeof(_naviBar) weakNaviBar = _naviBar;
    if (!cell.singleTapGestureBlock) {
        cell.singleTapGestureBlock = ^(){
            // show or hide naviBar / 显示或隐藏导航栏
//            _weakIsHideNaviBar = !_weakIsHideNaviBar;
//            weakNaviBar.hidden = _weakIsHideNaviBar;
            [self back];
        };
    }
    if (!cell.longPressGestureRecognizerBlock) {
        cell.longPressGestureRecognizerBlock = ^(UIImage *img) {

            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:nil
                                                  message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];

            UIAlertAction *CanceltAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:CanceltAction];

            UIAlertAction *alert = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
            }];
            [alertController addAction:alert];
            [self presentViewController:alertController animated:YES completion:nil];
        };
    }
    return cell;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [KeyWindow showSuccessTip:@"保存成功"];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

#pragma mark - Private Method

- (void)refreshNaviBarState{
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.imgs.count];
    self.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.imgs.count];
}

@end

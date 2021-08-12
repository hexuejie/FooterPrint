//
//  LaerRecordVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "HomeLiveListVC.h"
#import "HomeHeadFirstCell.h"
#import "LearnRecordModel.h"
#import "CourseDetailVC.h"
#import "UIAlertController+Blocks.h"
#import "MGSwipeButton.h"
#import "HomeTipBgView.h"
#import "HomeHeadSecondCell.h"
#import "HomeLiveTipTimeLabel.h"
@interface HomeLiveListFooter : UICollectionReusableView

@property (nonatomic, strong) UILabel *footerLabel;
@end
@implementation HomeLiveListFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
        _footerLabel.text = @"更多活动敬请关注【脚印互动】微信公众号";
        _footerLabel.font = [UIFont systemFontOfSize:14];
        _footerLabel.textColor = UIColorFromRGB(0x999999);
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_footerLabel];
    }
    return self;
}

@end

@interface HomeLiveListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HomeLiveListVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//
//placeholder_method_impl//
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播预告";
    
    self.dataSource = [NSMutableArray array];

    [self initCollectionView];
    
    [self loadData];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)initCollectionView{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 1), 85);
    layout.footerReferenceSize =CGSizeMake(SCREEN_WIDTH, 50);
    //placeholder_method_call//
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0.01;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadFirstCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadFirstCell"];
    [self.collectionView registerClass:[HomeLiveListFooter class] forSupplementaryViewOfKind:@"HomeLiveListFooter" withReuseIdentifier:@"HomeLiveListFooter"];
    
    [self.view addSubview:self.collectionView];
}
//placeholder_method_impl//

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//placeholder_method_impl//

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeHeadFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadFirstCell" forIndexPath:indexPath];
    cell.sureButton.tag = indexPath.row;
    [cell.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //placeholder_method_call//
    return UIEdgeInsetsMake(20, 16, 0, 12);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        HomeLiveListFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:@"HomeLiveListFooter" withReuseIdentifier:@"HomeLiveListFooter" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showHomeTipBgViewDetial:self.dataSource[indexPath.row]];
}
- (void)sureButtonClick:(UIButton *)button{
    [self showHomeTipBgViewYuyueSuccess:self.dataSource[button.tag]];
}


- (void)showHomeTipBgViewYuyueSuccess:(NSDictionary *)model{
    ///liveos/api/ykapp/front/livePrepare/info
    
    HomeTipBgView *_tipView1 = [[HomeTipBgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_tipView1];

    UIView *showView = [[UIView alloc]init];
    [_tipView1.allBgView addSubview:showView];
    [_tipView1.allBgView sendSubviewToBack:showView];
    
    UIImageView *topImageView = [[UIImageView alloc]init];
    [showView addSubview:topImageView];
    topImageView.image = [UIImage imageNamed:@"home_tip_top"];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(showView);
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    [showView addSubview:titleLabel];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(showView);
        make.top.equalTo(topImageView.mas_bottom).offset(10);
    }];
    UILabel *contentLabel = [[UILabel alloc]init];
    [showView addSubview:contentLabel];
    contentLabel.textColor = UIColorFromRGB(0x999999);
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(showView);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
    }];
    HomeLiveTipTimeLabel *timeLabel = [[NSBundle mainBundle] loadNibNamed:@"HomeLiveTipTimeLabel" owner:self options:nil].firstObject;
    [showView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(showView);
        make.top.equalTo(contentLabel.mas_bottom).offset(33);
    }];
    
    titleLabel.text = @"预约成功!";
    contentLabel.text = @"开播前我们将会通过APP推送通知您观看直播";
//    timeLabel.text = @"开播倒计时 134 时 21 分";
    
    HomeHeadFirstCell *bottomCell = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadFirstCell" owner:self options:nil].firstObject;
    [showView addSubview:bottomCell];
    bottomCell.sureButton.hidden = YES;
    bottomCell.model =  model;
    [bottomCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(showView);
        make.height.mas_equalTo(88);
        make.top.equalTo(timeLabel.mas_bottom).offset(70);
        make.bottom.equalTo(showView.mas_bottom).offset(-1);
    }];
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(_tipView1.allBgView);
        make.top.equalTo(_tipView1.allBgView).offset(0);
        make.bottom.equalTo(_tipView1.allBgView).offset(-85);
//        make.height.mas_equalTo(400);
    }];
}
- (void)showHomeTipBgViewDetial:(NSDictionary *)model{
    ///liveos/api/ykapp/front/livePrepare/info
    WS(weakself)
    [TalkfunHttpTools liveGet:[NSString stringWithFormat:@"%@%@?liveCode=%@",HOST_ACTION2,@"/liveos/api/ykapp/front/livePrepare/info",model[@"liveCode"]]  params:nil callback:^(id result) {
        if ([result[@"code"] intValue] == 200) {
            NSLog(@"result.data %@",result[@"result"]);
            
//                coverUrl = "<null>";
//                intro = "\U9080\U8bf7\U60a8\U89c2\U770b\U76f4\U64ad";
//                isSubscribe = 0;
//                liveCode = BfFHb6DdyC;
//                liveTime = "2020-11-12 01:40:18";
//                liveUrl = "http://wx9863d15750a63786.live.jiaoyin.vip/?liveCode=BfFHb6DdyC&air_path=preview&1628752248";
//                subscribeCount = 0;
//                title = "\U6d4b\U8bd511.11";
        }
    }];
    
    HomeTipBgView *_tipView1 = [[HomeTipBgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_tipView1];

    UIView *showView = [[UIView alloc]init];
    [_tipView1.allBgView addSubview:showView];
    [_tipView1.allBgView sendSubviewToBack:showView];
    
    HomeLiveTipTimeLabel *timeLabel = [[NSBundle mainBundle] loadNibNamed:@"HomeLiveTipTimeLabel" owner:self options:nil].firstObject;
    [showView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(showView);
    }];
//    timeLabel.text = @"开播倒计时 134 时 21 分";
    
    HomeHeadSecondCell *bottomCell = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadSecondCell" owner:self options:nil].firstObject;
    bottomCell.coverImageView.layer.cornerRadius = 10;
    bottomCell.imageBottom.constant = 90;
    [showView addSubview:bottomCell];
    bottomCell.titleLabel.text = [NSString stringWithFormat:@"%@",model[@"title"]];
    [bottomCell.coverImageView sd_setImageWithURL:model[@"liveUrl"] placeholderImage:[UIImage imageNamed:@"mydefault"]];
    [bottomCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(showView).offset(12);
        make.trailing.equalTo(showView).offset(-12);
        make.bottom.equalTo(showView).offset(-1);
        make.height.mas_equalTo(260);
    }];
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(_tipView1.allBgView);
        make.top.equalTo(_tipView1.allBgView).offset(43);
        make.bottom.equalTo(_tipView1.allBgView).offset(-85);
        make.height.mas_equalTo(340);
    }];
}

#pragma mark - 公开方法
- (void)loadNewData{
    self.dataSource = [NSMutableArray array];
    [self loadData];
}

- (void)loadData{
    
    WS(weakself)
    [TalkfunHttpTools livePost:[NSString stringWithFormat:@"%@%@",HOST_ACTION2,@"/liveos/api/ykapp/front/livePrepare/page"] params:@{
        @"pageNumber": @10,
        @"pageSize": @1,
        @"queryKey": @""
    } callback:^(id result) {
        NSLog(@"result.data %@",result[@"result"]);

        [self.collectionView.mj_header endRefreshing];
        if ([result[@"code"] intValue] == 200) {
            
            NSArray *list = result[@"result"][@"list"];
            [weakself.dataSource addObjectsFromArray:list];
            [weakself.collectionView reloadData];
        }
        if (self.dataSource && self.dataSource.count > 0) {
            [self performSelector:@selector(hideEmptyView) withObject:nil afterDelay:1];
        }
    }];
}



#pragma mark - 私有方法

#pragma mark - get set

@end

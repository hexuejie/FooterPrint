//
//  PackageDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/6.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "PackageDetailVC.h"
#import "HomeHeadCell.h"
#import "PackageModel.h"
#import "CourseDetailVC.h"
#import "BuyVipVC.h"
#import "AddOrderVC.h"

static NSString *const headerCollectionIdentifier = @"headerCollection";

static NSString *const footCollectionIdentifier = @"footCollection";

@interface PackageDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) PackageModel *model;

@end

@implementation PackageDetailVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"套餐详情";
    NSLog(@"%@",self.model);
    //placeholder_method_call//

    //顶部导航栏右侧按钮
    UIBarButtonItem *rightBarBtn = [UIFactory barBtnMakeWithImage:[UIImage imageNamed:@"course_share"] event:^{
        
        [self showShareViews:3 shareId:self.model.package_info.id shareImgUrl:self.banner shareTitle:self.model.package_info.title Success:^(OSMessage *message) {
            
            NSLog(@"");
        } Fail:^(OSMessage *message, NSError *error) {
            
            NSLog(@"");
        }];
    }];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    [self initCollectionView];
    
    [self loadData];
}

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.model.course_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeadCell" forIndexPath:indexPath];
    //placeholder_method_call//

    cell.courseModel = self.model.course_list[indexPath.row];
    
    return cell;
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(12, 12, 0, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [self.model.course_list[indexPath.row].goods_type integerValue];
    next.courseId = self.model.course_list[indexPath.row].cid;
    next.is_buy = self.model.course_list[indexPath.row].is_buy;
   
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark 自定义代理

#pragma mark - 事件

- (IBAction)btnGoHomeClick:(id)sender {
    //placeholder_method_call//

    [self BackHome:0];
}

- (IBAction)btnShareClick:(id)sender {
    //placeholder_method_call//

    [self showShareViews:3 shareId:self.model.package_info.id shareImgUrl:self.banner shareTitle:self.model.package_info.title Success:^(OSMessage *message) {
        
        NSLog(@"");
    } Fail:^(OSMessage *message, NSError *error) {
        
        NSLog(@"");
    }];
}
//placeholder_method_impl//

#pragma mark - 公开方法
//placeholder_method_impl//

- (void)loadData{
    
    [APPRequest GET:@"/packageDetail" parameters:@{@"id":self.packId} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [PackageModel mj_objectWithKeyValues:result.data];
            
            NSInteger line = ceil(self.model.course_list.count/2.0);
            CGFloat width = (SCREEN_WIDTH - 36)/2;
            CGFloat height = width*19/17;
            
            self.csCollectionViewHeight.constant = line*(height+12);
            [self.collectionView reloadData];
            [self updataView];
        }
    }];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)updataView{
    
    [self.imgHead sd_setImageWithURL:APP_IMG(self.model.package_info.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    self.lblTitle.text = self.model.package_info.title;
    //placeholder_method_call//

    self.lblPrice.text = [self.model.package_info.price ChangePrice];
    self.lblCourseNum.text = [NSString stringWithFormat:@"包含%ld门课程",self.model.course_list.count];
    self.lblDesc.text = self.model.package_info.desc;
    
    if ([self.model.is_vip integerValue] == 1) { //是vip
        
        self.lblIsFree.hidden = NO;
        self.lblIsFree.text = @"VIP会员免费观看";
    }else{
        
        self.lblIsFree.hidden = YES;
    }
    if ([self.model.isBuy integerValue] == 1) { //已购买
        
        [self.btnBuyPack setTitle:@"已购买" forState:UIControlStateNormal];
//        self.btnBuyPack.backgroundColor = RGB(131, 193, 254);
    }else{
        
//        self.btnBuyPack.backgroundColor = RGB(4, 134, 254);
        
        if ([self.lblPrice.text isEqualToString:@"免费"]) {
            
            [self.btnBuyPack setTitle:@"立即报名" forState:UIControlStateNormal];
        }else{
            
            [self.btnBuyPack setTitle:@"立即购买" forState:UIControlStateNormal];
        }
    }
    
    if ([self.model.vip_switch integerValue] == 1) { //开启了vip购买功能
        
        self.csBtnBuyVipWidth.constant = SCREEN_WIDTH*0.3;
    }else{
        
        self.csBtnBuyVipWidth.constant = 0;
    }
}
//placeholder_method_impl//

- (void)initCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 36)/2;
    CGFloat height = width*19/17;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeadCell" bundle:nil] forCellWithReuseIdentifier:@"HomeHeadCell"];
}

#pragma mark - 私有方法
//placeholder_method_impl//

#pragma mark - get set

- (IBAction)btnBuyPackClick:(id)sender {

    if ([self.model.isBuy integerValue] != 1) { //未购买
        
        if ([self.lblPrice.text isEqualToString:@"免费"]) {
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:@"ios" forKey:@"source"];
            [param setObject:self.model.package_info.id forKey:@"item_id"];
            [param setObject:@"package" forKey:@"order_type"];
            
            [APPRequest GET:@"/addOrder" parameters:param finished:^(AjaxResult *result) {
                
                if (result.code == AjaxResultStateSuccess) {
                    
                    [KeyWindow showTip:@"报名成功"];
                    self.model.isBuy = @"1";
                    [self.btnBuyPack setTitle:@"已购买" forState:UIControlStateNormal];
                    self.btnBuyPack.backgroundColor = RGB(131, 193, 254);
                }
            }];
        }else{
            
            AddOrderVC *next = [[AddOrderVC alloc] init];
            next.goodsId = self.model.package_info.id;
            next.goodsType = @"package";
            next.BlockBackClick = ^{
                
                [self loadData];
            };
            [self.navigationController pushViewController:next animated:YES];
        }
    }
}
//placeholder_method_impl//

- (IBAction)btnBuyVipClick:(id)sender {
    
    BuyVipVC *next = [[BuyVipVC alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

@end

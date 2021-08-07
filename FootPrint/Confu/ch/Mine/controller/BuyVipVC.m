//
//  BuyVipVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyVipVC.h"
#import "BuyVipCell.h"
#import "BuyVipModel.h"
#import "AddOrderVC.h"
#import "SilenceWebViewUtil.h"
#import "YQInAppPurchaseTool.h"

@interface BuyVipVC ()<YQInAppPurchaseToolDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) BuyVipModel *model;

@property (nonatomic, strong) VipModel *selectModel;

@property (nonatomic, strong) SilenceWebViewUtil *webViewUtil;

@property (nonatomic, strong) NSArray *titleAry;

@property (nonatomic, strong) NSArray *priceAry;

@property (nonatomic, assign) NSInteger selectIdx;

@end

@implementation BuyVipVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"脚印云课";
    self.selectIdx = -100;
    
    self.titleAry = @[@"1个月",@"3个月"];
    self.priceAry = @[@"6",@"18"];
    self.backHeight.constant = 300;
    
    //获取单例
    YQInAppPurchaseTool *IAPTool = [YQInAppPurchaseTool defaultTool];
    //设置代理
    IAPTool.delegate = self;
    //placeholder_method_call//

    CGFloat width = (SCREEN_WIDTH - 48)/2;
    CGFloat height = width*7/17;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BuyVipCell" bundle:nil] forCellWithReuseIdentifier:@"BuyVipCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.webViewUtil = [[SilenceWebViewUtil alloc] initWithWebView:self.webView];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.com"]]];
//    self.webView.scrollView.contentSize = CGSizeMake(0, 100 + 50);
//           self.webView.scrollView.contentOffset = CGPointMake(0, 1);
    [self loadData];
    
    
}
//placeholder_method_impl//

#pragma mark - 代理
//placeholder_method_impl//

#pragma mark 系统代理

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    if (![isAudit isEqualToString:@"no"]) {
//     //placeholder_method_call//
//
//        return self.titleAry.count;
//    }
    return self.model.card_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuyVipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyVipCell" forIndexPath:indexPath];
    //placeholder_method_call//

//    if (![isAudit isEqualToString:@"no"]) {
//
//        cell.lblPrice.text = [NSString stringWithFormat:@"¥ %@",self.priceAry[indexPath.row]];
//        cell.lblName.text = self.titleAry[indexPath.row];
//        if (self.selectIdx == indexPath.row) {
//
//            cell.viewBg.backgroundColor = RGB(229, 242, 254);
//            cell.viewBg.layer.borderColor = RGB(4, 134, 254).CGColor;
//        }else{
//
//            cell.viewBg.backgroundColor = [UIColor whiteColor];
//            cell.viewBg.layer.borderColor = RGB(238, 238, 238).CGColor;
//        }
//    }else{
//
//
//    }
    cell.model = self.model.card_list[indexPath.row];
    return cell;
}
//placeholder_method_impl//

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}
//placeholder_method_impl//

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//placeholder_method_impl//

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //placeholder_method_call//

    self.selectIdx = indexPath.row;
    self.selectModel = self.model.card_list[indexPath.row];
    
    for (VipModel *model in self.model.card_list) {
        
        if (model.id == self.selectModel.id) {
            
            model.isSelect = YES;
        }else{
            
            model.isSelect = NO;
        }
    }
    
    [self.collectionView reloadData];
}
//placeholder_method_impl//

#pragma mark 自定义代理

#pragma mark --------YQInAppPurchaseToolDelegate
//IAP工具已获得可购买的商品
- (void)IAPToolGotProducts:(NSMutableArray *)products {
    //    NSLog(@"GotProducts:%@",products);
    //    for (SKProduct *product in products){
    //        NSLog(@"localizedDescription:%@\nlocalizedTitle:%@\nprice:%@\npriceLocale:%@\nproductID:%@",
    //              product.localizedDescription,
    //              product.localizedTitle,
    //              product.price,
    //              product.priceLocale,
    //              product.productIdentifier);
    //        NSLog(@"--------------------------");
    //    }
    
//    self.productArray = products;
    [KeyWindow hiddenLoading];
    
    if (products.count <= 0) {
        
        [KeyWindow showTip:@"没有查询到该商品"];
        return;
    }
    //placeholder_method_call//

    SKProduct *product = products[0];
    [KeyWindow showNormalLoadingWithTip:@"正在支付..."];
    [[YQInAppPurchaseTool defaultTool] buyProduct:product.productIdentifier];
}
//placeholder_method_impl//

//支付失败/取消
-(void)IAPToolCanceldWithProductID:(NSString *)productID {
    NSLog(@"canceld:%@",productID);
    
    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"购买失败"];
}

//支付成功了，并开始向苹果服务器进行验证（若CheckAfterPay为NO，则不会经过此步骤）
-(void)IAPToolBeginCheckingdWithProductID:(NSString *)productID {
    NSLog(@"BeginChecking:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    //    [KeyWindow showTip:@"支付成功"];
}
//placeholder_method_impl//



//商品被重复验证了
-(void)IAPToolCheckRedundantWithProductID:(NSString *)productID {
    NSLog(@"CheckRedundant:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"重复验证了"];
}
//placeholder_method_impl//

//商品完全购买成功且验证成功了。（若CheckAfterPay为NO，则会在购买成功后直接触发此方法）
-(void)IAPToolBoughtProductSuccessedWithProductID:(NSString *)productID
                                          andInfo:(NSDictionary *)infoDic {
    NSLog(@"BoughtSuccessed:%@",productID);
    NSLog(@"successedInfo:%@",infoDic);
    
    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"购买成功！"];
    //placeholder_method_call//

    [APPRequest POST:@"/setvip" parameters:@{@"id":self.selectModel.id} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            // 在这里进行刷新
            [self loadData];
        }
    }];
}
//placeholder_method_impl//

//商品购买成功了，但向苹果服务器验证失败了
//2种可能：
//1，设备越狱了，使用了插件，在虚假购买。
//2，验证的时候网络突然中断了。（一般极少出现，因为购买的时候是需要网络的）
-(void)IAPToolCheckFailedWithProductID:(NSString *)productID
                               andInfo:(NSData *)infoData {
    NSLog(@"CheckFailed:%@",productID);
    
    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"购买失败！"];
}
//placeholder_method_impl//

//恢复了已购买的商品（仅限永久有效商品）
-(void)IAPToolRestoredProductID:(NSString *)productID {
    NSLog(@"Restored:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"成功恢复了商品"];
}

//内购系统错误了
-(void)IAPToolSysWrong {
    NSLog(@"SysWrong");
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"内购系统出错"];
}

#pragma mark - 事件

- (IBAction)btnBuyClick:(id)sender {
    
//    if (![isAudit isEqualToString:@"no"]) {
//
//        if (self.selectIdx < 0) {
//            //placeholder_method_call//
//
//            [KeyWindow showTip:@"请选择开通服务"];
//            return;
//        }
//        NSString *productId = [NSString stringWithFormat:@"com.GZJ.gzjyApp_vip%@",self.priceAry[self.selectIdx]];
//
//        [KeyWindow showNormalLoadingWithTip:@"正在连接苹果..."];
//        //向苹果询问哪些商品能够购买
//        [[YQInAppPurchaseTool defaultTool] requestProductsWithProductArray:@[productId]];
//
//    }else{
//
//
//    }
    
    if (self.selectModel.id == nil) {
              
              [KeyWindow showTip:@"请选择开通服务"];
              return;
          }
          //placeholder_method_call//

          AddOrderVC *next = [[AddOrderVC alloc] init];
          next.goodsId = self.selectModel.id;
          next.goodsType = @"usercard";
          next.BlockBackClick = ^{
              
              [self loadData];
          };
          [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - 公开方法

- (void)loadData{
 
    [APPRequest GET:@"/myCard" parameters:nil finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [BuyVipModel mj_objectWithKeyValues:result.data];
            
            self.lblName.text = self.model.user[@"nickname"];
            [self.imgHead sd_setImageWithURL:[NSURL URLWithString:self.model.user[@"face"]] placeholderImage: [UIImage imageNamed:@"head_default"]];
            //            是否是会员 0 无会员卡 1非终身卡 2终身卡 -1过期
            NSInteger vipType = [self.model.vip integerValue];
            self.lblStatus.text = @"续费";
            if (vipType == 0) {
                
                self.lblStatus.text = @"开通";
                self.lblTime.text = @"开通会员服务，享受优惠吧";
                self.imgVip.image = nil;
            }else if (vipType == 1){
                
                self.lblTime.text = [NSString stringWithFormat:@"%@ 到期，购买后有效期将顺延",self.model.expire_time];
                self.imgVip.image = [UIImage imageNamed:@"mine_headVip"];
            }else if (vipType == 2){
                
                self.lblTime.text = @"永久";
                self.imgVip.image = [UIImage imageNamed:@"mine_headVip"];
            }else if (vipType == -1){
                
                self.lblTime.text = [NSString stringWithFormat:@"%@ 已到期，购买后将重新开通会员",self.model.expire_time];
                self.imgVip.image = [UIImage imageNamed:@"mine_headVip_n"];
            }
            WS(weakself);
            NSLog(@"%@",self.model.explain);
            NSString *contentUrl = [NSString stringWithFormat:@"<html> \n"
                                            "<head> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> \n"
                                            "<style type=\"text/css\"> \n"
                                            "body {font-size:14px;}\n"
                                            "span{line-height:20px;}\n"
                                            "p{line-height:20px;}\n"
                                             "textarea{line-height:20px;}\n"
                                            "</style> \n"
                                            "</head> \n"
                                            "<body>"
                                            "<script type='text/javascript'>"
                                            "window.onload = function(){\n"
                                            "var $img = document.getElementsByTagName('img');\n"
                                            "for(var p in  $img){\n"
                                            " $img[p].style.width = '100%%';\n"
                                            "$img[p].style.height ='auto'\n"
                                            "}\n"
                                            "}"
                                            "</script>%@"
                                            "</body>"
                                            "</html>", self.model.explain];
            NSLog(@"%@",self.model.explain);
            [self.webViewUtil setContent:contentUrl heightBlock:^(CGFloat h) {

                weakself.backHeight.constant = h;
            }];
            
            CGFloat width = (SCREEN_WIDTH - 48)/2;
            CGFloat height = (width*7/17)+12;
            self.csCollectionHeight.constant = height*ceil(self.model.card_list.count/2.0);
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - 私有方法

#pragma mark - get set

@end

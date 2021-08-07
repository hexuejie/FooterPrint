//
//  BuyGoldVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BuyGoldVC.h"
#import "YQInAppPurchaseTool.h"
#import "BuyGoldCell.h"
#import "LoginVC.h"
@interface BuyGoldVC ()<YQInAppPurchaseToolDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *productArray;

@property (nonatomic,strong) NSArray *priceAry;

@property (nonatomic,strong) NSArray *goldAry;

@property (nonatomic,strong) NSMutableArray *selectAry;

@property (nonatomic, assign) NSInteger selectId;
@property (nonatomic, assign) Boolean confrimTourist;

@end

@implementation BuyGoldVC

#pragma mark - yy类注释逻辑

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"学习金充值";
    if (!Ktoken) {
         self.lblName.text = @"游客";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSInteger goldInt = [[user objectForKey:@"gold"] integerValue];
//        NSString *goldText = [NSString stringWithFormat:@"%ld",(long)goldInt];
        if ([user objectForKey:@"gold"] != nil) {
            self.lblGold.text = [user objectForKey:@"gold"];

        } else {
            self.lblGold.text = @"0";
        }
        
    } else {
        UserModel *model = [APPUserDefault getCurrentUserFromLocal];
          [self.viewHead sd_setImageWithURL:[NSURL URLWithString:model.user.face] placeholderImage: [UIImage imageNamed:@"head_default"]];
          
              self.lblName.text = model.user.nickname;
    }
    
  
    
   
    
  self.priceAry = @[@"30",@"40",@"60",@"78",@"88"];
    self.selectAry = @[@"1",@"0",@"0",@"0",@"0"].mutableCopy;
    self.selectId = 1;
    
    [self createCollectionView];
    //placeholder_method_call//

    //获取单例
    YQInAppPurchaseTool *IAPTool = [YQInAppPurchaseTool defaultTool];
    //设置代理
    IAPTool.delegate = self;
    
}


#pragma mark - 代理

#pragma mark 系统代理

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.priceAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuyGoldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuyGoldCell" forIndexPath:indexPath];
    
    cell.lblGold.text = [NSString stringWithFormat:@"%@学习金",self.priceAry[indexPath.row]];
    cell.lblPrice.text = [NSString stringWithFormat:@"%@元",self.priceAry[indexPath.row]];
    if ([self.selectAry[indexPath.row] integerValue] == 1) {
        
        cell.viewBg.layer.borderWidth = 1;
        cell.viewBg.layer.borderColor = RGB(4, 134, 254).CGColor;
    }else{
       
        cell.viewBg.layer.borderWidth = 0;
        cell.viewBg.layer.borderColor = [UIColor clearColor].CGColor;
    }

    return cell;
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //placeholder_method_call//

    return 12;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        for (int i=0; i<self.selectAry.count; i++) {
            
            if (i == indexPath.row) {
                
                self.selectId = i+1;
                [self.selectAry replaceObjectAtIndex:i withObject:@"1"];
            }else{
                
                [self.selectAry replaceObjectAtIndex:i withObject:@"0"];
            }
        }

    [self.collectionView reloadData];
}

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
     
    
    self.productArray = products;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [KeyWindow hiddenLoading];
        if (products.count <= 0) {
              
              [KeyWindow showTip:@"没有查询到该商品"];
              return;
          }
          SKProduct *product = products[0];
          
          
          
          [KeyWindow showNormalLoadingWithTip:@"正在支付..."];
        [[YQInAppPurchaseTool defaultTool] buyProduct:product.productIdentifier];


    }];
   
    

  
}

//支付失败/取消
-(void)IAPToolCanceldWithProductID:(NSString *)productID {
    NSLog(@"canceld:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    //placeholder_method_call//

    [KeyWindow showTip:@"购买失败"];
}

//支付成功了，并开始向苹果服务器进行验证（若CheckAfterPay为NO，则不会经过此步骤）
-(void)IAPToolBeginCheckingdWithProductID:(NSString *)productID {
    NSLog(@"BeginChecking:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
//    [KeyWindow showTip:@"支付成功"];
}


//商品被重复验证了
-(void)IAPToolCheckRedundantWithProductID:(NSString *)productID {
    NSLog(@"CheckRedundant:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"重复验证了"];
}
//placeholder_method_impl//
//placeholder_method_impl//


//商品完全购买成功且验证成功了。（若CheckAfterPay为NO，则会在购买成功后直接触发此方法）
-(void)IAPToolBoughtProductSuccessedWithProductID:(NSString *)productID
                                          andInfo:(NSDictionary *)infoDic {
    NSLog(@"BoughtSuccessed:%@",productID);
    NSLog(@"successedInfo:%@",infoDic);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"购买成功！"];
    NSString *gold = self.priceAry[self.selectId-1];

//    在这里进行添加金币
    if (Ktoken) {
          [APPRequest POST:@"/rechargeGold" parameters:@{@"gold":gold} finished:^(AjaxResult *result) {
             
              if (result.code == AjaxResultStateSuccess) {
                  
                  [self loadData];
//                  if (self.BlockBackClick) {
//                      self.BlockBackClick();
//                  }
              }
          }];
    } else {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
          NSInteger goldInt = [[user objectForKey:@"gold"] integerValue];
          goldInt += [gold integerValue];
        NSString *goldText = [NSString stringWithFormat:@"%ld",(long)goldInt];
         [user setObject:goldText forKey:@"gold"];
          [user synchronize];
        self.lblGold.text = goldText;

        
    }
    
    
  
}
//placeholder_method_impl//

//商品购买成功了，但向苹果服务器验证失败了
//2种可能：
//1，设备越狱了，使用了插件，在虚假购买。
//2，验证的时候网络突然中断了。（一般极少出现，因为购买的时候是需要网络的）
-(void)IAPToolCheckFailedWithProductID:(NSString *)productID
                               andInfo:(NSData *)infoData {
    NSLog(@"CheckFailed:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"购买失败！"];
}
//placeholder_method_impl//
//placeholder_method_impl//

//恢复了已购买的商品（仅限永久有效商品）
-(void)IAPToolRestoredProductID:(NSString *)productID {
    NSLog(@"Restored:%@",productID);
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"成功恢复了商品"];
}
//placeholder_method_impl//
//placeholder_method_impl//

//内购系统错误了
-(void)IAPToolSysWrong {
    NSLog(@"SysWrong");
    //placeholder_method_call//

    [KeyWindow hiddenLoading];
    [KeyWindow showTip:@"内购系统出错"];
}
//placeholder_method_impl//

#pragma mark - 事件
//placeholder_method_impl//

- (IBAction)btnBuyGoldClick:(id)sender {
 //placeholder_method_call//
    
    if (!self.confrimTourist && !Ktoken) {
        
    NSString *title = NSLocalizedString(@"游客模式购买的学习金仅限本设备使用，推荐选择登陆后购买", nil);

    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *loginButtonTitle = NSLocalizedString(@"登陆(推荐)", nil);
   NSString *touristButtonTitle = NSLocalizedString(@"游客模式购买", nil);
   WS(weakself)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:loginButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [weakself loginAction];
        

    }];
    UIAlertAction *touristAction = [UIAlertAction actionWithTitle:touristButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        weakself.confrimTourist = YES;
        [weakself payAction];
        
     }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
        [alertController addAction:touristAction];

    
    [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self payAction];
    }
    
    
    
    
    
    
    

  
}



- (void)payAction{
    NSString *productId = [NSString stringWithFormat:@"com.footprint.srinvest_%@",self.priceAry[self.selectId-1]];
      
      [KeyWindow showNormalLoadingWithTip:@"正在连接苹果..."];
      //向苹果询问哪些商品能够购买
      [[YQInAppPurchaseTool defaultTool] requestProductsWithProductArray:@[productId]];
}

//placeholder_method_impl//

#pragma mark - 公开方法

- (void)loadData{
    
    if (!Ktoken) {
        return;
    }
    
    //获取全部积分数
    [APPRequest GET:@"/myGold" parameters:@{@"type":@"0"} finished:^(AjaxResult *result) {
        
        if (result.code == AjaxResultStateSuccess) {
            
            self.lblGold.text = [NSString stringWithFormat:@"%@",result.data[@"gold"]];
        }
    }];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)createCollectionView{
    
    CGFloat width = (SCREEN_WIDTH - 48)/2;
    CGFloat height = width*8/18;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BuyGoldCell" bundle:nil] forCellWithReuseIdentifier:@"BuyGoldCell"];
    //placeholder_method_call//

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    height = (width*8/18)+12;
    self.csCollectionViewHeight.constant = height*ceil(self.priceAry.count/2.0);
    [self.collectionView reloadData];
}
//placeholder_method_impl//

#pragma mark - 私有方法
//placeholder_method_impl//

#pragma mark - get set

-(NSMutableArray *)productArray{
    if(!_productArray){
        _productArray = [NSMutableArray array];
    }
    //placeholder_method_call//

    return _productArray;
}
//placeholder_method_impl//


@end


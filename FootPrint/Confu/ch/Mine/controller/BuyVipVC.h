//
//  BuyVipVC.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/4.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseVC.h"
#import <WebKit/WebKit.h>
#import "JsWKWebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyVipVC : BaseVC

@property (weak, nonatomic) IBOutlet UIImageView *imgHead;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backHeight;

//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (IBAction)btnBuyClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *imgVip;
//placeholder_property//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csCollectionHeight;
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

@property (weak, nonatomic) IBOutlet JsWKWebView *webView;
//placeholder_property//

//placeholder_property//
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@end

NS_ASSUME_NONNULL_END

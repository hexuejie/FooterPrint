//
//  PlaceVC.m
//  MTTourism
//
//  Created by YyMacBookPro on 2017/12/1.
//  Copyright © 2017年 com.MT.MTTourism. All rights reserved.
//

#import "PlaceVC.h"
#import "XBCityObj.h"

@interface PlaceVC ()<XBProvinceTableViewDelegate>

@property (nonatomic, strong) NSArray *provinceArray;

@end

@implementation PlaceVC

#pragma mark - 美通类注释逻辑

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"地址";

    self.tableView.myDelegate = self;

    UserLocation *location = [APPUserDefault getCurrentUserLocation];
    self.lblCurrentCity.text = [NSString stringWithFormat:@"当前: %@ ",location.city];
    self.lblSelectCity.text = self.selectCity;
    
}

#pragma mark - XBProvinceTableViewDelegate
- (void)provinceTableView:(XBProvinceTableView *)tableView didSelectedAreaCell:(NSIndexPath *)indexPath areaName:(NSString *)areaName {

}

- (void)provinceTableView:(XBProvinceTableView *)tableView didSelectedAreaCell:(NSIndexPath *)indexPath CityName:(NSString *)cityName{

    [self.navigationController popViewControllerAnimated:YES];
    if (self.BlockCityClick) {
        self.BlockCityClick(cityName);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理

#pragma mark 系统代理

#pragma mark 自定义代理

#pragma mark - 事件

#pragma mark - 公开方法

#pragma mark - 私有方法

#pragma mark - get set

@end

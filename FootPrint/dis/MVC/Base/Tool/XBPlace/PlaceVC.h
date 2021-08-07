//
//  PlaceVC.h
//  MTTourism
//
//  Created by YyMacBookPro on 2017/12/1.
//  Copyright © 2017年 com.MT.MTTourism. All rights reserved.
//

#import "ImportHeader.h"
#import "XBProvinceTableView.h"
@interface PlaceVC : BaseVC

@property (nonatomic, copy) void (^BlockCityClick)(NSString *City);

@property (weak, nonatomic) IBOutlet XBProvinceTableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *lblCurrentCity;

@property (weak, nonatomic) IBOutlet UILabel *lblSelectCity;

@property (nonatomic, strong) NSString *selectCity;

@end

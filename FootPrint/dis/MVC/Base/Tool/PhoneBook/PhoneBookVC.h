//
//  PhoneBookVC.h
//  MTTourism
//
//  Created by YyMacBookPro on 2017/12/21.
//  Copyright © 2017年 com.MT.MTTourism. All rights reserved.
//

#import "ImportHeader.h"
#import "PersonModel.h"
@interface PhoneBookVC : BaseVC

@property (nonatomic, strong) void (^blockChoose)(PersonModel *model);

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

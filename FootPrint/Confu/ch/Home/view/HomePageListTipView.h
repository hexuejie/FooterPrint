//
//  HomePageListTipView.h
//  FootPrint
//
//  Created by 何学杰 on 2021/8/12.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageListTipView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *listBgView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void (^BlockItemClick)(NSInteger index);

@end


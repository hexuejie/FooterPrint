//
//  BaseTableViewVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/2/26.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "BaseTableViewVC.h"

#define FootViewHeight 50

@interface BaseTableViewVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewVC
//placeholder_method_impl//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kColor_BG;
    //placeholder_method_call//

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
//placeholder_method_impl//
- (void)setTableViewFram:(CGRect)fram{
    
    self.tableView.frame = fram;
}

- (void)addDefaultFootView{
    
    self.footerView = [self getDefaultFootView:CGPointMake(0, self.tableView.bottom)];
    [self.view addSubview:self.footerView];
    //placeholder_method_call//

    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, FootViewHeight+self.additionalHeight)];
    self.tableView.tableFooterView = footView;
}
//
//- (void)reloadFootViewLayout{
//
//    self.tableView.contentOffset = CGPointMake(0, 1);
//}
//placeholder_method_impl//
//滑动监听 判断底部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.BlockscrollViewClick) {
        //placeholder_method_call//

        self.BlockscrollViewClick(scrollView);
    }
    [self setFootViewoffset:scrollView];
}
//placeholder_method_impl//
- (void)setFootViewoffset:(UIScrollView *)scrollView{
    
    if (scrollView != self.tableView) {
        
        return;
    }
    int totalHeightOfScrollView = scrollView.contentSize.height - FootViewHeight;
    float footerViewY = (totalHeightOfScrollView - scrollView.contentOffset.y);
    float footerViewX = 0;
    //placeholder_method_call//

    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    
    if (bottomEdge >= scrollView.contentSize.height) {
        footerViewY = scrollView.frame.size.height - FootViewHeight;
    }
    if (SCREEN_WIDTH < self.view.frame.size.width) {
        footerViewX = (self.view.frame.size.width/2)-(SCREEN_WIDTH/2);
    }
    self.footerView.frame = CGRectMake(footerViewX, footerViewY, SCREEN_WIDTH, FootViewHeight);
}

//placeholder_method_impl//
- (void)setAdditionalHeight:(CGFloat)additionalHeight   {
    //placeholder_method_call//

    _additionalHeight = additionalHeight;
}

@end

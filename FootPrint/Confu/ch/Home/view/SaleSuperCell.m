//
//  SaleSuperCell.m
//  FootPrint
//
//  Created by 胡翔 on 2021/4/29.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "SaleSuperCell.h"
#import "SaleListCell.h"
#import "UIView+ViewController.h"
#import "MoreSaleVC.h"
@interface SaleSuperCell()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation SaleSuperCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    
    
//    self.bgView.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.bgView.layer.shadowColor = [UIColor colorWithHex:0xc8c8c8].CGColor;// 阴影的颜色
//    self.bgView.layer.cornerRadius = 16;
//
//    self.bgView.layer.shadowRadius = 2.5;// 阴影扩散的范围控制
//    self.bgView.layer.shadowOffset  = CGSizeMake(0, 0);// 阴影的范围
    // https://www.kancloud.cn/songxing10000/text/866375
    
    // 底层view圆角，如：
    CALayer *roundedLayer = self.bgView.layer;

      roundedLayer.masksToBounds= YES;
      roundedLayer.cornerRadius = 16;
    ///  自身阴影，如
       CALayer *shadowLayer = self.bgView.layer;

       shadowLayer.shadowColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.5].CGColor;
       shadowLayer.shadowOffset = CGSizeMake(0,0);
       shadowLayer.shadowRadius = 6;
       shadowLayer.shadowOpacity = 1;
       shadowLayer.masksToBounds = NO;
    
    
    
}
- (void)setContent:(NSArray*)content {
    _content = content;
    [self.tableView reloadData];


}
//- (void)setTimeArr:(NSMutableArray *)timeArr {
//    _timeArr = timeArr;
//    [self.tableView reloadData];
//
//
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.content.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourslModel *model = self.content[indexPath.row];
    if (model.is_buy == 1) {
        return 135;
    }
    return 162.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView registerNib:[UINib nibWithNibName:@"SaleListCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row]];

    SaleListCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",indexPath.row] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.courseModel = self.content[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    if (self.BlockClick) {
        self.BlockClick(self.content[indexPath.row]);
    }
}


- (IBAction)moreAction:(UIButton *)sender {
    MoreSaleVC *more = [[MoreSaleVC alloc] init];
    
    [self.viewController.navigationController pushViewController:more animated:YES];
    
}
@end

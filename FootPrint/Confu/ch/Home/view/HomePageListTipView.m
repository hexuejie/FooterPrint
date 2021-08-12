//
//  HomePageListTipView.m
//  FootPrint
//
//  Created by 何学杰 on 2021/8/12.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "HomePageListTipView.h"
#import "UIView+add.h"

@interface HomePageListTipViewTableViewCell : UITableViewCell
//@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *conditionNameLb;

//@property (nonatomic, strong) UIImageView *intoImageView;
//@property (nonatomic, strong) UIImageView *leftImageView;
@end

@implementation HomePageListTipViewTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self steup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self steup];
    }
    return self;
}

- (void)steup{
//    self.backgroundColor = [UIColor clearColor];
    
//    _leftImageView = [UIImageView new];
//    _leftImageView.image = [UIImage imageNamed:@"PaperExtraList_tags"];
//    [self.contentView addSubview:_leftImageView];
//    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(14);
//        make.centerY.mas_equalTo(0);
//    }];
//
//    _intoImageView = [UIImageView new];
//    _intoImageView.image = [UIImage imageNamed:@"PaperExtraList_into"];
//    [self.contentView addSubview:_intoImageView];
//    [_intoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-14);
//        make.centerY.mas_equalTo(0);
//    }];
    
    _conditionNameLb = [UILabel new];
    _conditionNameLb.textColor = UIColorFromRGB(0x222222);
    _conditionNameLb.font = [UIFont systemFontOfSize:14];
    _conditionNameLb.textAlignment = NSTextAlignmentCenter;
    _conditionNameLb.numberOfLines = 0;
    [self.contentView addSubview:_conditionNameLb];
    [_conditionNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-0);
//            make.top.equalTo(self.contentView).offset(25);
        make.centerY.mas_equalTo(0);
    }];
    
//    _lineView = [UIView new];
//    _lineView.backgroundColor = UIColorFromRGB(0xf1f1f1);
//    [self.contentView addSubview:_lineView];
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//        make.top.mas_equalTo(63);
//    }];
}
@end




@implementation HomePageListTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.listBgView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.listBgView];
//        self.listBgView.backgroundColor = [UIColor whiteColor];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.tableView];
        [self.tableView registerClass:[HomePageListTipViewTableViewCell class] forCellReuseIdentifier:@"HomePageListTipViewTableViewCell"];
       
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.bounces = NO;
        self.tableView.userInteractionEnabled = YES;
        self.tableView.allowsSelection = YES;
        
        UITapGestureRecognizer *taptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closebgClick)];
        [self.listBgView addGestureRecognizer:taptap];
        self.listBgView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)closebgClick{
    [self removeFromSuperview];
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-18);
        make.top.mas_equalTo(KNavAndStatusHight+40);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(_dataArray.count*40+5);
    }];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.listBgView);
//    }];
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView setCornerRadius:4.0 withShadow:YES withShadowRadius:3.0 withOpacity:0.5 withAlpha:0.8 withCGSize:CGSizeMake(1, 1)];
    });
}
//@{@"id":@"-1",@"cate_name":@"首页"}];
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageListTipViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageListTipViewTableViewCell" forIndexPath:indexPath];
    
    cell.conditionNameLb.text = _dataArray[indexPath.row][@"cate_name"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.BlockItemClick) {
        self.BlockItemClick(indexPath.row);
    }
    [self closebgClick];
}
@end

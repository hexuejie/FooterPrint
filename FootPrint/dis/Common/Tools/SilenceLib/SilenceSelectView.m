//
//  SilenceSelectView.m
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 15/12/12.
//  Copyright © 2015年 陈小卫. All rights reserved.
//

#import "SilenceSelectView.h"

//get the left top origin's x,y of a view
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//get the width size of the view:width,height
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)
@interface SilenceSelectView()
@property(assign,nonatomic) SilenceSelectViewPosition currentPosition;//当前位置类型
@property(strong,nonatomic) UIButton *ok;
@end

@implementation SilenceSelectView

-(instancetype)init{
    return [self initWithPosition:SilenceSelectViewPositionBottom];
}

-(instancetype)initWithPosition:(SilenceSelectViewPosition)silenceSelectViewPosition{
    self = [super init];
    if (self) {
        self.currentPosition = silenceSelectViewPosition;
        self.backgroundColor = RGBA(10, 10, 10, 0.6); // 设置遮罩
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.tipString = @"请选择";
        switch (silenceSelectViewPosition) {
            case SilenceSelectViewPositionBottom:
                [self createBottomType];
                break;
            case SilenceSelectViewPositionCenter:
                [self createCenterType];
                break;
            default:
                break;
        }
        
    }
    return self;
}

#pragma mark - 创建选择器
/**
 *  创建底部选择类型
 */
-(void)createBottomType{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake( 0, SCREEN_HEIGHT - 260, SCREEN_WIDTH, 260)];
    //创建picker
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker setTintColor:[UIColor blackColor]];
    [bottomView addSubview:self.picker];
    //创建picker头部
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    topView.backgroundColor = RGBA(0,150,255, 1.0);
    // 创建按钮
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancel];
    self.ok = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 44)];
    [self.ok setTitle:@"确定" forState:UIControlStateNormal];
    [self.ok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ok addTarget:self action:@selector(clickOk:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.ok];
    //创建中间标题
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 160, 44)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [UIColor whiteColor];
    [topView addSubview:self.title];
    [bottomView addSubview:topView];
    [self addSubview:bottomView];
}
/**
 *  创建中间选择类型
 */
-(void)createCenterType{
    //创建picker
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH - 32, 172)];
    CGPoint point = self.center;
    point.y += 44;
    self.picker.center = point;
    self.picker.backgroundColor = [UIColor whiteColor];
    [self.picker setTintColor:[UIColor blackColor]];
    [self addSubview:self.picker];
    //创建picker头部
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_TX(self.picker), VIEW_TY(self.picker) - 44, VIEW_W(self.picker), 44)];
    topView.backgroundColor = RGBA(0,150,255, 1.0);
    // 创建按钮
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancel];
    self.ok = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_W(topView) - 80, 0, 80, 44)];
    [self.ok setTitle:@"确定" forState:UIControlStateNormal];
    [self.ok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ok addTarget:self action:@selector(clickOk:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.ok];
    //创建中间标题
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, VIEW_W(topView) - 160, 44)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [UIColor whiteColor];
    [topView addSubview:self.title];
    [self addSubview:topView];
}

-(void)setIsMustSelect:(BOOL)isMustSelect{
    _isMustSelect = isMustSelect;
    if (_isMustSelect) {
        self.ok.hidden = YES;
    }
}

#pragma mark - 按钮点击事件
- (void)clickCancel:(id)sender {
    [self fadeOut];
}
- (void)clickOk:(id)sender {
    if (_completionSelect) {
        self.completionSelect(_index - 1);
    }
    [self fadeOut];
}


#pragma mark - pickerView 代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count + 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        return self.tipString;
    }
    return self.dataSource[row - 1];
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.index = row;
    if (row == 0 ) {
        self.title.text = self.tipString;
    }else{
        self.title.text = self.dataSource[row-1];
    }
    
    //判断是否必选
    if (_isMustSelect && row == 0) {
        self.ok.hidden = YES;
    }else{
        self.ok.hidden = NO;
    }
    
}

-(void)setDataSource:(NSArray *)dataSource{
    self.index = 0;
    _dataSource = dataSource;
    self.picker.delegate = self;
    self.picker.dataSource = self;
}


- (void)showWithAnimated:(BOOL)animated;
{
    [self.picker selectRow:self.index inComponent:0 animated:YES];
    if (self.index == 0) {
        self.title.text = self.tipString;
    }else{
        self.title.text = self.dataSource[_index - 1];
    }
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    if (animated) {
        [self fadeIn];
    }
}

-(void)showWithAnimated:(BOOL)animated setSelectedIndex:(NSInteger)index{
    self.index = index + 1;
    //判断是否必选
    if (_isMustSelect && self.index == 0) {
        self.ok.hidden = YES;
    }else{
        self.ok.hidden = NO;
    }
    [self showWithAnimated:animated];
}

#pragma mark - Private Methods
- (void)fadeIn
{
    if (_currentPosition == SilenceSelectViewPositionCenter) { // 中间弹出
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0;
        [UIView animateWithDuration:.35 animations:^{
            self.alpha = 1;
            self.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }else{ // 底部弹出
        self.picker.superview.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
        self.alpha = 0;
        [UIView animateWithDuration:.35 animations:^{
            self.alpha = 1;
            self.picker.superview.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
    
    
}
- (void)fadeOut
{
    if (_currentPosition == SilenceSelectViewPositionCenter) { //中间弹出
        [UIView animateWithDuration:.35 animations:^{
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }else{ // 底部弹出
        [UIView animateWithDuration:.35 animations:^{
            self.picker.superview.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
    
}

@end

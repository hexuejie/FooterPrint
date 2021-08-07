//
//  SilenceSelectView.h
//  SilenceIOS_OC
//
//  Created by 陈小卫 on 15/12/12.
//  Copyright © 2015年 陈小卫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SilenceSelectViewPositionBottom,
    SilenceSelectViewPositionCenter
} SilenceSelectViewPosition;

@interface SilenceSelectView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(strong,nonatomic) NSString *tipString;  // 提示选择的文字
@property (strong, nonatomic) UIPickerView *picker; // 选择器
@property (strong, nonatomic) UILabel *title; // 标题
@property (strong, nonatomic) NSArray *dataSource; //数据源
@property(assign,nonatomic) NSInteger index; //选择的下标
@property(strong,nonatomic) void (^completionSelect)(NSInteger index); //选择的回调
@property(assign,nonatomic) BOOL isMustSelect; //是否必选

-(instancetype)initWithPosition:(SilenceSelectViewPosition)silenceSelectViewPosition;
- (void)showWithAnimated:(BOOL)animated setSelectedIndex:(NSInteger)index; 
- (void)showWithAnimated:(BOOL)animated;

@end

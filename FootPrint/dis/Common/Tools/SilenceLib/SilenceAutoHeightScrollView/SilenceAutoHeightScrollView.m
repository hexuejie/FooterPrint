//
//  SilenceAutoHeightScrollView.m
//  FzShop
//
//  Created by Silence on 2016/11/9.
//  Copyright © 2016年 FzShop. All rights reserved.
//

#import "SilenceAutoHeightScrollView.h"
@interface SilenceAutoHeightScrollView()

@end

@implementation SilenceAutoHeightScrollView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self layoutContentView];
    }
    return self;
}

-(instancetype)initWithChilds:(NSArray<SilenceAutoHeightScrollViewModel *> *)childs configViewBlock:(ConfigViewBlock)configViewBlock{
    self = [super init];
    if (self) {
        self.childs = childs;
        self.configViewBlock = configViewBlock;
        [self layoutContentView];
    }
    return self;
    
}

-(void)layoutContentView{
    self.userInteractionEnabled = YES;
    if (self.contentView == nil) {
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
    }
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.width.equalTo(self);
        make.bottom.mas_equalTo(0);
        
        
//         make.height.mas_equalTo(1000);
    }];
}

-(void)setChilds:(NSArray<SilenceAutoHeightScrollViewModel *> *)childs{
    _childs = childs;
}

-(void)reload{
    [self layoutContentView];
    UIView *lastView = nil;
    for (int i=0; i<self.childs.count; i++) {
        SilenceAutoHeightScrollViewModel *model = self.childs[i];
        UIView *v = nil;
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:model.viewClassName ofType:@"nib"];
        if (![NSString isEmpty:nibPath]) {
            v = [[[NSBundle mainBundle] loadNibNamed:model.viewClassName owner:nil options:nil] lastObject];
        }else{
            Class cls = NSClassFromString(model.viewClassName);
            v = [[cls alloc] init];
        }
        v.tag = i+999;
        
        [self.contentView addSubview:v];
        
        // 设置约束
        // 最后一个视图判断
        if (i+1 == self.childs.count) {
            
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.childs.count == 1) {
                    make.top.mas_equalTo(model.top);
                }else{
                   make.top.mas_equalTo(lastView.mas_bottom).offset(model.top);
                }
                
                make.left.mas_equalTo(model.left);
                make.right.mas_equalTo(model.right);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-model.bottom);
            }];

        }else{
            // 上面是否有视图
            if (lastView != nil) {
                [v mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(model.top);
                    make.left.mas_equalTo(model.left);
                    make.right.mas_equalTo(model.right);
                }];
            }else{
                [v mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(model.top);
                    make.left.mas_equalTo(model.left);
                    make.right.mas_equalTo(model.right);
                }];
            }
        }
        lastView = v;
        if (self.configViewBlock != nil) {
            self.configViewBlock(v,model.viewData,i);
        }
    }
    lastView = nil;
    [self layoutIfNeeded];
    
}


@end

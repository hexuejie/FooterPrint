//
//  TalkfunScoreView.m
//  TalkfunSDKDemo
//
//  Created by 莫瑞权 on 2018/8/15.
//  Copyright © 2018年 Talkfun. All rights reserved.
//

#import "TalkfunScoreView.h"


@interface TalkfunScoreView()
@property(strong,nonatomic)NSDictionary *config;
@end
@implementation TalkfunScoreView
//得分配置
- (void)setScoreConfig:(NSDictionary*)config
{
    
    self.config = config;
    
    [self.evaluate setScoreConfig:config];
}
- (BOOL)getIsIpad

{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    
    
    if([deviceType isEqualToString:@"iPhone"]) {
        
        //iPhone
        
        return NO;
        
    }
    
    else if([deviceType isEqualToString:@"iPod touch"]) {
        
        //iPod Touch
        
        return NO;
        
    }
    
    else if([deviceType isEqualToString:@"iPad"]) {
        
        //iPad
        
        return YES;
        
    }
    
    return NO;
    
}

- (evaluateView*)evaluate{
    if(_evaluate==nil){
        _evaluate  = [evaluateView initView];
        
        CGFloat W = 0;
         CGFloat H = 320;
        if (![self getIsIpad]) {
            W  = 280;
            H  = (self.config.count * 40) +216;
        }else{
             W = 300;

//             _evaluate.oneWidth.constant = 200;
            
             H  = (self.config.count * 40) +216;
        }

        if (H <=self.frame.size.height) {
            CGFloat width =  self.frame.size.width;
            CGFloat height = self.frame.size.height;
            
            
            CGFloat Y = (height -H)/2;
            CGFloat X = (width - W)/2;
            _evaluate.frame = CGRectMake(X, Y, W,H );
            self.evaluateFrame = CGRectMake(X, Y, W,H );
        }else{
            CGFloat width =  self.frame.size.width;
            CGFloat height = self.frame.size.height;
            
            
            CGFloat Y = 0 ;
            CGFloat X = (width - W)/2;
            _evaluate.frame = CGRectMake(X, Y, W,height );
            
            //滚动区域
            _evaluate.evaluateFrame = CGRectMake(X, Y, W,H );
            
            self.evaluateFrame = CGRectMake(X, Y, W,H );
        }
      
        [self addSubview: _evaluate];
    }
    return _evaluate;
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    self.backgroundColor= [UIColor clearColor];

        __weak typeof(self) weakSelf = self;
    
        //提交评分时回调
        self.evaluate.currentScoreChangeBlock = ^(NSMutableDictionary* dict){
            
            if(weakSelf.currentScoreChangeBlock){
                weakSelf.currentScoreChangeBlock(dict);
            }
            
        };
    
      //退出
      self.evaluate.exitBlock  = ^(NSDictionary* dict){
        
        if (weakSelf.exitBlock) {
            weakSelf.exitBlock(dict);
        }
        
    };

}

@end

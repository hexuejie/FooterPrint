//
//  evaluateController.m
//  LEEStarRating
//
//  Created by 莫瑞权 on 2018/8/14.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "evaluateView.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]



#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0]
#import "TalkfunLEEStarRating.h"
@interface evaluateView ()<UITextViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UIButton *submitBtn;//

@property (weak, nonatomic) IBOutlet UIView *vc1;


@property (strong, nonatomic) UITextView *textView;

@property(strong,nonatomic)UIScrollView *scrollView;

@property(strong,nonatomic)NSDictionary *config;



@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property(nonatomic,strong)UILabel*  label;

@property(nonatomic,strong)NSMutableDictionary*dict;
@end

@implementation evaluateView
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

static BOOL TimeLabelShow = NO;
+ (id)initView{
    evaluateView * newFunctionView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    TimeLabelShow = NO;
    return newFunctionView;
}
-(NSMutableDictionary*)dict
{
    if (_dict==nil) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}
- (NSInteger)getNumber:(NSObject*)obj
{
    NSString *UsersXid = @"0";
    
    if([obj isKindOfClass:[NSNumber class] ]){
        
        NSNumber  *num     = (NSNumber*) obj;
        NSNumberFormatter *tempNum = [[NSNumberFormatter alloc] init];
        
        UsersXid = [tempNum stringFromNumber:num];
    }else if([obj isKindOfClass:[NSString class] ]){
        
        NSString  *str    = (NSString*)obj;
        UsersXid = str;
    }
    
    return [UsersXid integerValue];
}


- (void)addRatingView:(UIView*)view  fraction:(NSInteger)fraction  key:(NSString*)key{
    TalkfunLEEStarRating *ratingView = [[TalkfunLEEStarRating alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width , view.frame.size.height) Count:5]; //初始化并设置frame和个数

    ratingView.height = view.frame.size.height;
    if ([self getIsIpad]) {
        ratingView.spacing = 16.0f; //间距
    }else{
         ratingView.spacing = 8; //间距
    }
   
    
//    ratingView.checkedImage = [UIImage imageNamed:@"star_orange"]; //选中图片
//
//    ratingView.uncheckedImage = [UIImage imageNamed:@"star_gray"]; //未选中图片
    
        ratingView.checkedImage = [UIImage imageNamed:@"selected"]; //选中图片
    
        ratingView.uncheckedImage = [UIImage imageNamed:@"unselected"]; //未选中图片
    
    
    ratingView.type = RatingTypeWhole; //评分类型
    
    ratingView.touchEnabled = YES; //是否启用点击评分 如果纯为展示则不需要设置
    //
    ratingView.slideEnabled = YES; //是否启用滑动评分 如果纯为展示则不需要设置
    //
    ratingView.maximumScore = fraction; //最大分数
    
    ratingView.minimumScore = 1; //最小分数
    ratingView.key = key;
    [view addSubview:ratingView];

    ratingView.currentScore = fraction;
    
    // 当前分数变更事件回调
    WeakSelf
    ratingView.currentScoreChangeBlock = ^(CGFloat score ,NSString* tag){
        
        [weakSelf.dict setObject:@((NSInteger)score) forKey:tag];//内容评分
  
    };
    
  
    
}
- (IBAction)exit:(UIButton *)sender {

    if (self.exitBlock) {
        self.exitBlock(@{});
    }
}


//提交
- (void)submit:(UIButton *)sender {
    
    if (self.currentScoreChangeBlock) {
        [self.dict setObject:self.textView.text?self.textView.text:@"" forKey:@"msg"];
        self.currentScoreChangeBlock(self.dict);
    }

}
- (void) textViewDidChange:(UITextView *)textView{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([textView.text length] == 0) {
            [self.label setHidden:NO];
        }else{
            [self.label setHidden:YES];
        }
        
    });
  
}

/**
 对字典(Key-Value)排序 区分大小写
 
 @param dict 要排序的字典
 */
- (NSMutableArray*)sortedDictionary:(NSDictionary *)dict{
    

    // 2.1如何获取字典中key和value的个数, 在字典中key称之为键, value称之为值
    NSMutableArray *allKeyArray  = [NSMutableArray array];
    for (int i = 0; i < dict.count; ++i) {
        //  获取字典中所有的key
        NSArray *keys = [dict allKeys];
        //  取出当前位置对应的key
        
        NSString *key = keys[i];
        NSDictionary *value = dict[key];
        
         NSInteger sort = [self getNumber:value[@"sort"]];
        
        [allKeyArray addObject:[NSString stringWithFormat:@"%ld",sort]];
//        NSLog(@"key = %@, value = %@", key, value);
    }
    
    
    

    
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    
    
    
    //排序好的号
    for (NSString *sortsing in afterSortKeyArray) {
        
      
        
        for (int i = 0; i < dict.count; ++i) {
            //  获取字典中所有的key
            NSArray *keys = [dict allKeys];
            //  取出当前位置对应的key
            
            NSString *key = keys[i];
            NSDictionary *value = dict[key];
            NSString * sort = [NSString stringWithFormat:@"%ld",[self getNumber:value[@"sort"]]] ;
            
            if ([sortsing isEqualToString:sort]) {
                NSMutableDictionary *valueDict = [NSMutableDictionary dictionaryWithDictionary:value];
                [valueDict setObject:key forKey:@"TalkfunKey"];
                
                [valueArray addObject:valueDict];
            }
            
        }
  
        
    }
  NSLog(@"a排序后=========>:%@",valueArray);
    return valueArray;
}
//得分配置
- (void)setScoreConfig:(NSDictionary*)config
{
    self.config = config;
    
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height -30);
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    
    //分页
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    
    
    // 设置内容大小  Y设置为0 了,那么 ,y就不能动了
    self.scrollView.contentSize = CGSizeMake(0 , self.evaluateFrame.size.height - 30);
    
    NSMutableArray *valueArray =[self sortedDictionary:self.config];
    
    CGFloat configY = 30;
    for (int i = 0; i < valueArray.count; ++i) {
    
      NSDictionary *value =  valueArray[i];
   
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            //  取出当前位置对应的key
            NSString *key = value[@"TalkfunKey"];
         
            
            NSString *name =  value[@"name"];
            NSInteger  rate = [self getNumber:value[@"rate"]] ;
            
            
            
            UIView *score = [[UIView alloc]init];
            
            CGFloat scoreW = 160;
            CGFloat scoreX = self.scrollView.frame.size.width - scoreW -30;
            CGFloat scoreH = 40;
            CGFloat scoreY = i* scoreH;
            score.frame = CGRectMake(scoreX, scoreY, scoreW, scoreH);
            [self.scrollView addSubview:score];
            
            
           //生成星星
            [self addRatingView:score fraction:rate key:key];
            
            
            UILabel *label = [[UILabel alloc]init];
            if (name) {
                label.text = [name stringByAppendingString:@":"];
            }
            
            label.font = [UIFont systemFontOfSize:12];
            CGFloat labelX = 30;
            CGFloat labelW = self.frame.size.width - scoreW;
            CGFloat labelH = scoreH;
            CGFloat labelY = scoreY ;
       
            
            label.frame = CGRectMake(labelX, labelY, labelW, labelH);
            [self.scrollView addSubview:label];
            if(i ==self.config.count - 1){
               
                configY =   labelY + labelH;
            }
        }
        
        
    }
    
    UILabel *leaveAmessageText = [[UILabel alloc]init];
    leaveAmessageText.text = @"留言:";
    leaveAmessageText.font = [UIFont systemFontOfSize: 14.0];
    leaveAmessageText.frame = CGRectMake(30, configY, 40, 40);
    [self.scrollView addSubview:leaveAmessageText];
    
    
    
    self.textView = [[UITextView alloc]init];
    self.textView.frame =CGRectMake(30,  CGRectGetMaxY(leaveAmessageText.frame), self.frame.size.width - 60, 80);
    
    [self.scrollView addSubview:self.textView];
    
    
    
    //提交
    self.submitBtn = [[UIButton alloc]init];
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.frame = CGRectMake((self.frame.size.width - 60)/2, CGRectGetMaxY(self.textView.frame) +20, 60,30);
    [self.scrollView addSubview:self.submitBtn];
    [self.submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIColor *color2 =   UIColorFromRGB(97,188,230);
    self.submitBtn.backgroundColor = color2;
    self.submitBtn.imageView.backgroundColor = color2;
    
    UIColor *color =   UIColorFromRGB(194,202,210);
    UIColor *color1 =   UIColorFromRGB(255,255,255);
    UIColor *vc1color =   UIColorFromRGB(240,240,240);
    
    self.vc1.backgroundColor = vc1color;
    
    self.backgroundColor = color1;
    self.layer.cornerRadius = 8;
    
    self.vc1.layer.cornerRadius = 8;
    
    self.layer.borderColor = color.CGColor;
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = color.CGColor;
    self.textView.backgroundColor = color1;
    
    self.submitBtn.layer.cornerRadius = 4;
    

    self.textView.delegate = self;
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(6, 6, 200, 20)];
    self.label.enabled = NO;
    self.label.text = @"想对老师说点什么......";
    self.label.font =  [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor lightGrayColor];
    [self.textView addSubview:self.label];
}
@end

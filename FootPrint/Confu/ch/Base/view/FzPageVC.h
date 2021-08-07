//
//  FzPageVC.h
//  Dy
//
//  Created by 陈小卫 on 16/8/30.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "BaseVC.h"

@interface FzPageVC : BaseVC

@property (weak, nonatomic) IBOutlet UIScrollView *scrollPageView;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic)  UIView *showBackView;

//placeholder_property//
@property (nonatomic, strong) NSArray *imgAry;
//placeholder_property//
- (IBAction)btnSkepClick:(id)sender;
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
//placeholder_method_declare//
@property (nonatomic, strong) void(^finishPageBlock)();
//placeholder_property//
@end

//
//  FzPageVC.m
//  Dy
//
//  Created by 陈小卫 on 16/8/30.
//  Copyright © 2016年 陈小卫. All rights reserved.
//

#import "FzPageVC.h"
#import "ShowView.h"
#import "PrivacyPolicyVC.h"
@interface FzPageVC () <UIScrollViewDelegate>{
    NSInteger currentPage;
}

@end

@implementation FzPageVC
//placeholder_method_impl//

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    self.imgNext.hidden = YES;
    self.btnNext.hidden = YES;
    self.scrollPageView.delegate = self;
    self.pageControl.hidden = true;
    //placeholder_method_call//

    
    [self loadData];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Confirm"] != 1) {
          [self addBackView];
      }
}
//placeholder_method_impl//

- (void)loadData {
    //placeholder_method_call//

    [APPRequest GET:@"/startImg" parameters:nil finished:^(AjaxResult *result) {
             //            启动页
                         
             if (result.code == AjaxResultStateSuccess) {
               
                 self.imgAry = result.data;
                 if (self.imgAry.count == 0 || self.imgAry.count == 1) {
                     self.btnNext.hidden = NO;

                 }
                 
                 else {
                     self.pageControl.hidden = false;

                 }
                 
             } else {
                 self.btnNext.hidden = NO;
             }
        
             
         }];
    
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 审核status
    if (![isAudit isEqualToString:@"no"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_CheckStateChange object:nil];

    }
}

- (void)addBackView {
    self.showBackView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.showBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:_showBackView];
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 260.0)/2.0, (SCREEN_HEIGHT - 300.0)/2.0, 260, 150)];
    vi.layer.cornerRadius = 5;
    vi.backgroundColor = [UIColor whiteColor];
//    vi.center = self.view.center;
    [self.showBackView addSubview:vi];
    ShowView *showView = [[ShowView alloc] initWithFrame:CGRectMake(10, 10, 240, 120)];
    showView.backgroundColor = [UIColor whiteColor];
    WS(weakself)
    showView.eventBlock = ^(int index) {
        NSLog(@"%d",index);
        PrivacyPolicyVC *next = [[PrivacyPolicyVC alloc] init];
               BaseNavViewController *nextNav = [[BaseNavViewController alloc] initWithRootViewController:next];
        next.index = index;
               [weakself presentViewController:nextNav animated:YES completion:nil];

    };
    [showView setContent:@""];
    [vi addSubview:showView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 260, 0.8)];
    v.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    [vi addSubview:v];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 130, 40)];
    [btn setTitle:@"同意" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confimAtcion) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(130, 100, 1, 40)];
    view.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
    [vi addSubview:view];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(131, 100, 130, 40)];
    [btn1 setTitle:@"不同意" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn1];
    
    
}
- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    [UIView commitAnimations];
}
- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}



- (void)confimAtcion {
    [self.showBackView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Confirm"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
//placeholder_method_impl//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//placeholder_method_impl//

-(void) setPageSource{
    //placeholder_method_call//

    for (NSInteger index = 0; index < self.imgAry.count; index++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgAry[index]]];
        kImgViewFix(imgView);
        [self.scrollPageView addSubview:imgView];
    }
}
//placeholder_method_impl//

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    self.btnNext.hidden = currentPage != self.imgAry.count-1;
    
    self.pageControl.currentPage = currentPage;
}

- (IBAction)btnSkepClick:(id)sender {
    if (_finishPageBlock) {
        //placeholder_method_call//

        _finishPageBlock();
    }
}

- (void)setImgAry:(NSArray *)imgAry{
    
    _imgAry = imgAry;
    
    self.pageControl.numberOfPages = imgAry.count;
    self.scrollPageView.contentSize = CGSizeMake(SCREEN_WIDTH * imgAry.count, SCREEN_HEIGHT);
    //placeholder_method_call//

    [self setPageSource];
}

@end

//
//  CourseCardDownViewController.m
//  FootPrint
//
//  Created by 何学杰 on 2021/8/10.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "CourseCardDownViewController.h"
#import "TalkfunPhotoZoom.h"

@interface CourseCardDownViewController ()

@property (nonatomic ,strong) UIButton *downButton;

@property (nonatomic ,strong) TalkfunPhotoZoom *coverImageView;

@end

@implementation CourseCardDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F6);
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 5.0;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x4C999A).CGColor, (__bridge id)UIColorFromRGB(0x476A87).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 38);
    [bgView.layer addSublayer:gradientLayer];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.top.mas_equalTo(15);
        make.trailing.mas_equalTo(-20);
        make.height.mas_equalTo(38);
    }];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_downButton];
    _downButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_downButton setTitle:@"下载至手机" forState:UIControlStateNormal];
    [_downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    
    _coverImageView = [[TalkfunPhotoZoom alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, SCREEN_HEIGHT-55)];
    [self.view addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.top.equalTo(_downButton.mas_bottom).offset(2);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(-0);
    }];
    
    [_coverImageView.imageView sd_setImageWithURL:APP_IMG(self.picURL) placeholderImage:[UIImage imageNamed:@"mydefault"]];
//    [_coverImageView.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img0.baidu.com/it/u=3880452051,3916703059&fm=26&fmt=auto&gp=0.jpg"]  placeholderImage:[UIImage imageNamed:@"mydefault"]];
    
}

- (void)downButtonClick{
    
    UIImageWriteToSavedPhotosAlbum(self.coverImageView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        [KeyWindow showSuccessTip:@"下载成功！"];
    }else{
        [KeyWindow showFailTip:@"下载失败！"];
    }
}

@end

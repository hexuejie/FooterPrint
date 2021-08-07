//
//  EnterpriseDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/1.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "EnterpriseDetailVC.h"
#import "EnterpriseModel.h"
#import "CourseDetailVC.h"

@interface EnterpriseDetailVC ()

@property (nonatomic, strong) EnterpriseModel *model;

@end

@implementation EnterpriseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"企业开通";
    //placeholder_method_call//

    [self loadData];
}
//placeholder_method_impl//

- (void)loadData{
    
    [APPRequest GET:@"/api/app/user/agencyCourseDetail" parameters:@{@"sid":self.sid,@"cid":self.cid} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [EnterpriseModel mj_objectWithKeyValues:result.data[@"course"]];
            
            [self.imgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
            self.lblTitle.text = self.model.title;
            self.lblEnterpriseName.text = result.data[@"agency_name"];
            self.lblCreateTime.text = self.model.create_time;
            self.lblDueTime.text = self.model.expire_time;
            [self.btnPrice setTitle:[NSString stringWithFormat:@"  ¥%@",self.model.price] forState:UIControlStateNormal];
            //    课程类型 0:无类型；1:视频；2:音频
            NSInteger type = [self.model.goods_type integerValue];
            if (type == 1){
                
                [self.btnPrice setImage:[UIImage imageNamed:@"course_video"] forState:UIControlStateNormal];
            }else if (type == 2){
                
                [self.btnPrice setImage:[UIImage imageNamed:@"course_mp3"] forState:UIControlStateNormal];
            }
        }
    }];
    //placeholder_method_call//
}
//placeholder_method_impl//

- (IBAction)btnGoDetailClick:(id)sender {
    
    CourseDetailVC *next = [[CourseDetailVC alloc] init];
    next.goodsType = [self.model.goods_type integerValue];
    next.courseId = self.model.cid;
    //placeholder_method_call//

    [self.navigationController pushViewController:next animated:YES];
}
//placeholder_method_impl//

@end

//
//  OrderDetailVC.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/25.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderModel.h"
#import "NSMutableAttributedString+Attributes.h"
#import "BuyCourseVC.h"
#import "CourseDetailVC.h"
#import "QrCdeView.h"
#import "UIImage+CFQRcode.h"
#import "LiveDetaileVC.h"

@interface OrderDetailVC ()

@property (nonatomic, strong) OrderModel *model;

@property (nonatomic, strong) QrCdeView *qRcodeView;

@end

@implementation OrderDetailVC
//placeholder_method_impl//
- (UIImage *)imageWithColor:(UIColor *)color andUIImageage:(UIImage *)img {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  UIImage *img =  [UIImage imageNamed:@"ic_arrow_blue"];
    self.arrawImgView.image = [self imageWithColor:[UIColor colorWithHex:0x479298] andUIImageage:img];
    self.title = @"订单详情";
    WS(weakself)
    [self.viewSpell addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        if ([weakself.model.is_spell integerValue] == 1) { //拼团
            TogetcherVC *t = [[TogetcherVC alloc] init];
            t.type_id = self.model.type_id;
             t.goodsId = weakself.model.id;
             t.goodsType = @"course";
             t.myCourseTypes = (int)self.goodsType;
             t.t_id = weakself.model.t_id;
             WS(weakself)
             t.BlockBackClick = ^{
                 [weakself loadData];
             };
             [self.navigationController pushViewController:t animated:YES];
//            self.qRcodeView.lblContent.text = @"暂不支持查看拼团\n请保存二维码微信扫码查看哦~";
//            [UIImage qrImageWithString:self.model.link size:155 completion:^(UIImage *image) {
//
//                self.qRcodeView.imgCode.image = image;
//            }];
//
//            [KeyWindow addSubview:self.qRcodeView];
            
            
        }
    }];
    //placeholder_method_call//
    [self.viewHead addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        //    订单类型 usercard会员卡 package套餐 course课程 live直播 question题库
        if ([self.model.order_type isEqualToString:@"usercard"]) { //会员卡
            
            
        }else if ([self.model.order_type isEqualToString:@"package"]) { //套餐
            
            BuyCourseVC *next = [[BuyCourseVC alloc] init];
            next.packId = self.model.type_id;
            [self.navigationController pushViewController:next animated:YES];
        }else if ([self.model.order_type isEqualToString:@"course"]) { //课程
            
            CourseDetailVC *next = [[CourseDetailVC alloc] init];
            next.goodsType = self.goodsType;
            next.courseId = self.model.type_id;
            [self.navigationController pushViewController:next animated:YES];
        }else if ([self.model.order_type isEqualToString:@"live"]) { //直播
            
            LiveDetaileVC *next = [[LiveDetaileVC alloc] init];
            next.liveId = self.model.type_id;
            [self.navigationController pushViewController:next animated:YES];
            
//            self.QRcodeView.lblContent.text = @"暂不支持查看直播\n请保存二维码微信扫码查看哦~";
//            [UIImage qrImageWithString:self.model.link size:155 completion:^(UIImage *image) {
//                
//                self.QRcodeView.imgCode.image = image;
//            }];
//            
//            [KeyWindow addSubview:self.QRcodeView];
        }else if ([self.model.order_type isEqualToString:@"question"]){ //题库
            
            self.qRcodeView.lblContent.text = @"暂不支持查看题库\n请保存二维码微信扫码查看哦~";
            [UIImage qrImageWithString:self.model.link size:155 completion:^(UIImage *image) {
                
                self.qRcodeView.imgCode.image = image;
            }];
            
            [KeyWindow addSubview:self.qRcodeView];
        }
    }];
    
    [self loadData];
}
//placeholder_method_impl//

- (void)loadData{
    //placeholder_method_call//

    [APPRequest GET:@"/myOrderDetail" parameters:@{@"id":self.orderId} finished:^(AjaxResult *result) {
       
        if (result.code == AjaxResultStateSuccess) {
            
            self.model = [OrderModel mj_objectWithKeyValues:result.data];
            [self upDateView];
        }
    }];
}

- (void)upDateView{
    
    self.lblTitle.text = self.model.title;
    [self.btnPrice setTitle:[NSString stringWithFormat:@"¥%@",self.model.pay_price] forState:UIControlStateNormal];
    self.lblOldPrice.hidden = YES;
    
    self.lbl1.text = [NSString stringWithFormat:@"¥ %@",self.model.old_price];
    self.lbl2.text = [NSString stringWithFormat:@"¥ %@",self.model.rebate_deducted];
    self.lbl3.text = [NSString stringWithFormat:@"¥ %@",self.model.coupon_deducted];
    self.lbl4.text = [NSString stringWithFormat:@"¥ %@",self.model.cash_deducted];
    self.lbl5.text = [NSString stringWithFormat:@"¥ %@",self.model.pay_price];
    
    self.lbl6.text = self.model.order_sn;
    self.lbl7.text = self.model.create_time;
    self.lbl8.text = self.model.expire_time;
    
    self.viewDue.hidden = YES;
    self.csViewDueHeight.constant = 0;
    self.viewSpell.hidden = YES;
    self.csViewDueHeight.constant = 0;
    self.imgSpell.hidden = YES;
    self.lblPayStatus.hidden = YES;
    //placeholder_method_call//

    //    订单类型 usercard会员卡 package套餐 course课程 live直播 question题库
    
    if ([self.model.order_type isEqualToString:@"usercard"]) { //会员卡
        
        self.imgView.image = [UIImage imageNamed:@"ic_vip"];
        self.viewDue.hidden = NO;
        self.csViewDueHeight.constant = 45;
    }else{
        
        [self.imgView sd_setImageWithURL:APP_IMG(self.model.banner) placeholderImage:[UIImage imageNamed:@"mydefault"]];
    }
    
    if ([self.model.order_type isEqualToString:@"package"]) { //套餐
        
        self.lblStatus.text = [NSString stringWithFormat:@"包含%@门课程",self.model.course_count];
    }else if ([self.model.order_type isEqualToString:@"course"]) { //课程
        
        self.viewDue.hidden = NO;
        self.csViewDueHeight.constant = 45;
    }else if ([self.model.order_type isEqualToString:@"live"]) { //直播
        
        self.lblStatus.text = self.model.live_title;
    }else if ([self.model.order_type isEqualToString:@"question"]){ //题库
        
        self.lblStatus.text = [NSString stringWithFormat:@"共%@题",self.model.totality];
    }
    if ([self.model.is_spell integerValue] == 1) { //是否为拼团 0不是 1是
        
        [self.btnPrice setTitle:[NSString stringWithFormat:@"¥%@",self.model.old_price] forState:UIControlStateNormal];
        
        self.lblOldPrice.hidden = NO;
        NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.model.price]];
        [oldPrice addMidlineForSubstring:[NSString stringWithFormat:@"¥%@",self.model.price]];
        self.lblOldPrice.attributedText = oldPrice;
        
        self.imgSpell.hidden = NO;
        self.viewSpell.hidden = NO;
        self.csViewSpellHeight.constant = 45;
        if ([self.model.spell_state integerValue] == 1) { //拼团状态 1成功 2拼团中 3拼团失败
            
            self.lblStatus.textColor = RGB(103, 194, 58);
            self.lblStatus.text = @"拼团成功";
            self.viewDue.hidden = NO;
            self.csViewDueHeight.constant = 50;
        }else if ([self.model.spell_state integerValue] == 2) {
            
            self.lblStatus.textColor = RGB(255, 164, 0);
            self.lblStatus.text = @"待成团";
            self.viewDue.hidden = YES;
            self.csViewDueHeight.constant = 0;
        }else if ([self.model.spell_state integerValue] == 3) {
            
            self.lblStatus.textColor = RGB(245, 108, 108);
            self.lblStatus.text = @"拼团失败";
            self.viewDue.hidden = YES;
            self.csViewDueHeight.constant = 0;
            
            if ([self.model.pay_status integerValue] == 3) { //拼团失败退款
        
                //                0未退款 1退款成功
                self.lblPayStatus.hidden = NO;
                self.lblPayStatus.text = [self.model.spell_refund_state integerValue] == 1?@"退款成功":@"退款中";
            }
        }
    }
}
//placeholder_method_impl//

- (QrCdeView *)qRcodeView{
    
    if (_qRcodeView == nil) {
        
        _qRcodeView = [[[NSBundle mainBundle] loadNibNamed:@"QRCodeView" owner:nil options:nil] lastObject];
        //placeholder_method_call//

        _qRcodeView.lblTitle.text = @"温馨提示";
        _qRcodeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    
    return _qRcodeView;
}
//placeholder_method_impl//


@end

//
//  ShareShowView.h
//  FootPrint
//
//  Created by 胡翔 on 2021/5/8.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareShowView : UIView
@property (weak, nonatomic) IBOutlet UILabel *incomeshowLabel;
- (IBAction)clickAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *showBgView;

@end

NS_ASSUME_NONNULL_END

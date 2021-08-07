//
//  ShowView.h
//  MK
//
//  Created by 胡翔 on 2020/5/22.
//  Copyright © 2020 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^EventBlock)(int index);
@interface ShowView : UIView
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,copy)NSString *content;
@property (nonatomic, copy)  EventBlock eventBlock;

@end

NS_ASSUME_NONNULL_END

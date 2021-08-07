//
//  HomeSearchCell.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/11.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSearchCell : UITableViewCell
//placeholder_property//
@property (nonatomic, copy) void (^BlockSearchClick)(void);

- (IBAction)btnSearchClick:(id)sender;
//placeholder_property//
@property (weak, nonatomic) IBOutlet UIView *viewbg;
//placeholder_property//
//placeholder_method_declare//
//placeholder_method_declare//
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

NS_ASSUME_NONNULL_END

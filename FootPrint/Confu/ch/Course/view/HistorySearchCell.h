//
//  HistorySearchCell.h
//  FootPrint
//
//  Created by 胡翔 on 2021/3/17.
//  Copyright © 2021 cscs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistorySearchCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, copy) void (^BlockTapGestion)(NSString *name);
@property (nonatomic, copy) void (^BlockLongPressGestion)(NSString *name);
@property (nonatomic, copy) void (^BlockDeleteClick)(NSString *name);
- (IBAction)deleteAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END

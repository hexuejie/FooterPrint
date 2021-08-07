//
//  HistorySearchCell.m
//  FootPrint
//
//  Created by 胡翔 on 2021/3/17.
//  Copyright © 2021 cscs. All rights reserved.
//

#import "HistorySearchCell.h"

@implementation HistorySearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
        [self.nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)]];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 0.8;
    [self.nameLabel addGestureRecognizer:longPress];
    
    
}
- (void)labelTap:(UITapGestureRecognizer *)tap {
    
    if (self.BlockTapGestion) {
        self.BlockTapGestion(self.nameLabel.text);
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)tap {
    
    if (self.BlockLongPressGestion) {
        self.BlockLongPressGestion(self.nameLabel.text);
    }
}
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.BlockDeleteClick) {
        self.BlockDeleteClick(self.nameLabel.text);
    }
}
@end

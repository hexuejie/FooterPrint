//
//  QRCodeView.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/4/8.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "QrCdeView.h"

@implementation QrCdeView

- (IBAction)btnCloseClick:(id)sender {
    
    [self removeFromSuperview];
    //placeholder_method_call//

}
//placeholder_method_impl//

- (IBAction)btnSaveClick:(id)sender {

    UIImageWriteToSavedPhotosAlbum(self.imgCode.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    //placeholder_method_call//

}
//placeholder_method_impl//

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [KeyWindow showTip:@"保存成功"];
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

@end

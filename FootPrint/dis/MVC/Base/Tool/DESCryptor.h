//
//  DESCryptor.h
//  GZJ
//
//  Created by YyMacBookPro on 2019/5/22.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DESCryptor : NSObject

//加密
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString*)key;
//解密
-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

@end

NS_ASSUME_NONNULL_END

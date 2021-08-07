//
//  SLYDESCryptor.h
//  DESTest
//
//  Created by 余河川 on 14-6-30.
//  Copyright (c) 2014年 余河川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYDESCryptor : NSOperation

- (id)initToEncryptInputData:(NSData *)inputData
                     keyData:(NSData *)keyData
            completionHandle:(void (^)(NSData * outputData, NSError * error))completionHandle;

- (id)initToDecryptInputData:(NSData *)inputData
                     keyData:(NSData *)keyData
            completionHandle:(void (^)(NSData * outputData, NSError * error))completionHandle;

- (id)initToEncryptInputData:(NSData *)inputData keyData:(NSData *)keyData;

- (id)initToDecryptInputData:(NSData *)inputData keyData:(NSData *)keyData;

@property (atomic, copy, readonly) NSData * inputData;

@property (atomic, copy, readonly) NSData * keyData;

@property (atomic, copy, readonly) NSError * error;

@property (atomic, copy, readonly) NSData * outputData;

- (void)setCompletionHandle:(void (^)(NSData * outputData, NSError * error))completionHandle;

@end

extern NSString * kSLYDESCryptorErrorDomain;

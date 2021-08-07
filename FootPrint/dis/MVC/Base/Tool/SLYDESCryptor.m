//
//  SLYDESCryptor.m
//  DESTest
//
//  Created by 余河川 on 14-6-30.
//  Copyright (c) 2014年 余河川. All rights reserved.
//

#import "SLYDESCryptor.h"

#include <CommonCrypto/CommonCrypto.h>

@interface SLYDESCryptor ()

@property (atomic, assign, readonly) CCOperation   op;

// read/write versions of public properties

@property (atomic, copy) NSError *     error;
@property (atomic, copy) NSData *      outputData;
@property (atomic, copy) void(^completionHandle)(NSData * outputData, NSError * error);

@end

@implementation SLYDESCryptor

- (id)initWithOp:(CCOperation)op inputData:(NSData *)inputData keyData:(NSData *)keyData completionHandle:(void (^)(NSData *, NSError *))completionHandle
{
    NSParameterAssert(inputData != nil);
    NSParameterAssert(keyData != nil);
    self = [super init];
    if (self != nil) {
        self->_op = op;
        self->_inputData = [inputData copy];
        self->_keyData = [keyData copy];
        self.completionHandle = completionHandle;
    }
    return self;
}

- (id)initToDecryptInputData:(NSData *)inputData keyData:(NSData *)keyData
{
    return [self initToDecryptInputData:inputData keyData:keyData completionHandle:nil];
}

- (id)initToEncryptInputData:(NSData *)inputData keyData:(NSData *)keyData
{
    return [self initToEncryptInputData:inputData keyData:keyData completionHandle:nil];
}

- (id)initToEncryptInputData:(NSData *)inputData keyData:(NSData *)keyData completionHandle:(void (^)(NSData *, NSError *))completionHandle
{
    return [self initWithOp:kCCEncrypt inputData:inputData keyData:keyData completionHandle:completionHandle];
}

- (id)initToDecryptInputData:(NSData *)inputData keyData:(NSData *)keyData completionHandle:(void (^)(NSData *, NSError *))completionHandle
{
    return [self initWithOp:kCCDecrypt inputData:inputData keyData:keyData completionHandle:completionHandle];
}

- (void)main{
    
    CCCryptorStatus     err;
    NSUInteger          keyDataLength;
    NSMutableData *     result;
    size_t              resultLength = 0;
    
    err = kCCSuccess;
    keyDataLength = [self.keyData length];
    if (keyDataLength != kCCKeySizeDES) {
        err = kCCParamError;
    }
    if (err == kCCSuccess) {
        result = [[NSMutableData alloc] initWithLength:([self.inputData length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1)];
        
        err = CCCrypt(
                      self.op,
                      kCCAlgorithmDES,
                      kCCOptionECBMode | kCCOptionPKCS7Padding,
                      [self.keyData bytes],   [self.keyData length],
                      NULL,
                      [self.inputData bytes], [self.inputData length],
                      [result mutableBytes],  [result length],
                      &resultLength
                      );
    }
    if (err == kCCSuccess) {
        self.outputData = result;
    } else {
        self.error = [NSError errorWithDomain:kSLYDESCryptorErrorDomain code:err userInfo:nil];
    }
    if (_completionHandle) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _completionHandle(self.outputData, self.error);
        });
    }
}

@end

NSString * kSLYDESCryptorErrorDomain = @"kSLYDESCryptorErrorDomain";

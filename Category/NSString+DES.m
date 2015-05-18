//
//  NSString+DES.m
//  YHOUSE
//
//  Created by FENG on 14-2-12.
//  Copyright (c) 2014年 FENG. All rights reserved.
//

#import "NSString+DES.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (DES)

static Byte iv[] = {1,2,3,4,5,6,7,8};

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    
     NSString *ciphertext = nil;
    
     const char *textBytes = [plainText UTF8String];
    
     NSUInteger dataLength = [plainText length];
    
     unsigned char buffer[1024];
    
     memset(buffer, 0, sizeof(char));
    
     size_t numBytesEncrypted = 0;
    
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                           kCCOptionPKCS7Padding,
                                           [key UTF8String], kCCKeySizeDES,
                                           iv,
                                           textBytes, dataLength,
                                           buffer, 1024,
                                           &numBytesEncrypted);
    
     if (cryptStatus == kCCSuccess) {
        
         NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
         ciphertext = [data base64Encoding];
        
     }
     return ciphertext;
}

@end

//
//  NSString+DES.h
//  YHOUSE
//
//  Created by FENG on 14-2-12.
//  Copyright (c) 2014年 FENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

@end

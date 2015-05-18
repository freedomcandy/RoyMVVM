//
//  BaseViewModel_OC.m
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/15.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import "BaseViewModel_OC.h"

@implementation BaseViewModel_OC

//KVO Test
- (void)test
{
    [self addObserverForKeyPath:@"test" owner:self block:^(id observed, NSDictionary *change) {
    }];
}

@end

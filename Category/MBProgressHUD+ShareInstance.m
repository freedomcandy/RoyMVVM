//
//  MBProgressHUD+ShareInstance.m
//  YHOUSE
//
//  Created by FENG on 15/4/3.
//  Copyright (c) 2015年 FENG. All rights reserved.
//

#import "MBProgressHUD+ShareInstance.h"

@implementation MBProgressHUD (ShareInstance)

static MBProgressHUD *HUD;

+(MBProgressHUD *)shareHUD
{
    if (HUD) {
        return HUD;
    }
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    
    [RoyAppDelegate.window addSubview:HUD];
    return HUD;
}

-(void)dismiss
{
    HUD.hidden = YES;
}

-(void)show
{
    [HUD show:YES];
    HUD.hidden = NO;
}

@end

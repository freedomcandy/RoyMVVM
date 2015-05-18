//
//  MBProgressHUD+ShareInstance.h
//  YHOUSE
//
//  Created by FENG on 15/4/3.
//  Copyright (c) 2015年 FENG. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ShareInstance)

+(MBProgressHUD *)shareHUD;

-(void)show;
-(void)dismiss;

@end

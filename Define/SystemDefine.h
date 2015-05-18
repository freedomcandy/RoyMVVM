//
//  SystemDefine.h
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/18.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#ifndef RoyMVVM_SystemDefine_h
#define RoyMVVM_SystemDefine_h

//获取AppDelegate
#define RoyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
//字符串去左右空格
#define DROP_WHITESPACE(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
//获取设备系统
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断是不是iOS7以上
#define UP_IOS7 (SYSTEM_VERSION >= 7.0 ? YES : NO)
//获取设备的实际宽度
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
//获取设备的实际高度
#define DEVICE_HEIGHT (UP_IOS7 ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.height - 20)
//16进制取色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif

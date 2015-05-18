//
//  Util.h
//  LocalCache
//
//  Created by tan on 13-2-6.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSMutableArray *)getAsArray:(id)object;
+ (UIViewController *)getControllerOfNavWithControllerName:(NSString *)controllerName;
+ (void)alertWithMessage:(NSString *)message;

+ (void)ViewAlpha2Animation:(UIView*)view ID:(NSString*)id Context:(void*)context Target:(id)target FinishSelector:(SEL)finishSelector;
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size;
+ (UIImage *)image: (UIImage *) image toSize: (CGSize) size;

+(BOOL)passwordAuthenticationWithpassword:(NSString *)password;
+ (NSString *)phoneNumChangeWihtPhoneNum:(NSString *)_phoneNum;
+ (BOOL)phoneNumAuthenticationWithString:(NSString *)string;
+ (BOOL)isEmailWithInfo:(NSString *)_info;

//偏移量转换成时间
+ (NSString *)time:(time_t)dateTime;

+ (NSString *)getNow;

//两个时间之差
+ (long)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
//一个时间距现在的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (NSString *) md5: (NSString *) inPutText;

+ (CGSize)getSizeWithSize:(CGSize)size;

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath;
//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath;

// Duplicate UIView
+ (UIView*)duplicate:(UIView*)view;

//输出系统字体
+ (void)logFontName;

//数据转字符串
+ (NSString*)DataTOjsonString:(id)object;

//url参数转字典
+ (NSDictionary *)urlParaToDicWithUrlPath:(NSString *)urlPath;

+ (NSString *)deviceIPAdress;


@end

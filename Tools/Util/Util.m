//
//  Util.m
//  LocalCache
//
//  Created by tan on 13-2-6.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


@implementation Util

+ (NSMutableArray *)getAsArray:(id)object
{
    NSMutableArray *myArray = [NSMutableArray array];
    if([object isKindOfClass:[NSDictionary class]])    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:[object allValues] forKeys:[object allKeys]];
        [myArray addObject:dic];
        return myArray;
    }
    else if([object isKindOfClass:[NSArray class]]){
        return [NSMutableArray arrayWithArray:object];
    }
    return myArray;
}

+ (UIViewController *)getControllerOfNavWithControllerName:(NSString *)controllerName
{
    UIViewController *controller = nil;
    
//    for (UIViewController *vc in MyAppDelegate.mainNav.viewControllers)
//    {
//        if ([vc isKindOfClass:NSClassFromString(controllerName)]) {
//            controller = vc;
//            break;
//        }
//    }
    return controller;
}

+(void)alertWithMessage:(NSString *)message
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
}

+(void)ViewAlpha2Animation:(UIView*)view ID:(NSString*)id Context:(void*)context Target:(id)target FinishSelector:(SEL)finishSelector
{
    [UIView beginAnimations:id context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    if (target)
    {
        [UIView setAnimationDelegate:target];
        [UIView setAnimationDidStopSelector:finishSelector];
    }
    if(view.alpha ==0.0)
        view.alpha = 1.0;
    else
        view.alpha =0.0;
    [UIView commitAnimations];
}

+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    float sc = image.size.width / image.size.height;
    float height = 320 / sc;
    CGSize imageSize = CGSizeMake(320, height);
    
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)image: (UIImage *) image toSize: (CGSize) size
{
    CGSize origImageSize= [image size];
    
    CGRect newRect;
    newRect.origin= CGPointZero;
    //拉伸到多大
    //    newRect.size.width=80;
    //    newRect.size.height=80;
    newRect.size = size;
    
    //缩放倍数
    float ratio = MIN(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    
    UIGraphicsBeginImageContext(newRect.size);
    
    CGRect projectRect;
    projectRect.size.width =ratio * origImageSize.width;
    projectRect.size.height=ratio * origImageSize.height;
    projectRect.origin.x= (newRect.size.width -projectRect.size.width)/2.0;
    projectRect.origin.y= (newRect.size.height-projectRect.size.height)/2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return small;
}

+(BOOL)passwordAuthenticationWithpassword:(NSString *)password
{
    //密码由6-16位数字、字母或字符组成，字符可使用-或_
    NSString *phoneRegex = @"^[a-zA-Z0-9_-]{6,16}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:password];
}

+(NSString *)phoneNumChangeWihtPhoneNum:(NSString *)_phoneNum
{
    NSMutableString *newPhone = [NSMutableString stringWithString:DROP_WHITESPACE(_phoneNum)];
    newPhone = [NSMutableString stringWithString:[[newPhone componentsSeparatedByString:@"-"] componentsJoinedByString:@""]];
    newPhone = [NSMutableString stringWithString:[[newPhone componentsSeparatedByString:@" "] componentsJoinedByString:@""]];
    return newPhone;
}

+(BOOL)phoneNumAuthenticationWithString:(NSString *)string
{
    NSString *phone = [Util phoneNumChangeWihtPhoneNum:string];
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:phone];
}

+ (BOOL)isEmailWithInfo:(NSString *)_info
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:_info];
}

//偏移量转换成时间
+ (NSString *)time:(time_t)dateTime
{
    NSString *stringFormat = @"%Y-%m-%d %H:%M:%S";
    
    char buffer[80];
    const char *format = [stringFormat UTF8String];
    struct tm * timeinfo;
    timeinfo = localtime(&dateTime);
    strftime(buffer, 80, format, timeinfo);
    
    return [NSString  stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

time_t convertTimeStamp(NSString *stringTime)
{
    time_t createdAt;
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        createdAt = mktime(&created);
    }
    return createdAt;
}

+ (NSString *)getNow
{
    NSDate* date = [NSDate date];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    
    NSString* str = [formatter stringFromDate:date];
    
    return str;
}

//两个时间之差
+ (long)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1 = [formatter dateFromString:dateString1];
    NSDate *date2 = [formatter dateFromString:dateString2];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    long sec = [d hour]*3600+[d minute]*60+[d second];
    
    return sec;
}


//一个时间距现在的时间
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
//    NSString *timeString=@"";
    
    NSTimeInterval cha = fabs(late-now);
    
//    if (cha/3600<1) {
//        timeString = [NSString stringWithFormat:@"%f", cha/60];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@分", timeString];
//        
//    }
//    if (cha/3600>1&&cha/86400<1) {
//        timeString = [NSString stringWithFormat:@"%f", cha/3600];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@小时", timeString];
//    }
//    if (cha/86400>1)
//    {
//        timeString = [NSString stringWithFormat:@"%f", cha/86400];
//        timeString = [timeString substringToIndex:timeString.length-7];
//        timeString=[NSString stringWithFormat:@"剩余%@天", timeString];
//        
//    }
    return [NSString stringWithFormat:@"%f", cha/86400];
}

+(NSString *) md5: (NSString *) inPutText
{
    if (!inPutText) {
        return inPutText;
    }
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (int)strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}

+ (CGSize)getSizeWithSize:(CGSize)size
{
    CGSize boundsSize = CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
    
    CGSize resSize = CGSizeZero;
    
    resSize.width = (boundsSize.width/size.width)/size.height;
    resSize.height = (size.height/size.width)/resSize.width;
    
    return resSize;
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [Util fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

// Duplicate UIView
+ (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

//输出系统字体
+ (void)logFontName
{
    for(NSString *familyName in [UIFont familyNames]){
        NSLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
        
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]){
            NSLog(@"\t%@",fontName);         //*输出字体族科下字样名字
        }
    }
}

//数据转字符串
+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary *)urlParaToDicWithUrlPath:(NSString *)urlPath
{
    CC_LOG_VALUE([urlPath rangeOfString:@"://"]);
    NSInteger location = [urlPath rangeOfString:@"://"].location + [urlPath rangeOfString:@"://"].length;
    NSString *para = [urlPath substringFromIndex:location];
    
    NSArray *arr = [para componentsSeparatedByString:@"&"];
    NSArray *temp = nil;
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    
    for (NSString *item in arr)
    {
        temp = [item componentsSeparatedByString:@"="];
        
        [resultDic setObject:[temp[1] stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy] forKey:temp[0]];
    }
    return resultDic;
}

+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    //    DDLogVerbose(@"手机的IP是：%@", address);
    return address;
}

@end

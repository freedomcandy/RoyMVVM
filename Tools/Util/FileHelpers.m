//
//  FileHelpers.m
//  AAPinChe
//
//  Created by Reese on 13-1-17.
//  Copyright (c) 2013年 Himalayas Technology&Science Company CO.,YHOUSE. All rights reserved.
//

#import "FileHelpers.h"


NSString *pathInDocumentDirectory(NSString *fileName){
    
    //获取沙盒中的文档目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}


NSString *pathInCacheDirectory(NSString *fileName){
    //获取沙盒中缓存文件目录
    NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    
    //将传入的文件名加在目录路径后面并返回
    return [cacheDirectory stringByAppendingPathComponent:fileName];
}


//根据URL的hash码为图片文件命名
NSString *pathForURL(NSURL *aURL){
    return pathInCacheDirectory([NSString stringWithFormat:@"com.hackemist.SDWebImageCache.default/%@", [Util md5:[aURL description]]]);
}

//根据字符串为图片文件命名
NSString *pathForString(NSString *string){
    return pathInCacheDirectory([NSString stringWithFormat:@"com.hackemist.SDWebImageCache.default/%@", string]);
}

//判断是否已经缓存过这个URL
BOOL hasCachedImage(NSURL *aURL){
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
        
    if ([fileManager fileExistsAtPath:pathForURL(aURL)]) {
        return YES;
    }
    else return NO;
    
}

NSString *hashCodeForURL(NSURL *aURL)
{
    return [NSString stringWithFormat:@"%ld",(long)[[aURL description]hash]];
}

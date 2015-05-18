//
//  HTTPHelper.m
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/18.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import "HTTPHelper.h"


static HTTPHelper *httpHelper;

@implementation HTTPHelper

+ (HTTPHelper *)shareInstance
{
    
    if (httpHelper == nil) {
        static dispatch_once_t onceGCD;
        dispatch_once(&onceGCD, ^{
            httpHelper = [[HTTPHelper alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
            httpHelper.requestSerializer  = [AFHTTPRequestSerializer serializer];
            httpHelper.responseSerializer = [AFHTTPResponseSerializer serializer];
            [httpHelper.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [httpHelper.requestSerializer setValue:@"v1.0" forHTTPHeaderField:@"Client-Versoin"];
            httpHelper.requestSerializer.timeoutInterval = 15;
        });
    }
    
  
    return httpHelper;
}



//所有接口增加参数
+ (NSString *)addParametersWithUrlString:(NSString *)urlString
{
    time_t t = time(0);
    
    NSMutableString *para = [NSMutableString string];
    [para appendString:urlString];
    
    if ([urlString rangeOfString:@"?"].location == NSNotFound) {
        [para appendString:@"?"];
    }else{
        [para appendString:@"&"];
    }
    [para appendFormat:@"app_type=%@",@"2"];
//    [para appendFormat:@"&app_user_id=%@",[User shareUser]?[User shareUser].userID:@""];
//    [para appendFormat:@"&app_key=%@",MyAppDelegate.currentDeviceToken?MyAppDelegate.currentDeviceToken:@""];
//    NSString *string = [NSString encryptUseDES:[NSString stringWithFormat:@"%ld",t] key:DESKeyString];
//    [para appendFormat:@"&app_token=%@%@",@"740D3687814B02154E948FE29CC0E792",[string stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]];
    
    return para;
}



//请求成功处理
+ (void)requestSuccess:(id)responseObject operation:(AFHTTPRequestOperation *)operation finishHandle:(successBlock)finishHandle
{
    if (!responseObject) {
        finishHandle(nil);
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id resData =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            finishHandle(resData);
        });
    });
}

////过滤500错误提示接口集合
//+ (NSArray *)requestErrorFilters
//{
////    return @[@{@"path":kregcode , @"code":@[@6]}];
//}
//
//+ (BOOL)isFilterWithOperation:(AFHTTPRequestOperation *)operation code:(NSNumber *)code
//{
//    NSArray *filters = [self requestErrorFilters];
//    NSString *url = operation.request.URL.absoluteString;
//    
//    for (int i = 0; i < [filters count]; i++) {
//        if ([url rangeOfString:filters[i][@"path"]].location != NSNotFound && [filters[i][@"code"] containsObject:code]) {
//            return NO;
//        }
//    }
//    
//    return YES;
//}

//请求错误处理
+ (void)requestError:(NSError *)error operation:(AFHTTPRequestOperation *)operation failHandle:(failureBlock)failHandle
{
    if ([error.localizedDescription hasSuffix:@"(500)"]) {
        NSDictionary *resData =  [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"]
                                                                 options:NSJSONReadingMutableContainers error:nil];
        CC_LOG_VALUE(resData);
        
        if (resData[@"message"] && [resData[@"code"] intValue] != 1) {
//            iToast *itoast = [iToast makeText:resData[@"message"]];
//            [itoast setGravity:iToastGravityCenter];
//            [itoast show];
        }
        
        failHandle(resData);
        
    }else if ([error.localizedDescription hasSuffix:@"(410)"]) {
        NSDictionary *resData =  [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"]
                                                                 options:NSJSONReadingMutableContainers error:nil];
        CC_LOG_VALUE(resData);
        
        if (resData[@"message"]) {
            
//            iToast *itoast = [iToast makeText:resData[@"message"]];
//            [itoast setGravity:iToastGravityCenter];
//            [itoast show];
        }
        
        
        failHandle(resData);
        
    }else if(error.code == kCFURLErrorNotConnectedToInternet || error.code ==  kCFURLErrorCannotConnectToHost)
    {
//        iToast *itoast = [iToast makeText:@"网络中断!"];
//        [itoast setGravity:iToastGravityCenter];
//        [itoast show];
        
        failHandle(nil);
    }else if (error.code == kCFURLErrorTimedOut)
    {
//        iToast *itoast = [iToast makeText:@"请求超时!"];
//        [itoast setGravity:iToastGravityCenter];
//        [itoast show];
        
        failHandle(nil);
    }else
    {
        CC_LOG_VALUE(error);
        
        failHandle(nil);
    }
    
    CC_LOG_VALUE(error.localizedDescription);
}

//请求的url
+ (void)logUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters
{
    NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"%@%@",IPAddress,urlPath];
    for (NSString *key in [parameters allKeys]) {
        [tempUrl appendFormat:@"&%@=%@",key,parameters[key]];
    }
    NSLog(@"requestUrl:%@",tempUrl);
}

//带图片的post请求
+ (AFHTTPRequestOperationManager *)requestPostImageWithParameters:(NSDictionary *)parameters
                                                        urlString:(NSString *)urlString
                                                     finishHandle:(successBlock)finishHandle
                                                       failHandle:(failureBlock)failHandle
{
    AFHTTPRequestOperationManager *manager = [HTTPHelper shareInstance];
    NSString *urlPath = [HTTPHelper addParametersWithUrlString:urlString];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [para removeObjectForKey:@"pics"];
    
    [HTTPHelper logUrlPath:urlPath parameters:parameters];
    
    [manager POST:urlPath parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSArray *keys = [parameters[@"pics"] allKeys];
        
        for (NSString *key in keys)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(parameters[@"pics"][key], 1.0f) name:key fileName:@"file" mimeType:@"image/jpg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HTTPHelper requestSuccess:responseObject operation:operation finishHandle:finishHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HTTPHelper requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

//post请求
+ (AFHTTPRequestOperationManager *)requestPostWithParameters:(NSDictionary *)parameters
                                                   urlString:(NSString *)urlString
                                                finishHandle:(successBlock)finishHandle
                                                  failHandle:(failureBlock)failHandle
{
    AFHTTPRequestOperationManager *manager = [HTTPHelper shareInstance];
    NSString *urlPath = [HTTPHelper addParametersWithUrlString:urlString];
    
    
    [HTTPHelper logUrlPath:urlPath parameters:parameters];
    
    [manager POST:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HTTPHelper requestSuccess:responseObject operation:operation finishHandle:finishHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HTTPHelper requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

//get请求
+ (AFHTTPRequestOperationManager *)requestGetWithParameters:(NSDictionary *)parameters
                                                  urlString:(NSString *)urlString
                                               finishHandle:(successBlock)finishHandle
                                                 failHandle:(failureBlock)failHandle
{
    AFHTTPRequestOperationManager *manager = [HTTPHelper shareInstance];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSString *urlPath = [HTTPHelper addParametersWithUrlString:urlString];
    
    [HTTPHelper logUrlPath:urlPath parameters:parameters];
    
    [manager GET:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HTTPHelper requestSuccess:responseObject operation:operation finishHandle:finishHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HTTPHelper requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

//取消request请求
+ (void)cancelRequestWithPath:(NSString *)path
{
    AFHTTPRequestOperationManager *manager = [HTTPHelper shareInstance];
    
    NSString *twoPath = path;
    twoPath = [twoPath substringToIndex:[twoPath rangeOfString:@"&"].location];
    NSString *onePath;
    
    for (NSOperation *operation in [manager.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        onePath = [[[(AFHTTPRequestOperation *)operation request] URL] absoluteString];
        onePath = [onePath substringToIndex:[onePath rangeOfString:@"&"].location];
        
        if ([onePath isEqual:twoPath]) {
            [operation cancel];
        }
    }
}


#pragma mark - Test
/**
 *	@brief	修改用户名（昵称）的接口
 *
 *  @param  userId：用户ID
 
 username：用户填写的用户名
 *
 *	@return	1; //成功
 
 2; //失败
 
 3; //ID出错
 
 4; //无效的手机或邮箱
 
 5; //错误的验证码
 
 6; //无此用户
 */
+ (void)updataUserNameWithParametersDic:(NSDictionary *)parameterDic
                                success:(void(^)(id result))successBlock
                               failture:(void(^)(id result))failtureBlock
{
    [HTTPHelper requestGetWithParameters:parameterDic
                                   urlString:@"www.baidu.com"
                                finishHandle:^(id result) {
                                    successBlock(result);
                                } failHandle:^(id result) {
                                    failtureBlock(result);
                                }];
}



@end

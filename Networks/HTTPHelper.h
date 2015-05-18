//
//  HTTPHelper.h
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/18.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
/**
 数据以Block形式返回
 **/
typedef void (^successBlock) (id result);
typedef void (^failureBlock) (id result);

@interface HTTPHelper : AFHTTPRequestOperationManager

+ (HTTPHelper *)shareInstance;


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
                                success:(successBlock)successBlock
                               failture:(failureBlock)failtureBlock;



@end

//
//  ApiRequest.h
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACCEPTABLE_CONTENT_TYPES     @"text/plain", @"text/html", @"application/json",nil // 注意此处设置


@interface ApiRequest : NSObject


/**
 *  @author zmy, 15-05-20 14:05:11
 *
 *  请求错误码
 */
typedef NS_ENUM(NSInteger, APIRequrestErrorCode) {
    APIRequestNotJson = 10001,
};

/**
 *  @author zmy, 15-05-20 14:05:02
 *
 *  请求的方法 get 或者 post
 */
typedef NS_ENUM(NSInteger, APIRequestMethod){
    
    APIRequestGetMethod,
    
    APIRequestPostMethod,
};

/**
 *  请求完成的回调
 *
 *  @param success 请求是否成功
 *  @param dict    请求响应的数据
 */
typedef void (^apiRequestCompletionHandler)(BOOL success, NSError *error, NSDictionary  *dict);


/**
 *  Get请求
 *
 *  @param URLString               请求地址
 *  @param parameters        请求参数
 *  @param completionHandler 完成回调
 */
+ (void)requestUseGetMethodWithURLString:(NSString *)URLString
                              parameters: (NSDictionary *)parameters
                       completionHandler:(apiRequestCompletionHandler)apiCompletionHandler;

/**
 *  Post请求
 *
 *  @param URLString               请求地址
 *  @param parameters        请求参数
 *  @param completionHandler 完成回调
 */
+ (void)requestUsePostMethodWithURLString:(NSString *)URLString
                               parameters: (NSDictionary *)parameters
                        completionHandler:(apiRequestCompletionHandler)apiCompletionHandler;



@end









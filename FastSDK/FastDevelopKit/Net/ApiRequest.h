//
//  ApiRequest.h
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiRequest : NSObject


/**
 *  请求完成的回调
 *
 *  @param success 请求是否成功
 *  @param dict    请求响应的数据
 */
typedef void (^requestCompletionHandler)(BOOL success, NSDictionary  *dict);


/**
 *  Get请求
 *
 *  @param url               请求地址
 *  @param parameters        请求参数
 *  @param completionHandler 完成回调
 */
- (void)requestUseGetMethod:(NSString *)url
                 parameters: (NSDictionary *)parameters
          completionHandler:(requestCompletionHandler)completionHandler;

/**
 *  Post请求
 *
 *  @param url               请求地址
 *  @param parameters        请求参数
 *  @param completionHandler 完成回调
 */
- (void)requestUsePostMethod:(NSString *)url
                  parameters: (NSDictionary *)parameters
           completionHandler:(requestCompletionHandler)completionHandler;



@end









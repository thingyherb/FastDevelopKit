//
//  ApiRequest.m
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "ApiRequest.h"
#import <AFNetworking.h>

@implementation ApiRequest

+ (void)requestWithURLString:(NSString *)URLString
                      method:(APIRequestMethod)method
                  parameters:(NSDictionary *)parameters
           completionHandler:(apiRequestCompletionHandler)apiCompletionHandler {
    
    // url encode
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    [(AFHTTPResponseSerializer *)manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:ACCEPTABLE_CONTENT_TYPES]];
    
    NSMutableURLRequest *request = nil;
    
    if (method == APIRequestGetMethod) {
        
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                URLString:URLString
                                                               parameters:parameters
                                                                    error:nil];
        
    } else if (method == APIRequestPostMethod) {
        
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                URLString:URLString
                                                               parameters:parameters
                                                                    error:nil];
    }
    
    request.timeoutInterval = 15;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            apiCompletionHandler(false, error, responseObject);
            
        } else {
            
            apiCompletionHandler(true, error, responseObject);
            
        }
    }];
    
    [dataTask resume];
}


+ (void)requestUseGetMethodWithURLString:(NSString *)URLString
                              parameters:(NSDictionary *)parameters
                       completionHandler:(apiRequestCompletionHandler)apiCompletionHandler {
    
    [self requestWithURLString:URLString
                        method:APIRequestGetMethod
                    parameters:parameters
             completionHandler:apiCompletionHandler];
}


+ (void)requestUsePostMethodWithURLString:(NSString *)URLString
                               parameters:(NSDictionary *)parameters
                        completionHandler:(apiRequestCompletionHandler)apiCompletionHandler {
    
    [self requestWithURLString:URLString
                        method:APIRequestPostMethod
                    parameters:parameters
             completionHandler:apiCompletionHandler];

}





@end






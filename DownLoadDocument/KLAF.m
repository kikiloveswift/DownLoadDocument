//
//  KLAF.m
//  fengyanfengyu
//
//  Created by kong on 16/4/8.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLAF.h"
#import <CFNetwork/CFNetwork.h>

@implementation KLAF

+ (NSURLSessionDataTask *)requestDataWithUrlString:(NSString *)URLString
                                        Parameters:(NSDictionary *)dic
                                            Method:(NSString *)string
                                           Success:(finishSuccessBlock)successBlock
                                          Progress:(progressBlock)progressBlock
                                           Failure:(finishFalureBlock)failureBlock
{
    
    AFHTTPSessionManager *mange = [AFHTTPSessionManager manager];
    
    mange.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    mange.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //TODO: 设置请求头
//    [mange.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    
//    mange.responseSerializer = [AFHTTPResponseSerializer serializer];
    //TODO: 设置请求头
//    [mange.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [mange.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [mange.requestSerializer setValue:kAppUserAgentValue forHTTPHeaderField:@"User-Agent"];
    
    NSURLSessionDataTask *task = nil;
    
    //GET请求
    if ([string isEqualToString:@"GET"]){
        
    task = [mange GET:URLString parameters:dic progress:^(NSProgress * _Nonnull downloadProgress){
        
            if (progressBlock){
                
                progressBlock(downloadProgress);
            }
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            NSDictionary *dic = [KLData dicWithJsonString:responseObject];
            
            if (successBlock){
                
                successBlock(task,dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            if (failureBlock){
                
                failureBlock(task,error);
            }
        }];
        
     //POST请求
    }else if ([string isEqualToString:@"POST"]){
        
    task = [mange POST:URLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
            if (progressBlock){
                
                progressBlock(uploadProgress);
            }
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [KLData dicWithJsonString:responseObject];
            
            if (successBlock){
                
                successBlock(task,dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock){
                
                failureBlock(task,error);
            }
        }];
    }
    return task;
}




@end

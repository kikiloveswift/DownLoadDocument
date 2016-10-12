//
//  KLDownLoad.h
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

//考虑到多线程还是暂时注释掉这行
//typedef void(^CompletionHandler)(NSURLResponse *response, NSURL *filePath, NSError *error);

@interface KLDownLoad : NSObject<NSURLSessionDelegate>
/**
 下载替换并存储文件

 @param urlString url
 @param rules     替换规则字典
 */
+ (void)downLoadWithURL:(NSString *)urlString
            ReplaceRule:(NSDictionary*)rules;

@end

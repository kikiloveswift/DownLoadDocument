//
//  KLDownLoad.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLDownLoad.h"
#import "KLAnalysisData.h"

//替换
#import "AYReplaceOldNewModel.h"

@implementation KLDownLoad

+ (void)downLoadWithURL:(NSString *)urlString
            ReplaceRule:(NSArray *)rules
{
    @synchronized (self)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSFileManager *manager = [NSFileManager defaultManager];
            NSString *localPath = [KLAnalysisData httpPathToLocalPath:response.URL];
            //替换
            if (rules != nil && rules.count > 0)
            {
                NSData *data = [NSData dataWithContentsOfURL:filePath];
//                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
                NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                for (AYReplaceOldNewModel *model in rules)
                {
                    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:model.old withString:model.newone];
                }
                
                NSData *jsonData = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
                
                BOOL resultSuccess = [jsonData writeToFile:localPath atomically:YES];
                if (resultSuccess) {
                    NSLog(@"写入成功");
                    BOOL ret = [manager removeItemAtURL:filePath error:nil];
                    if (ret)
                    {
                        NSLog(@"清除成功");
                    }
                }
                NSLog(@"htmlStr is %@",htmlStr);
                NSLog(@"File downloaded to: %@", filePath);
            }
            else
            {
                //没有替换规则的
//               BOOL ret = [manager moveItemAtURL:filePath toURL:[NSURL URLWithString:localPath] error:nil];
                NSData *data = [NSData dataWithContentsOfURL:filePath];
                BOOL ret = [data writeToFile:localPath atomically:YES];
                if (ret)
                {
                    NSLog(@"成功");
                    BOOL clearRes = [manager removeItemAtURL:filePath error:nil];
                    if (clearRes)
                    {
                        NSLog(@"清除成功");
                    }
                }
            }
        }];
        [downloadTask resume];
    }
}







@end

//
//  KLDownLoad.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLDownLoad.h"

@implementation KLDownLoad

+ (void)downLoadWithURL:(NSString *)urlString
            ReplaceRule:(NSDictionary*)rules
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
            NSData *data = [NSData dataWithContentsOfURL:filePath];
            NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"http://pic3.aoyou.com" withString:@"../../../pic3.aoyou.com"];
            NSData *jsonData = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
            
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* documentsDirectory = [paths objectAtIndex: 0];
            NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: [response suggestedFilename]];
            BOOL resultSuccess = [jsonData writeToFile:documentsPath atomically:YES];
            if (resultSuccess) {
                NSLog(@"成功");
            }
            
            NSLog(@"htmlStr is %@",htmlStr);
            NSLog(@"File downloaded to: %@", filePath);
        }];
        [downloadTask resume];

    }
}



@end

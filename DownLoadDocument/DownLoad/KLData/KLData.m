//
//  KLData.m
//  fengyanfengyu
//
//  Created by kong on 16/4/9.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLData.h"

@implementation KLData

+ (id)dicWithJsonString:(id)jsonString
{
    if ([jsonString isKindOfClass:[NSString class]])
    {
        jsonString = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    id json = [NSJSONSerialization JSONObjectWithData:jsonString options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves error:nil];
    
    return json;
}

+(id)dicJSONWithLocalPathName:(NSString *)pathName
{
    NSString *pathFile = [[NSBundle mainBundle]pathForResource:pathName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:pathFile];
    
    return [KLData dicWithJsonString:data];
    
}

+ (NSString *)stringEncodingWithString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    NSString *str = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return str;
}

+ (NSString *)stringDecodingWithString:(NSString *)string
{
    NSString *str = [string stringByRemovingPercentEncoding];
    
    return str;
}

@end

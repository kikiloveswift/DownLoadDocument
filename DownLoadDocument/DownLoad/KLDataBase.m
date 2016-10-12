//
//  KLDataBase.m
//  DownLoadDocument
//
//  Created by kong on 16/10/12.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "KLDataBase.h"

//File Ver的Model
#import "AYFileModel.h"
#import "AYFileRootModel.h"

@interface KLDataBase()
{
    //装文件的MArr
    NSMutableArray *_fileMArr;
    
    //装替换文件的MArr
    NSMutableArray *_replaceMArr;
}

@end

@implementation KLDataBase


static KLDataBase *_dataBase = nil;

BOOL requestFlag = NO;

+ (instancetype)shareInstance
{
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _dataBase = [[self alloc] init];
            [self setting];
        });
    }
    return _dataBase;
}


+ (void)setting
{
    
}

- (void)requestAYString:(NSString *)string
                  Bulid:(buildThen)bulidBlock
{
    [KLAF requestDataWithUrlString:string Parameters:nil Method:@"GET" Success:^(id operation, id result) {
        if ([result isKindOfClass:[NSDictionary class]])
        {
            if (_fileMArr == nil)
            {
                _fileMArr = [NSMutableArray array];
            }
            if (_replaceMArr == nil)
            {
                _replaceMArr = [NSMutableArray array];
            }
            
            NSLog(@"result is %@",result);
            AYFileRootModel *rootModel = [[AYFileRootModel alloc] initContentWithDic:result];
            NSLog(@"rootModel.updateModel.html is %@", rootModel.updateModel.html);
            [_fileMArr addObject:rootModel];
            
            AYReplaceModel *replaceModel = [[AYReplaceModel alloc] initContentWithDic:result];
            [_replaceMArr addObject:replaceModel];
            
            if (requestFlag == NO)
            {
                if (bulidBlock)
                {
                    bulidBlock();
                    requestFlag = YES;
                }
            }else
            {
               //此时两组Model都装入_fileMArr
                
            }
        }
    } Progress:^(NSProgress *progress) {
        
    } Failure:^(id operation, NSError *error) {
        
    }];
}

//- (void)beginToDownLoadFile:()


@end

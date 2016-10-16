//
//  ViewController.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import "KLDataBase.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testDownLoad];
}
- (void)testDownLoad
{
    [[KLDataBase shareInstance] requestAYString:@"http://m.aoyou.com/version.txt" Bulid:^{
        
        [[KLDataBase shareInstance] requestAYString:@"http://mbook.aoyou.com/version.txt" Bulid:^{
            
        }];
    
    }];
}





@end

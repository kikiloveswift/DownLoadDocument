//
//  ViewController.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testDownLoad];
}
- (void)testDownLoad
{
    [KLDownLoad downLoadWithURL:@"http://m.aoyou.com/s/CustomChannel/Index.html" ReplaceRule:nil];
}





@end

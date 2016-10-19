//
//  ViewController.m
//  DownLoadDocument
//
//  Created by kong on 16/10/11.
//  Copyright © 2016年 konglee. All rights reserved.
//

#import "ViewController.h"
#import "KLDataBase.h"

#import "TouchIDIdentifier.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testDownLoad];
    [self identifyTouchID];
}
- (void)testDownLoad
{
//    [KLDownLoad downLoadWithURL:@"http://webresource1.aoyou.com/css/webapp/msitewebsite/customchannel.css" ReplaceRule:nil];
    [[KLDataBase shareInstance] requestAYString:@"http://m.aoyou.com/version.txt" Bulid:^{
        
        [[KLDataBase shareInstance] requestAYString:@"http://mbook.aoyou.com/version.txt" Bulid:^{
            
        }];
    
    }];
}

- (void)identifyTouchID
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 84, 200, 50);
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"验证TouchID" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
}


- (void)btnAction:(UIButton *)btn{
    [TouchIDIdentifier identifyTouchID];
}





@end

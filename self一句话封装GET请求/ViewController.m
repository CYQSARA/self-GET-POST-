//
//  ViewController.m
//  self一句话封装GET请求
//
//  Created by Cuiyongqin on 16/4/24.
//  Copyright © 2016年 Cuiyongqin. All rights reserved.
//

#import "ViewController.h"
#import "YQGETReuest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     NSString *urlStr = @"http://127.0.0.1/login/login.php";
    NSDictionary *pram = @{@"username":@"哈哈",@"password":@"zhang"};
    
    [[YQGETReuest sharedGETReuest] GETRequestWithURLString:urlStr andHTTPMethod:@"POST" andDict:pram andSuccessBlock:^(NSData *data, NSURLResponse *response) {
           NSLog(@" main:%@",[NSThread currentThread]);
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
    } andFalseBlock:^(NSError *error) {
        
         NSLog(@"%@",error);
        
    }];
   
}

- (void)test {
//    NSString *urlStr = @"http://127.0.0.1/login/login.php?";
//    NSDictionary *pram = @{@"username":@"zhangsan",@"password":@"zhang"};
//    
//    [[YQGETReuest sharedGETReuest] GETRequestWithURLString:urlStr andDict:pram andSuccessBlock:^(NSData *data, NSURLResponse *response) {
//        
//        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//        
//    } andFalseBlock:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];

}

@end




























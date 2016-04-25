//
//  YQGETReuest.m
//  self一句话封装GET请求
//
//  Created by Cuiyongqin on 16/4/24.
//  Copyright © 2016年 Cuiyongqin. All rights reserved.
//

#import "YQGETReuest.h"

@implementation YQGETReuest
    static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedGETReuest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _instance = [[self alloc]init];
    });
    return _instance;
}

- (id)copyWithZone :(NSZone *)zone {
    return _instance;
}

- (void)GETRequestWithURLString:(NSString *)urlString andHTTPMethod:(NSString *)HTTPMethod andDict:(NSDictionary *)parameter andSuccessBlock:(successBlock)successblock andFalseBlock:(falseBlock)falseblock {
    
    NSMutableString *strM = [NSMutableString string];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *userKey = key;
        NSString *pwdValue = obj;
        
        [strM appendFormat:@"%@=%@&",userKey,pwdValue];
        
    }];
    NSString *str = [strM substringToIndex:strM.length-1];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if ([HTTPMethod isEqualToString:@"POST"]) {
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:0 timeoutInterval:15];
        
        request.HTTPMethod = @"POST";
        request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data&&!error) {
                if (successblock) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                          successblock(data,response);
                           NSLog(@"POST:%@",[NSThread currentThread]);
                    });
                    
                }
            }else{
                if (falseblock) {
                    falseblock(error);
                }
            }
            
        }]resume];
        
    }else if ([HTTPMethod isEqualToString:@"GET"]){
        
        NSString *urlStr = [urlString stringByAppendingString:str];
    
        NSURL *url = [NSURL URLWithString:urlStr];
        
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data&&!error) {
                
                if (successblock!=nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successblock(data,response);
                        NSLog(@"GET:%@",[NSThread currentThread]);
                    });
                }
                
            }else{
                if (falseblock!=nil) {
                    falseblock(error);
                }
            }
            
        }] resume];

    }
    
}

- (void)GETRequestWithURLString:(NSString *)urlString andDict:(NSDictionary *)parameter andSuccessBlock:(successBlock)successblock andFalseBlock:(falseBlock)falseblock {
    
    NSMutableString *strM = [NSMutableString string];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        NSString *userKey = key;
        NSString *pwdValue = obj;
        
        [strM appendFormat:@"%@=%@&",userKey,pwdValue];

    }];
         NSString *str = [strM substringToIndex:strM.length-1];
         NSString *urlStr = [urlString stringByAppendingString:str];
    
         NSURL *url = [NSURL URLWithString:urlStr];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data&&!error) {
            
            if (successblock!=nil) {
                successblock(data,response);
            }
            
        }else{
            if (falseblock!=nil) {
                falseblock(error);
            }
        }
        
    }] resume];
    
}

@end















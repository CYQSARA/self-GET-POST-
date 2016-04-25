//
//  YQGETReuest.h
//  self一句话封装GET请求
//
//  Created by Cuiyongqin on 16/4/24.
//  Copyright © 2016年 Cuiyongqin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(NSData *data,NSURLResponse *response) ;
typedef void(^falseBlock)(NSError *error) ;

@interface YQGETReuest : NSObject
+ (instancetype)sharedGETReuest;
- (void)GETRequestWithURLString:(NSString *)urlString andHTTPMethod:(NSString *)HTTPMethod andDict:(NSDictionary *)parameter andSuccessBlock:(successBlock)successblock andFalseBlock:(falseBlock)falseblock;

- (void)GETRequestWithURLString:(NSString *)urlString andDict:(NSDictionary *)parameter andSuccessBlock:(successBlock)successblock andFalseBlock:(falseBlock)falseblock;


@end

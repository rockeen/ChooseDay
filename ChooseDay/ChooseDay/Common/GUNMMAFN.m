

//
//  GUNMMAFN.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GUNMMAFN.h"
#import "AFNetworking.h"


@implementation GUNMMAFN


//获取GET请求
+ (void)getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    

    [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}



@end

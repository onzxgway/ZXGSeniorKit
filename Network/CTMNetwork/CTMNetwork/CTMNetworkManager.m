//
//  CTMNetworkManager.m
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/25.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "CTMNetworkManager.h"
#import "CTMMD5Encrypt.h"
#import "CTMNetworkLocalCache.h"

@interface CTMNetworkManager() {
    dispatch_queue_t _queue;
    CTMNetworkLocalCache *_cache;
}

@end

@implementation CTMNetworkManager

+ (instancetype)manager {
    static CTMNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return  instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[CTMNetworkLocalCache alloc] init];
    }
    return self;
}

- (void)post:(NSString *)URLString
  parameters:(NSDictionary * _Nullable)parameters
 ignoreCache:(BOOL)ignoreCache
cacheDuration:(NSTimeInterval)cacheDuration
completionHandler:(CTMRequestCompletionHandler)completionHandler {
    
}

- (void)method:(NSString *)method
     urlString:(NSString *)URLString
    parameters:(NSDictionary *)parameters
   ignoreCache:(BOOL)ignoreCache
 cacheDuration:(NSTimeInterval)cacheDuration
completionHandler:(CTMRequestCompletionHandler)completionHandler {
    
    // 1 URLString + parameters + method + appversion MD5生成唯一码
    NSString *fileKey = [CTMMD5Encrypt encryptWithURLString:URLString method:method parameters:parameters];
    
    // 2 判断是否存在有效缓存
    if (!ignoreCache && [_cache checkIfShouldUseCache:cacheDuration cacheKey:fileKey]) {
        
    }
    
    // 5 处理网络返回的数据，即缓存处理
    CTMCompletionHandler completionBlock = ^(NSError *error, BOOL isCache, NSDictionary *result) {
        
    };
    
    // 3 发起网络任务
    if ([method isEqualToString:@"GET"]) {
        
        [self.sessionManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            /*
             4 处理数据 （处理数据的时候，需要处理下载的网络数据是否要缓存）
             这里可以直接使用 completionHandler，如果这样，网络返回的数据没有做缓存处理机制
             */
            completionBlock(nil, NO, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            completionBlock(error, NO, nil);
        }];
        
    } else if ([method isEqualToString:@"POST"]) {
        
        [self.sessionManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            completionBlock(nil, NO, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            completionBlock(error, NO, nil);
        }];
        
    }
}

- (AFHTTPSessionManager *)sessionManager {
    return [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
}

@end

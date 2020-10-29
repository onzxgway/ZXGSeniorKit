//
//  CTMNetworkLocalCache.m
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/26.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "CTMNetworkLocalCache.h"

@interface CTMNetworkLocalCache() {
    NSCache          *_memoryCache; // NSCache用来解决频繁从文件系统中读写的 性能问题
    NSString         *_cachePath;
    NSFileManager    *_fileManager;
    dispatch_queue_t _SYIOQueue;
    NSMutableSet     *_protectCaches;
}

@end

@implementation CTMNetworkLocalCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _memoryCache = [[NSCache alloc] init];
    }
    return self;
}

- (BOOL)checkIfShouldUseCache:(NSTimeInterval)cacheDuration
                     cacheKey:(NSString *)cacheKey {
    if (cacheDuration == 0) {
        return NO;
    }
    
    // 处理缓存
    id localCache = [self searchCache:cacheKey];
    if (localCache) {//缓存文件存在
        if ([self expiredWithCacheKey:cacheKey cacheDuration:cacheDuration]) { //判断缓存文件是否过期了
            return NO;
        }
        return YES;
    }
    
    return NO;
}

- (id)searchCache:(NSString *)cacheKey {
    id object = [_memoryCache objectForKey:cacheKey];
    if (!object) {
//        NSString *filePath = [_cachePath stringByAppendingPathComponent:urlkey];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//            [_memoryCache setObject:object forKey:urlkey];
//        }
    }
    return object;
}

- (BOOL)expiredWithCacheKey:(NSString *)cacheFileNamekey cacheDuration:(NSTimeInterval)expirationDuration {
    NSString *filePath = [_cachePath stringByAppendingPathComponent:cacheFileNamekey];
    BOOL fileExist = [_fileManager fileExistsAtPath:filePath];
    if (fileExist) {
        NSTimeInterval fileDuration = [self cacheFileDuration:filePath];
        if (fileDuration > expirationDuration) {
            [_fileManager removeItemAtURL:[NSURL fileURLWithPath:filePath] error:nil];
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;//如果文件不存在 则设置为  过期文件
    }
}

- (NSTimeInterval)cacheFileDuration:(NSString *)path {
    
    NSError *attributesRetrievalError = nil;
    NSDictionary *attributes = [_fileManager attributesOfItemAtPath:path
                                                              error:&attributesRetrievalError];
    if (!attributes) {
        NSLog(@"获取文件属性失败 %@: %@", path, attributesRetrievalError);
        return -1;
    } else {
        NSLog(@"获取文件成功");
    }
    NSTimeInterval seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}

@end

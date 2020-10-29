//
//  CTMNetworkManager.h
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/25.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTMRequest.h"

/**
 优点一：业务层与网络框架层分离，如果网络框架有变更，只需在此文件处理即可，无需业务层变动，层之间的耦合度低。
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface CTMNetworkManager : NSObject

/// <#Description#>
+ (instancetype)manager;

/// POST请求
/// @param URLString url地址
/// @param parameters 请求参数
/// @param ignoreCache 是否忽略缓存，YES 忽略，NO 不忽略
/// @param cacheDuration 缓存时效
/// @param completionHandler 请求结果处理
- (void)post:(NSString *)URLString
  parameters:(NSDictionary * _Nullable)parameters
 ignoreCache:(BOOL)ignoreCache
cacheDuration:(NSTimeInterval)cacheDuration
completionHandler:(CTMRequestCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

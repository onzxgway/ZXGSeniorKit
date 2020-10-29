//
//  CTMNetworkLocalCache.h
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/26.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMNetworkLocalCache : NSObject

- (BOOL)checkIfShouldUseCache:(NSTimeInterval)cacheDuration
                     cacheKey:(NSString *)cacheKey;

@end

NS_ASSUME_NONNULL_END

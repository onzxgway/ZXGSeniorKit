//
//  CTMRequest.h
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/25.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CTMCompletionHandler)(NSError* _Nullable error, BOOL isCache, NSDictionary * _Nullable result);

NS_ASSUME_NONNULL_BEGIN

typedef void (^CTMRequestCompletionHandler)( NSError* _Nullable error,  BOOL isCache, NSDictionary* _Nullable result);

@interface CTMRequest : NSObject

@end

NS_ASSUME_NONNULL_END

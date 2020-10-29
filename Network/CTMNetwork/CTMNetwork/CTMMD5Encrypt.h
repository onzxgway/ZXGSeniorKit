//
//  CTMMD5Encrypt.h
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/26.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMMD5Encrypt : NSObject

+ (NSString *)encryptWithURLString:(NSString *)URLString
                            method:(NSString *)method
                        parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END

//
//  CTMMD5Encrypt.m
//  CTMNetwork
//
//  Created by 朱献国 on 2020/10/26.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "CTMMD5Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

NSString *CTMCacheAppVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

NSString *CTMConvertMD5FromString(NSString *content) {
    
    if(content.length == 0) {
        return nil;
    }
    
    const char *original_str = [content UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

@implementation CTMMD5Encrypt

+ (NSString *)encryptWithURLString:(NSString *)URLString method:(NSString *)method parameters:(NSDictionary *)parameters {
    
    NSString *cacheKey = [NSString stringWithFormat:@"Method:%@ Url:%@ Argument:%@ AppVersion:%@",
                             method,
                             URLString,
                             parameters,
                             CTMCacheAppVersion()];
    return CTMConvertMD5FromString(cacheKey);
}

@end

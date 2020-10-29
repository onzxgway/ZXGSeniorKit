//
//  CTMObject.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2020/10/28.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "CTMObject.h"

@protocol CTMObjectDelegate3 <NSObject>

@end

@interface CTMObject()<CTMObjectDelegate3> {
    NSNumber *_privateWeight;  // 私有成员变量 对象类型
    int _privateAge;           // 私有成员变量 基本数据类型
}

@property (nonatomic, copy) NSString *privateName;                 // 私有属性 对象类型

@property (nonatomic, strong, readonly) NSNumber *privateHeight;   // 私有只读属性 对象类型

@end

@implementation CTMObject

+ (void)start:(NSString *)logo {
    
}

- (NSString *)finish:(BOOL)isOK {
    return @"";
}

// 私有类方法
+ (void)privateStart:(NSString *)logo {
    
}

// 私有实例方法
- (NSString *)privateFinish:(BOOL)isOK {
    return @"";
}

@end

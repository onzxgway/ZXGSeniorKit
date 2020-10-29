//
//  CTMObject.h
//  RuntimeOverview
//
//  Created by 朱献国 on 2020/10/28.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CTMObjectDelegate1 <NSObject>

@end

@protocol CTMObjectDelegate2 <NSObject>

@end

@protocol CTMObjectDelegate4 <NSObject>

@end


@interface CTMObject : NSObject <CTMObjectDelegate1, CTMObjectDelegate2> {
    NSNumber *_weight;  // 成员变量 对象类型
    int _age;           // 成员变量 基本数据类型
}

@property (nonatomic, copy) NSString *name;                 // 属性 对象类型

@property (nonatomic, strong, readonly) NSNumber *height;   // 只读属性 对象类型

// 类方法
+ (void)start:(NSString *)logo;

// 实例方法
- (NSString *)finish:(BOOL)isOK;

@end

NS_ASSUME_NONNULL_END

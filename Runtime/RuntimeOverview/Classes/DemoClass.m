//
//  DemoClass.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/26.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "DemoClass.h"
#import <objc/runtime.h>

@interface DemoClass () <NSCoding> {
    NSNumber *_weight;
}

@end

@implementation DemoClass

- (void)iCanDoIt {
    NSLog(@"original iCanDoIt.");
}

+ (void)testMethod {}

- (void)privateMethod:(nonnull NSString *)aCoder {
    
}

//调用时刻:当调用了没有实现的方法就会调用
//作用:知道哪些方法没有实现,从而动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"tryDoIt:")) {
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型
         */
        Method m = class_getInstanceMethod([self class], @selector(replaceM:));
        class_addMethod([self class], sel, method_getImplementation(m), method_getTypeEncoding(m));
    }
    return [super resolveInstanceMethod:sel];
}

- (void)replaceM:(NSString *)things {
    NSLog(@"添加了tryDoIt:实现部分！");
}

@end

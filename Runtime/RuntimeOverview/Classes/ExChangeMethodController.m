//
//  ExChangeMethodController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ExChangeMethodController.h"
#import <objc/runtime.h>

@interface ExChangeMethodController ()

@end

@implementation ExChangeMethodController

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodOne];
        [self methodTwo];
        [self methodThree];
    });
}

// 1.交换两个方法的实现
+ (void)methodOne {
    Method method1 = class_getInstanceMethod(self.class, @selector(viewWillAppear:));
    Method method2 = class_getInstanceMethod(self.class, @selector(__viewWillAppear:));
    method_exchangeImplementations(method1, method2);
}

- (void)__viewWillAppear:(BOOL)animated {
    NSLog(@"交换两个方法的实现");
    [self __viewWillAppear:YES];
}

// 2.给方法设置实现方式
+ (void)methodTwo {
    
    Method method = class_getInstanceMethod(self.class, @selector(viewDidAppear:));
    
    void(*originalIMP)(id self, SEL _cmd) = nil;
    originalIMP = (typeof(originalIMP))method_getImplementation(method);
    
    id block = ^(id self, SEL _cmd) {
        NSLog(@"给方法设置实现方式");
        originalIMP(self, _cmd);
    };
    
    IMP newIMP = imp_implementationWithBlock(block);
    method_setImplementation(method, newIMP);
}

// 3.替换方法定义
+ (void)methodThree {
    Method replaceMethod = class_getInstanceMethod(self.class, @selector(kobe));
    
    class_replaceMethod(self.class, @selector(james), method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
    
    id obj = [[self.class alloc] init];
    [obj james];
}

- (void)kobe {
    NSLog(@"kobe 替换方法定义");
}

- (void)james {
    NSLog(@"james 替换方法定义");
}

@end

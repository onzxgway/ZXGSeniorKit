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
    // 方式一
//    [self methodOne];
    [self methodTwo];
}

// 方式一 : 需要交换两个方法的实现 场景使用
+ (void)methodOne {
    
    Method method1 = class_getInstanceMethod(self.class, @selector(viewWillAppear:));
    Method method2 = class_getInstanceMethod(self.class, @selector(__viewWillAppear:));
    
    method_exchangeImplementations(method1, method2);
}

// 方式二 : 给一个方法设置其实现方式 场景使用
+ (void)methodTwo {
    
    Method method = class_getInstanceMethod(self.class, @selector(viewWillAppear:));
    
    void(*originalIMP)(id self, SEL _cmd) = nil;
    originalIMP = (typeof(originalIMP))method_getImplementation(method);
    
    id block = ^(id self, SEL _cmd) {
        NSLog(@"方式二 将要显示");
        
        originalIMP(self, _cmd);
    };
    
    IMP newIMP = imp_implementationWithBlock(block);
    method_setImplementation(method, newIMP);
}

- (void)__viewWillAppear:(BOOL)animated {
    
    NSLog(@"方式一 将要显示");
    
    [self __viewWillAppear:YES];
}

@end

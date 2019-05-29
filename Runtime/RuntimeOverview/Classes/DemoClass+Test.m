//
//  DemoClass+Test.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "DemoClass+Test.h"
#import <objc/runtime.h>
#import "KVODemoClass.h"

@implementation DemoClass (Test)


- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    objc_setAssociatedObject(self, (__bridge const void *)(keyPath), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);// 把观察者保存到当前对象
    object_setClass(self, [KVODemoClass class]); // 修改对象isa指针
    
}

+ (void)load {
    
    [self addMember];
    
}

+ (void)addMember {
    Class clazz = self.class;
    
    const char * ivarName1 = "_sex";
    // 0.已经存在的类，不能再添加成员变量
    BOOL res = class_addIvar(clazz, ivarName1, sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    NSLog(@"%@", res ? @"ivar 添加成功": @"ivar 添加失败");
    
    // 1.为DemoClass类添加和已存在方法同名的方法  肯定添加失败
    Method preM = class_getInstanceMethod(self.class, @selector(highCopy));
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    BOOL resO = class_addMethod(clazz, @selector(iCanDoIt), class_getMethodImplementation([self class], @selector(highCopy)), method_getTypeEncoding(preM));
#pragma clang diagnostic pop
    NSLog(@"%@", resO ? @"同名Method 添加成功": @"同名Method 添加失败");
    
}

- (void)highCopy {
    NSLog(@"highCopy iCanDoIt.");
}

@end

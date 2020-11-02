//
//  NSObject+KVO.m
//  Runtime
//
//  Created by san_xu on 2017/9/12.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import "NSObject+KVO.h"
#import "Person.h"
#import <objc/message.h>

@implementation NSObject (KVO)

- (void)zxg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    objc_setAssociatedObject(self, (__bridge const void *)(keyPath), observer, OBJC_ASSOCIATION_ASSIGN);     // 把观察者保存到当前对象
    object_setClass(self, [Man class]);         // 修改对象isa指针
}

@end

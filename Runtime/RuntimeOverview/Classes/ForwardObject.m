//
//  ForwardObject.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2020/12/12.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ForwardObject.h"
#import <objc/message.h>

@implementation ForwardObject

#pragma mark - 消息转发机制的第一步
// 允许用户在此时为该Class动态添加实现。
// 如果有实现了，则调用并返回。如果仍没实现，继续下面的动作。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if ([NSStringFromSelector(sel) isEqualToString:@"test"]) {
//        Method method = class_getInstanceMethod(self.class, @selector(dynamicAddMethod));
//        IMP methodIMP = method_getImplementation(method);
//        const char *methodType = method_getTypeEncoding(method);
//        class_addMethod(self.class, sel, methodIMP, methodType);
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

- (void)dynamicAddMethod {
    NSLog(@"动态添加的test方法");
}

#pragma mark - 消息转发机制的第二步
// 尝试找到一个能响应该消息的对象。
// 如果获取到，则直接转发给它。如果返回了nil，继续下面的动作。
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"test"]) {
//        return [[BackupForwardObject alloc] init];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 消息转发机制的第三步
// 尝试获得一个方法签名。
// 如果获取不到，则直接调用doesNotRecognizeSelector抛出异常。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (![super methodSignatureForSelector:aSelector]) {
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return methodSignature;
    }
    return [super methodSignatureForSelector:aSelector];
}

// 将第3步获取到的方法签名包装成Invocation传入，如何处理就在这里面了。
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    BackupForwardObject *backUp = [[BackupForwardObject alloc] init];
    SEL sel = anInvocation.selector;
    // 判断备用对象是否可以响应传递进来等待响应的SEL
    if ([backUp respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:backUp];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

// 上面这4个方法均是模板方法，开发者可以override，由runtime来调用。最常见的实现消息转发，就是重写方法3和4，吞掉一个消息或者代理给其他对象都是没问题的。

@end


@implementation BackupForwardObject

- (void)test {
    NSLog(@"备用类的test方法");
}

@end

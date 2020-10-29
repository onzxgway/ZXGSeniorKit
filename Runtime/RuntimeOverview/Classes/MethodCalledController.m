//
//  MethodCalledController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/27.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "MethodCalledController.h"
#import <objc/message.h>
#import "DemoClass.h"

@interface MethodCalledController ()

@end

@implementation MethodCalledController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
    [self learn];
}

- (void)learn {
    
    DemoClass *obj = [[DemoClass alloc] init];
    // 向obj发送iCanDoIt消息
    [obj iCanDoIt];
    // 需求：分析消息发送的主要步骤
    /*
        OC的方法调用最终会生成C函数objc_msgSend(obj, @selector(iCanDoIt)),并且带有一些参数。这个C函数objc_msgSend就负责消息发送。
     
        消息发送的时候，在C语言函数中发生了什么事情？编译器是如何找到这个方法的呢？消息发送的主要步骤如下：
        1.首先检查这个选择器是不是要忽略。比如Mac OS X开发，有了垃圾回收就不会理会retain，release这些函数。
        2.检测这个选择器的target是不是nil，OC允许我们对一个nil对象执行任何方法不会Crash，因为运行时会被忽略掉。
        3.如果上面两步都通过了，根据obj的isa指针找到类对象，开始查找这个SEL的实现IMP，先从类对象的cache里查找，如果找到了就运行对应的函数去执行相应的代码。
        4.如果cache中没有找到就找类的method_list中是否有对应的方法。
        5.如果类的方法列表中找不到就到父类的方法列表中查找，一直找到NSObject类为止。
        6.如果还是没找到就要开始进入动态方法解析和消息转发，后面会说。
     */
}

/*
    方法交换
*/
- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls, origSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

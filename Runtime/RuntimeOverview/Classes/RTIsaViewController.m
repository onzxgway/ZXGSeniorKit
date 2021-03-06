//
//  RTIsaViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/25.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RTIsaViewController.h"
#import <objc/message.h>

@interface RTIsaViewController ()

@end

@implementation RTIsaViewController {
    Class _clazz;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"Objective-C是一门面向对象的编程语言，每个对象都是一个类的实例。每个对象的内部都有一个名为isa的指针，指向该对象所属的类。\n每个类描述了它的实例的一系列特点，包括成员变量列表和成员函数列表等。每一个对象都可以接受消息，而对象能够接受的消息列表保存在它所对应的类中。";
    self.descLab.text = @"Class isa; // isa是Class类型的指针 \n\n struct objc_class { \n      Class _Nonnull isa  OBJC_ISA_AVAILABILITY; \n      #if !__OBJC2__ \n      Class _Nullable super_class OBJC2_UNAVAILABLE; \n      const char * _Nonnull name OBJC2_UNAVAILABLE; \n      long version OBJC2_UNAVAILABLE; \n      long info OBJC2_UNAVAILABLE; \n      long instance_size OBJC2_UNAVAILABLE; \n      struct objc_ivar_list * _Nullable ivars OBJC2_UNAVAILABLE;\n      struct objc_method_list * _Nullable * _Nullable methodLists OBJC2_UNAVAILABLE; \n      struct objc_cache * _Nonnull cache OBJC2_UNAVAILABLE; \n      struct objc_protocol_list * _Nullable protocols OBJC2_UNAVAILABLE; \n      #endif \n } OBJC2_UNAVAILABLE; \n /* Use `Class` instead of `struct objc_class *` */";

    self.detailLab.text = @"// 获取isa指针 \n object_getClass(id _Nullable obj) \n\n // 修改isa指针 \n object_setClass(id _Nullable obj, Class _Nonnull cls) ";
    
//    [self ClassStruct];
    [self allocateClass];
}

// 动态创建类
- (void)allocateClass {
    
    // 创建一个名为CustomView的类，它是UIView的子类。
    _clazz = objc_allocateClassPair(UIView.class, "CustomView", 0);
    
    // 为CustomView类添加report方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    class_addMethod(_clazz, @selector(report), (IMP)report, "v@:");
#pragma clang diagnostic pop
    
    // 2.2 为CustomObj类添加_name、_age成员变量
    /**
     类添加成员变量
     param 被操作类
     param 成员变量名称
     param 变量内存所占大小
     param 变量对齐方式
     param 变量类型编码
     */
    /*
     优点：动态添加的Ivar，能够通过遍历Ivars得到我们所添加的属性。
     缺点：已存在的class中不能添加Ivar，所有必须通过objc_allocateClassPair动态创建一个class，才能调用class_addIvar添加Ivar，最后通过objc_registerClassPair注册class。
     */
    NSString *iVarName1 = @"_name";
    BOOL resOne = class_addIvar(_clazz, [iVarName1 UTF8String], sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    NSLog(@"%@", resOne ? @"ivar 添加成功": @"ivar 添加失败");
    
    // 注册该类 注册之后，不能再添加成员变量了
    objc_registerClassPair(_clazz);
    
    [self auth];
}

- (void)auth {
    // 创建CustomView实例
    id obj =  [[_clazz alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    [obj performSelector:@selector(report)];
#pragma clang diagnostic pop
    
    [obj setValue:@"kobe" forKey:@"_name"];
    NSLog(@"%@", [obj valueForKey:@"_name"]);
}

void report(id self, SEL _cmd) {
    NSLog(@"This object is %@", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class curClass = [self class];
    for (int i = 0; i < 5; ++i) {
        NSLog(@"Following the isa pointer %d times gives %p.", i, curClass);
        curClass = object_getClass(curClass);
    }
    
    NSLog(@"NSObject Class is %p.", [NSObject class]);
    NSLog(@"NSObject meta class is %p.", object_getClass([NSObject class]));
}

/**
 This object is <CustomView: 0x7ff7b4716000; frame = (0 0; 0 0); layer = <CALayer: 0x604000432ae0>>
 
 Class is CustomView, and super is UIView.
 Following the isa pointer 0 times gives 0x604000254dc0.
 Following the isa pointer 1 times gives 0x604000254a00.
 Following the isa pointer 2 times gives 0x109cb5e58.
 Following the isa pointer 3 times gives 0x109cb5e58.
 Following the isa pointer 4 times gives 0x109cb5e58.
 
 NSObject Class is 0x109cb5ea8.
 NSObject meta class is 0x109cb5e58.
 
 打印结果，完美的证明了 one.png 图所示内容。
 */

- (void)ClassStruct {
    
    /* Use `Class` instead of `struct objc_class *` */
    struct objc_class {
        Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
#if !__OBJC2__
        Class _Nullable super_class OBJC2_UNAVAILABLE;
        const char * _Nonnull name  OBJC2_UNAVAILABLE;
        long version                OBJC2_UNAVAILABLE;
        long info                   OBJC2_UNAVAILABLE;
        long instance_size          OBJC2_UNAVAILABLE;
        struct objc_ivar_list * _Nullable ivars OBJC2_UNAVAILABLE;
        struct objc_method_list * _Nullable * _Nullable methodLists OBJC2_UNAVAILABLE;
        struct objc_cache * _Nonnull cache OBJC2_UNAVAILABLE;
        struct objc_protocol_list * _Nullable protocols OBJC2_UNAVAILABLE;
#endif
    } OBJC2_UNAVAILABLE;
    
}

@end

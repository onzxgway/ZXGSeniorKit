//
//  RTClassViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/26.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RTClassViewController.h"
#import "DemoClass.h"
#import <objc/message.h>

@interface RTClassViewController ()

@end

@implementation RTClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"类(类对象)是由Class类型来表示的，它是一个objc_class结构类型的指针。";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
    [self ClassStruct];
    [self testClassStruct];
}

- (void)testClassStruct {
    
    NSLog(@"super_class: %@", NSStringFromClass(class_getSuperclass(DemoClass.class)));
    NSLog(@"name: %s", class_getName(DemoClass.class));
    
    NSLog(@"version:%dd", class_getVersion(DemoClass.class));
    NSLog(@"instance_size:%zud", class_getInstanceSize(DemoClass.class));

    // 需求： 获取DemoClass类的成员属性列表和成员函数列表。
    unsigned int outCountV = 0;
    unsigned int outCountM = 0;
    unsigned int outCountP = 0;
    unsigned int outCountPL = 0;
    Ivar *ivars = class_copyIvarList(DemoClass.class, &outCountV);      // 获取成员变量
    Method *methods = class_copyMethodList(DemoClass.class, &outCountM);    // 获取成员函数
    objc_property_t *pts = class_copyPropertyList(DemoClass.class, &outCountPL);    // 获取属性
    Protocol __unsafe_unretained **pros = class_copyProtocolList(DemoClass.class, &outCountP); // 获取协议
    for (int i = 0; i < outCountV; ++i) {
        Ivar ivar = ivars[i];
        NSLog(@"ivar:%s", ivar_getName(ivar));
    }
    for (int i = 0; i < outCountPL; ++i) {
        objc_property_t pt = pts[i];
        NSLog(@"objc_property_t:%s", property_getName(pt));
    }
    for (int i = 0; i < outCountM; ++i) {
        Method method = methods[i];
        SEL name = method_getName(method);
        NSLog(@"method:%s", sel_getName(name));
    }
    for (int i = 0; i < outCountP; ++i) {
        Protocol *p = pros[i];
        NSLog(@"protocol:%s", protocol_getName(p));
    }
    
}

/**
 根据打印结果得出以下结论：
    1. 类(对象)在runtime面前是透明的，通过runtime可以获取类的成员变量和函数列表、协议列表 (不论是私有还是共有的都能获取到)。
 */

- (void)ClassStruct {
    
    /* Use `Class` instead of `struct objc_class *` */
    struct objc_class {
        Class _Nonnull isa  OBJC_ISA_AVAILABILITY;      // 类对象的指针指向其所属的类，即元类。元类中存储着类对象的类方法，当访问某个类的类方法时会通过该isa指针从元类中寻找方法对应的函数指针。
#if !__OBJC2__
        Class _Nullable super_class OBJC2_UNAVAILABLE;  // 指向该类所继承的父类对象，如果该类已经是最顶层的根类(如NSObject或NSProxy), 则为NULL。
        const char * _Nonnull name  OBJC2_UNAVAILABLE;  // 类的名称
        long version                OBJC2_UNAVAILABLE;
        long info                   OBJC2_UNAVAILABLE;
        long instance_size          OBJC2_UNAVAILABLE;
        struct objc_ivar_list * _Nullable ivars OBJC2_UNAVAILABLE;  // 类成员变量列表
        struct objc_method_list * _Nullable * _Nullable methodLists OBJC2_UNAVAILABLE;  // 类成员函数列表
        struct objc_cache * _Nonnull cache OBJC2_UNAVAILABLE;
        struct objc_protocol_list * _Nullable protocols OBJC2_UNAVAILABLE;  // 类成员协议列表
#endif
    } OBJC2_UNAVAILABLE;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

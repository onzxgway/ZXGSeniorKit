//
//  CTMClassViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2020/10/28.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "CTMClassViewController.h"
#import "CTMObject.h"
#import <objc/message.h>

@interface CTMClassViewController ()

@end

@implementation CTMClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"类(类对象)是由Class类型来表示的，它是一个objc_class结构类型的指针。";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
    [self demo];
}

// 类对象(Class)在runtime面前是透明的，通过runtime可以获取到类的所有信息包括成员变量、函数列表和协议列表等。
- (void)demo {
    // isa
    NSLog(@"元类: %@", object_getClass(CTMObject.class));
    NSLog(@"根元类: %@", object_getClass(object_getClass(CTMObject.class)));
    NSLog(@"根元类: %@", object_getClass(object_getClass(object_getClass(CTMObject.class))));
    // super_class
    NSLog(@"super_class: %@", class_getSuperclass(CTMObject.class));
    // name
    NSLog(@"name: %s", class_getName(CTMObject.class));
    // version
    NSLog(@"version: %d", class_getVersion(CTMObject.class));
    // instance_size
    NSLog(@"instance_size: %ld", class_getInstanceSize(CTMObject.class));
    
    // ivars
    unsigned int outCountV = 0;
    Ivar *ivars = class_copyIvarList(CTMObject.class, &outCountV);// 获取成员变量列表 (公 + 私)
    for (int i = 0; i < outCountV; ++i) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar); // @"NSNumber"
        NSLog(@"ivar:%s --> %s", name, type);
    }
    
    // property
    unsigned int outCountPL = 0;
    objc_property_t *pts = class_copyPropertyList(CTMObject.class, &outCountPL);// 获取属性列表 (公 + 私)
    for (int i = 0; i < outCountPL; ++i) {
        objc_property_t pt = pts[i];
        const char * name = property_getName(pt);       // 获取属性名
        const char * type = property_getAttributes(pt); // 获取属性特性描述字符串 T@"NSString",C,N,V_name  T@"NSNumber",R,N,V_height
        NSLog(@"property:%s --> %s", name, type);
    }
    
    // methodLists
    unsigned int outCountM = 0;
    Method *methods = class_copyMethodList(CTMObject.class, &outCountM); // 获取成员实例方法
    for (int i = 0; i < outCountM; ++i) {
        Method method = methods[i];
        SEL name = method_getName(method);
        NSLog(@"method:%s --> %s", sel_getName(name), method_getTypeEncoding(method));
        // v16@0:8
        // v：代表 void    @：代表OC对象  : ：代表 SEL
    }
    
    // protocols
    unsigned int outCountP = 0;
    Protocol __unsafe_unretained **pros = class_copyProtocolList(CTMObject.class, &outCountP); // 获取协议
    for (int i = 0; i < outCountP; ++i) {
        Protocol *p = pros[i];
        NSLog(@"protocol:%s", protocol_getName(p));
    }
    
}

- (void)ClassStruct {
    
    /* Use `Class` instead of `struct objc_class *` */
    struct objc_class {
        Class _Nonnull isa  OBJC_ISA_AVAILABILITY;      // 类对象的指针指向其所属的类，即元类。元类中存储着类对象的类方法，当访问某个类的类方法时会通过该isa指针从元类中寻找方法对应的函数指针。
#if !__OBJC2__
        Class _Nullable super_class OBJC2_UNAVAILABLE;  // 指向该类所继承的父类对象，如果该类已经是最顶层的根类(如NSObject或NSProxy), 则为NULL。
        const char * _Nonnull name  OBJC2_UNAVAILABLE;  // 类的名称
        long version                OBJC2_UNAVAILABLE;
        long info                   OBJC2_UNAVAILABLE;
        long instance_size          OBJC2_UNAVAILABLE;  // 类的实例大小
        struct objc_ivar_list * _Nullable ivars OBJC2_UNAVAILABLE;  // 类成员变量列表
        struct objc_method_list * _Nullable * _Nullable methodLists OBJC2_UNAVAILABLE;  // 类成员函数列表
        struct objc_cache * _Nonnull cache OBJC2_UNAVAILABLE;   // 缓存调用过的方法
        struct objc_protocol_list * _Nullable protocols OBJC2_UNAVAILABLE;  // 类成员协议列表
#endif
    } OBJC2_UNAVAILABLE;
    
}


- (void)IvarStruct {
    
    struct objc_ivar {
        char * _Nullable ivar_name OBJC2_UNAVAILABLE;   // 成员变量名称
        char * _Nullable ivar_type OBJC2_UNAVAILABLE;   // 成员变量类型
        int ivar_offset OBJC2_UNAVAILABLE;              // 成员变量偏移
#ifdef __LP64__
        int space OBJC2_UNAVAILABLE;
#endif
    } OBJC2_UNAVAILABLE;

}

- (void)IvarListStruct {
    
//    struct objc_ivar_list {
//        int ivar_count OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//        int space OBJC2_UNAVAILABLE;
//#endif
//        /* variable length structure */
//        struct objc_ivar ivar_list[1] OBJC2_UNAVAILABLE;
//    } OBJC2_UNAVAILABLE;
    
}

- (void)MethodStruct {
    
    struct objc_method {
        SEL _Nonnull method_name OBJC2_UNAVAILABLE;        // 方法名称
        char * _Nullable method_types OBJC2_UNAVAILABLE;   // 方法编码
        IMP _Nonnull method_imp  OBJC2_UNAVAILABLE;        // 方法地址 函数实现体指针
    } OBJC2_UNAVAILABLE;
    
}

- (void)MethodListStruct {
    
//    struct objc_method_list {
//        struct objc_method_list * _Nullable obsolete OBJC2_UNAVAILABLE;
//
//        int method_coun OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//        int space                                                OBJC2_UNAVAILABLE;
//#endif
//        /* variable length structure */
//        struct objc_method method_list[1] OBJC2_UNAVAILABLE;
//    } OBJC2_UNAVAILABLE;
    
}


@end

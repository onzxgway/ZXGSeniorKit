//
//  RTIsaViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/25.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RTIsaViewController.h"

@interface RTIsaViewController ()

@end

@implementation RTIsaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"Objective-C是一门面向对象的编程语言，每个对象都是一个类的实例。每个对象的内部都有一个名为isa的指针，指向该对象所属的类。\n每个类描述了它的实例的一系列特点，包括成员变量列表和成员函数列表等。每一个对象都可以接受消息，而对象能够接受的消息列表保存在它所对应的类中。";
    self.descLab.text = @"Class isa; // isa是Class类型的指针 \n\n struct objc_class { \n      Class _Nonnull isa  OBJC_ISA_AVAILABILITY; \n      #if !__OBJC2__ \n      Class _Nullable super_class OBJC2_UNAVAILABLE; \n      const char * _Nonnull name OBJC2_UNAVAILABLE; \n      long version OBJC2_UNAVAILABLE; \n      long info OBJC2_UNAVAILABLE; \n      long instance_size OBJC2_UNAVAILABLE; \n      struct objc_ivar_list * _Nullable ivars OBJC2_UNAVAILABLE;\n      struct objc_method_list * _Nullable * _Nullable methodLists OBJC2_UNAVAILABLE; \n      struct objc_cache * _Nonnull cache OBJC2_UNAVAILABLE; \n      struct objc_protocol_list * _Nullable protocols OBJC2_UNAVAILABLE; \n      #endif \n } OBJC2_UNAVAILABLE; \n /* Use `Class` instead of `struct objc_class *` */";

    self.detailLab.text = nil;
    
    [self ClassStruct];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

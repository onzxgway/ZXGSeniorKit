//
//  SELIMPMethodController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/27.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "SELIMPMethodController.h"
#import <objc/message.h>
#import "DemoClass.h"

@interface SELIMPMethodController ()

@end

void funcTest(id self, SEL _cmd) {
    NSLog(@"funcTest:%@__%@", self, NSStringFromSelector(_cmd));
}

@implementation SELIMPMethodController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"SEL";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
//    [self learn];
//    [self gogogo];
    [self doIt:@"zxg" age:@18];
}

/**
 OC的方法本质
 
 1.OC中的方法默认被隐藏了两个参数：id self和 SEL _cmd。
 2.在编译时OC函数调用的语法都会被翻译成一个C的函数调用objc_msgSend()
   下面两行代码就是等价的：
    OC: [array insertObject:@100 atIndex:5];
    C:  objc_msgSend(array, @selector(insertObject:atIndex:), @100, 5);
 */
- (void)gogogo {
    // self 和 _cmd 是隐式参数
    NSLog(@"id:%@ -- SEL:%@", self, NSStringFromSelector(_cmd));
}
- (void)doIt:(NSString *)name age:(NSNumber *)age {
    NSLog(@"id:%@ -- SEL:%@", self, NSStringFromSelector(_cmd));
    NSLog(@"name:%@ -- age:%@", name, [age stringValue]);
}

/**
 SEL: 方法名称
 IMP: 方法实现的首地址
 Method: SEL + IMP + method_types
 
 struct objc_method {
    SEL _Nonnull method_name        OBJC2_UNAVAILABLE;
    char * _Nullable method_types   OBJC2_UNAVAILABLE;
    IMP _Nonnull method_imp         OBJC2_UNAVAILABLE;
 }
 
 Class + SEL -> IMP 相当于在SEL和IMP之间建立了一个映射。
 */
- (void)learn {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    BOOL res = class_addMethod(self.class, @selector(dddd), (IMP)funcTest, "");
    if (res) {
        [self performSelectorOnMainThread:@selector(dddd) withObject:nil waitUntilDone:NO];
    }
    
//    class_addIvar(Class  _Nullable __unsafe_unretained cls, const char * _Nonnull name, size_t size, uint8_t alignment, const char * _Nullable types)
    
//    class_addProperty(Class  _Nullable __unsafe_unretained cls, const char * _Nonnull name, const objc_property_attribute_t * _Nullable attributes, unsigned int attributeCount)
    
//    class_addProtocol(Class  _Nullable __unsafe_unretained cls, Protocol * _Nonnull protocol)
    
#pragma clang diagnostic pop
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

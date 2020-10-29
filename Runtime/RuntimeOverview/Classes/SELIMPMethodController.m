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
#import "CTMObject.h"

@interface SELIMPMethodController ()

@end

void funcTest(id self, SEL _cmd) {
    NSLog(@"funcTest:%@ --> %@", self, NSStringFromSelector(_cmd));
}

@implementation SELIMPMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"SEL";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
    [self learn];
//    [self gogogo];
//    [self doIt:@"zxg" age:@18];
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

    // 添加Method
    class_addMethod(CTMObject.class, @selector(newMethod), (IMP)funcTest, "");
    
    // 添加Ivar
    class_addIvar(CTMObject.class, "_newIvar", sizeof(NSString *), log2(sizeof(NSString *)), "@");
    
    // 添加Property
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"", NSStringFromClass(NSString.class)] UTF8String]};
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", @"newProperty"] UTF8String]};
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(CTMObject.class, "newProperty", attrs, 3);
    
    // 添加Protocol
    class_addProtocol(CTMObject.class, @protocol(CTMObjectDelegate4));
    
#pragma clang diagnostic pop
    
}

@end

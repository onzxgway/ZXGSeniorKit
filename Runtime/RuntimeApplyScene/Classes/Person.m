//
//  Person.m
//  Runtime
//
//  Created by san_xu on 2017/9/12.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

- (NSString *)sayHello {
    return @"Thank you very much!";
}

- (NSString *)howOldAreYou:(NSString *)name {
    return [NSString stringWithFormat:@"%@ 18 years old!",name];
}

+ (NSString *)howOldAreYou:(NSString *)name {
    return [[[self alloc] init] howOldAreYou:name];
}

//所有的方法都默认有两个隐式参数self和_cmd
// self:方法调用者
// _cmd:调用方法的编号
void tempIMP(id self,SEL _cmd,id param1) {
    NSLog(@"调用 %@ %@ %@",self,NSStringFromSelector(_cmd),param1);
}

//调用时刻:当调用了没有实现的方法就会调用
//作用:知道哪些方法没有实现,从而动态添加方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"sayHi:")) {
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型
         */
        class_addMethod([self class], sel, (IMP)tempIMP, "v@:@");
    }
    return [super resolveInstanceMethod:sel];
}


#pragma mark - dynamic create class
+ (void)createClass {
    //1,创建一个名称为ZXGObject的类，它的父类是NSObject
    Class newClass = objc_allocateClassPair([NSObject class], "ZXGObject", 0);
    // 1.1增加实例变量
    // 参数一、类名
    // 参数二、属性名称
    // 参数三、开辟字节长度
    // 参数四、对其方式
    // 参数五、参数类型 “@” 官方解释 An object (whether statically typed or typed id) （对象 静态类型或者id类型） 具体类型可参照 https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
    // return: BOOL 是否添加成功
    BOOL isSuccess = class_addIvar(newClass, "test", sizeof(NSString *), 0, "@");
    isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
    
    // 1.2增加方法
    class_addMethod(newClass, @selector(newMethod:), (IMP)newMethodFunc, "V@:");
    
    //2,注册该类
    objc_registerClassPair(newClass);
    
    
    //调用该类的方法
    id obj = [[newClass alloc] init];
    NSLog(@"%@",obj);
    [obj setValue:@"我是kobe" forKey:@"test"];
//    [obj performSelector:@selector(newMethod:) withObject:@"实参"]; 或者
    [obj newMethod:@"实参"];
    
}

//在self和_cmd之后可以随意添加其他参数 static
void newMethodFunc(id self, SEL _cmd, NSString *title) {
    
    // 获取类中指定名称实例成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], "test");
    
    // 获取整个成员变量列表
    //   Ivar * class_copyIvarList ( Class cls, unsigned int * outCount );
    // 获取类成员变量的信息
    //   Ivar class_getClassVariable ( Class cls, const char *name );
    
    // 返回名为name的ivar变量的值
    id obj = object_getIvar(self, ivar);
    
    NSLog(@"成员变量的值:%@",obj);
    NSLog(@"newMethodFunc:%@",title);
    NSLog(@"动态创建类名为:%@",NSStringFromClass([self class]));
    
}

//这个方法实际上没有被调用,可以去掉警告
- (void)newMethod:(NSString *)string {}

@end


@implementation Man

- (void)setAge:(NSUInteger)age {
    [super setAge:age];
    
    // 向监听对象发送消息
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"age");
    [observer observeValueForKeyPath:@"age" ofObject:self change:nil context:nil];
}

@end

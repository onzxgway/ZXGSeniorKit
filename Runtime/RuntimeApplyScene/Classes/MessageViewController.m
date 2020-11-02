//
//  MessageViewController.m
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/2.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "MessageViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self msgPrinciple];
    [self demo];
}

/**
 OC是运行时机制，消息机制是运行时机制中一个重要的机制。
 消息机制：调用方法的本质就是发送消息。
 */
// 一 实例方法
- (void)msgPrinciple {
    Person *person = [[Person alloc] init];
    // 1.直接调用
    NSString *rst1 = [person howOldAreYou:@"kobe"];
    NSLog(@"直接调用 -> %@", rst1);
    // 2.performSelector
    NSString *rst2 = [person performSelector:@selector(howOldAreYou:) withObject:@"kobe"];
    NSLog(@"performSelector -> %@", rst2);
    // 3.方法签名 + NSInvocation
    NSMethodSignature *signature = [person methodSignatureForSelector:@selector(howOldAreYou:)];
    // 获取方法签名对应的invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    /**
     设置消息接受者，与[invocation setArgument:(__bridge void * _Nonnull)(person) atIndex:0]等价
     */
    [invocation setTarget:person];
    /**设置要执行的selector，与[invocation setArgument:@selector(howOldAreYou:) atIndex:1] 等价*/
    [invocation setSelector:@selector(howOldAreYou:)];
    // 设置参数
    NSString *str = @"kobe";
    [invocation setArgument:&str atIndex:2];
    // 开始执行
    [invocation invoke];
    void *returnValue = NULL;
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }
    id rst3 = (__bridge id)returnValue;
    NSLog(@"方法签名 -> %@", rst3);
    // 4.objc_msgSend
    id rst4 = ((id(*)(id, SEL, NSString *))objc_msgSend)(person, @selector(howOldAreYou:), @"kobe");
    NSLog(@"objc_msgSend -> %@", rst4);
}

/**
  使用运行时的objc_msgSend函数：
  第一步:导入<objc/message.h>
  第二步:Build Setting -> 搜索msg -> 设置属性为No
*/
// 二 类方法:本质是通过类名获取类对象。
- (void)demo {
    Class clazz = [Person class];
    // 1.直接调用
    NSString *rst1 = [Person howOldAreYou:@"Mary"];
    NSLog(@"直接调用 -> %@", rst1);
    // 2.performSelector
    NSString *rst2 = [clazz performSelector:@selector(howOldAreYou:) withObject:@"Mary"];
    NSLog(@"performSelector -> %@", rst2);
    // 3.objc_msgSend
    id rst3 = ((id(*)(id, SEL, NSString *))objc_msgSend)(clazz, @selector(howOldAreYou:), @"Mary");
    NSLog(@"objc_msgSend -> %@", rst3);
}

@end

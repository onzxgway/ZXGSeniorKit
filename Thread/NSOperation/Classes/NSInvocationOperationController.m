//
//  NSInvocationOperationController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSInvocationOperationController.h"

@interface NSInvocationOperationController ()
@property (nonatomic, strong) NSInvocationOperation *operation;
@property (nonatomic, strong) NSInvocation *invocation;
@end

@implementation NSInvocationOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self method1];
//    [self method2];
      [self method3];
    
}

- (void)method1 {
    NSString *name = @"kobe";
    NSString *age = @"40";
    NSString *sex = @"man";
    
    // 需求一：使用GCD实现
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread currentThread].name = @"GCD";
        NSString *returnValue = [self name:name age:age sex:sex];
        NSLog(@"returnValue:%@", returnValue);
    });
}

#pragma mark - 需求一：把name:age:sex:方法放在当前线程去执行，用NSInvocationOperation实现？
- (void)method2 {
    // 需求一：使用NSOperation实现
    
    // 方法签名 （方法的对象结构，相关的结构信息：返回值，调用者，方法名，参数）
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(name:age:sex:)];
    
    // NSInvocation作用是把方法对象化
    self.invocation = [NSInvocation invocationWithMethodSignature:signature];
    /**
     <NSInvocation: 0x604000471ac0>
     return value: {@} 0x0
     target: {@} 0x0
     selector: {:} null
     argument 2: {@} 0x0
     argument 3: {@} 0x0
     argument 4: {@} 0x0
     */
    self.invocation.target = self;
    self.invocation.selector = @selector(name:age:sex:); //和签名的seletor要对应起来
    // 配置参数
    NSString *name = @"kobe";
    NSString *age = @"40";
    NSString *sex = @"man";
    [self.invocation setArgument:&name atIndex:2];
    [self.invocation setArgument:&age atIndex:3];
    [self.invocation setArgument:&sex atIndex:4];
    //    [self.invocation invoke]; // 调用方法
    
    self.operation = [[NSInvocationOperation alloc] initWithInvocation:self.invocation];
    
    // 调用 start 方法开始执行操作
    [self.operation start]; // 在当前线程中执行， 相当于 [self name:name age:age sex:sex];
}

// 这个方法是一个耗时业务
- (NSString *)name:(NSString *)name age:(NSString *)age sex:(NSString *)sex {
    NSLog(@"name: age: sex:%@", [NSThread currentThread]);
    return [NSString stringWithFormat:@"%@-%@-%@", name, age, sex];
}

// 获取结果
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __unsafe_unretained NSString *returnValue;
    [self.invocation getReturnValue:&returnValue];
    NSLog(@"returnValue:%@", returnValue);
}

#pragma mark - 需求二：把task方法放在子线程去执行
- (void)method3 {
    [self performSelectorInBackground:@selector(useInvocationOperation) withObject:nil];
}

/**
 * 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {
    
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    
    // 2.调用 start 方法开始执行操作
    [op start];
}


//
- (void)task {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

@end

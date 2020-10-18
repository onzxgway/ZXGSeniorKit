//
//  NSOperationQueueController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/6/2.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSOperationQueueController.h"

@interface NSOperationQueueController ()

@end

@implementation NSOperationQueueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSOperationQueue";
    
//    [self queueKinds];
//    [self method1];
    [self maxConcurrentOperationCount];
}

// 队列种类
/**
 GCD的队列有两种：
    1.并发队列
    2.串行队列
      主队列是特殊的串行队列. 特殊点在 主队列中的操作，都会放到主线程中执行
 */
/**
 NSOperation的队列也有两种：
 1.主队列  凡是添加到主队列中的操作，都会放到主线程中执行.（注：不包括使用addExecutionBlock:添加的额外操作，额外操作可能在其他线程执行）
 2.自定义队列 （同时具有串行、并发功能）
 */
- (void)queueKinds {
    
    // 主队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];

    [mainQueue addOperationWithBlock:^{
        NSLog(@"mainQueue1::%@", [NSThread currentThread]);
    }];
    
    [mainQueue addOperationWithBlock:^{
        NSLog(@"mainQueue2::%@", [NSThread currentThread]);
    }];
    
    
    // 自定义队列  添加到这种队列中的操作，就会自动放到子线程中执行
    NSOperationQueue *customQueue = [[NSOperationQueue alloc] init];

    [customQueue addOperationWithBlock:^{
        NSLog(@"customQueue::%@", [NSThread currentThread]);
    }];
    
    [customQueue addOperationWithBlock:^{
        NSLog(@"customQueue1::%@", [NSThread currentThread]);
    }];
    
    [customQueue addOperationWithBlock:^{
        NSLog(@"customQueue2::%@", [NSThread currentThread]);
    }];
}

// ***一：NSOperation + NSOperationQueue组合的基本使用方式：
- (void)method1 {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
    }
}

// 最大并发数: 一个队列中同时能并发执行的最大操作数。
/**
 
 自定义队列 通过控制最大并发数属性maxConcurrentOperationCount,来实现同时具有串行、并发功能。
 
 maxConcurrentOperationCount 默认情况下为-1，表示不进行限制，可进行并发执行。
 
 maxConcurrentOperationCount 为1时，队列为串行队列。只能串行执行。
 
 maxConcurrentOperationCount 大于1时，队列为并发队列。操作并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整为min{自己设定的值，系统设定的默认最大值}。
 */
- (void)maxConcurrentOperationCount {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
//    queue.maxConcurrentOperationCount = 1; // 相当于串行队列
     queue.maxConcurrentOperationCount = 2; // 并发队列
//     queue.maxConcurrentOperationCount = 8; // 并发队列
    
    // 3.添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

@end

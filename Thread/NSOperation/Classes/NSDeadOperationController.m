//
//  NSDeadOperationController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSDeadOperationController.h"

@interface NSDeadOperationController () {
    NSPort *_port;
    NSTimer *_timer;
}

@end

@implementation NSDeadOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self method1];
    [self method2];
}

#pragma mark - 需求一：在子线程去执行延时操作。
// GCD 很容易实现 dispatch_after。
// NSThread 实现
- (void)method1 {
    [NSThread detachNewThreadSelector:@selector(ThreadOne) toTarget:self withObject:nil];
    
}

// 该方式 endThread: 方法不会被执行。必须如下ThreadOne
- (void)Thread1 {
    NSLog(@"start thread");
    [self performSelector:@selector(endThread:) withObject:nil afterDelay:2];
    NSLog(@"end thread");
    
    for (int i = 0; i < 5; i ++) {
        NSLog(@"%@_%d",[NSThread currentThread], i);
    }
    
    NSLog(@"finished thread");
}

// 该方式 endThread: 会被执行。但是线程对象会僵尸。
- (void)ThreadOne {
    NSLog(@"start thread");
    
    _port = [[NSPort alloc] init];
    [self performSelector:@selector(endThread:) withObject:nil afterDelay:2];
    [[NSRunLoop currentRunLoop] addPort:_port forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end thread");
    
    for (int i = 0; i < 5; i ++) {
        NSLog(@"%@_%d",[NSThread currentThread], i);
    }
    
    NSLog(@"finish thread");
}

- (void)endThread:(id)sender {
    [[NSRunLoop currentRunLoop] removePort:_port forMode:NSDefaultRunLoopMode]; // 必须在当前线程中移除端口，当前线程才不会僵死。（其他线程移除无效）
    NSLog(@"任务执行...");
}

#pragma mark -
- (void)method2 {
    [NSThread detachNewThreadSelector:@selector(ThreadTwo) toTarget:self withObject:nil];
}

- (void)ThreadTwo {
    NSLog(@"start thread");
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end thread");
    
    for (int i = 0; i < 5; i ++) {
        NSLog(@"%@_%d",[NSThread currentThread], i);
    }
    NSLog(@"finish thread");
}

- (void)stopTimer:(id)sender {
    
    NSLog(@"stopTimer");
    static int count = 0;
    count++;
    if (count > 5) {
        [_timer invalidate]; // 必须在当前线程中移除，当前线程才不会僵死。
    }
    
}

@end

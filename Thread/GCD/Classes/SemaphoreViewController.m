//
//  SemaphoreViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "SemaphoreViewController.h"

@interface SemaphoreViewController ()

@end

@implementation SemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"dispatch_semaphore_t";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dispatch_semaphore];
}

// semaphore使用场景：一个界面执行多个网络请求

// semaphore可以理解为最大并发数 异步变同步 的功能
- (void)dispatchSignal {
    // create的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    // 任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    
    // 任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}

#pragma mark - dispatch_semaphore_t
/**
 dispatch_semaphore_t:信号量，相当于NSOperationQueue中最大并发数的功能，用来控制线程的数量。
 
 dispatch_release() 该函数在ARC环境中不可以使用。
 */
- (void)dispatch_semaphore {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    // 创建信号量，参数：信号量的初值，如果小于0则会返回NULL
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第一个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----结束执行第一个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第二个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----结束执行第二个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"----开始执行第三个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"----结束执行第三个任务---当前线程%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}


@end

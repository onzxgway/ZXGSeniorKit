//
//  NSOperationOtherController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSOperationOtherController.h"

@interface NSOperationOtherController ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) NSInteger ticketSurplusCount;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation NSOperationOtherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self method1];
    
    [self method2];
}
/**
 线程间通信是通过 向对应的队列中添加任务 来实现的。
 */
// 子线程 —> 主线程
- (void)method1 {
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", [NSThread currentThread]);
        
        // 通知 主线程 更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2.f];
            NSLog(@"%@ 更新UI", [NSThread currentThread]);
        }];
    }];
    
    [self.queue addOperation:operation];
}

// 线程安全
/**
 模拟火车票售卖的方式，实现 NSOperation 线程安全和解决线程同步问题。
 场景：总共有50张火车票，有两个售卖火车票的窗口，一个是北京火车票售卖窗口，另一个是上海火车票售卖窗口。两个窗口同时售卖火车票，卖完为止。
 */
- (void)method2 {
    
    [self initTicketStatusNotSave];
}

/**
 * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusNotSave {
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    
    self.ticketSurplusCount = 50;
    
    self.lock = [[NSLock alloc] init];  // 初始化 NSLock 对象
    
    // 1.创建 queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;

    // 2.创建 queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    // 3.创建卖票操作 op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        [self saleTicketNotSafe];
        [self saleTicketSafe];
    }];
    
    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        [self saleTicketNotSafe];
        [self saleTicketSafe];
    }];
    
    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 * 售卖火车票(非线程安全)
 */
// 在不考虑线程安全，不使用 NSLock 情况下，得到票数是错乱的，这样显然不符合我们的需求，所以我们需要考虑线程安全问题。
- (void)saleTicketNotSafe {
    while (1) {
        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%ld 窗口:%@", (long)self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        
        // 加锁
        [self.lock lock];
        
        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%ld 窗口:%@", (long)self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }
        
        // 解锁
        [self.lock unlock];
        
        if (self.ticketSurplusCount <= 0) {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

@end

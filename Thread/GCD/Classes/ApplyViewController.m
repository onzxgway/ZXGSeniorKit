//
//  ApplyViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"dispatch_apply";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self apply_One];
    [self apply_Two];
}

#pragma mark - dispatch_apply
// dispatch_apply将任务按照指定的次数追加到队列中，并等待全部队列任务执行结束。
// apply 相当于 同步队列组， 重复
- (void)apply_One {
    dispatch_queue_t queue = dispatch_queue_create("testRWAry", DISPATCH_QUEUE_CONCURRENT);
    
    /**
     dispatch_apply函数是dispatch_sync函数和Dispatch Group的关联API,
     该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中,并等到全部的处理执行结束
     
     @param 10 指定次数
     @param queue 追加对象的Dispatch Queue
     @param count 带有参数的Block, index的作用是为了按执行的顺序区分各个Block
     
     */
    dispatch_apply(5, queue, ^(size_t count) {
        NSLog(@"%zu", count);
    });
    
    // 当前线程会卡在这里，等待上述5个任务执行结束之后，当前线程才会继续往下执行。
    NSLog(@"Done!");
}

- (void)apply_Two {
    /**
     如果在for循环中使用 dispatch_async，需要管理好线程的数量，否则会发生线程爆炸或死锁。
     而dispatch_apply是由GCD管理并发的，可以碧避免上述情况发生。
     */
    dispatch_queue_t queue = dispatch_queue_create("concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
//    // 有问题的情况，可能会死锁
//    for (int i = 0; i < 999 ; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"thread: %@", [NSThread currentThread]);
//        });
//    }
    
    // 正确方式
    dispatch_apply(999, queue, ^(size_t i){
        NSLog(@"correct %zu", i);
    });
    
    // 当前线程会阻塞在这里，等待上述任务执行结束之后，当前线程才会继续往下执行。
    NSLog(@"Done!");
}

@end

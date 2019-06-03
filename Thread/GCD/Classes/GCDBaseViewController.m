//
//  GCDViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDBaseViewController.h"

@interface GCDBaseViewController ()

@end

//ignore selector unknown warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation GCDBaseViewController

- (IBAction)runClicked:(UIButton *)sender {
    SEL selector = NSSelectorFromString(self.selectorStr);
    if([self respondsToSelector:selector]) {
        SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:nil]);
    }
}

#pragma mark - dispatch_queue_t
/**
 串行队列 和 并发队列的区别？
    串行队列当中的任务是一个执行完成之后，才会接着执行下一个。
    并发队列当中的任务可以同一时刻执行多个。
 */
// 串行队列
- (void)serialQueue {
    // 获取串行队列的两种方式  1.系统提供  2.手动创建
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    
    // 队列的名称   "com.app.serial"
    // 用来识别是串行队列还是并发队列
    dispatch_queue_t queue2 = dispatch_queue_create("com.app.serial", DISPATCH_QUEUE_SERIAL);
    
    // dispatch_queue_get_label 获取队列的名称
    NSLog(@"%s__%s", dispatch_queue_get_label(queue1), dispatch_queue_get_label(queue2));
}

// 并发队列
- (void)concurrentQueue {
    // 获取并发队列的两种方式  1.系统提供  2.手动创建
    
    // (队列优先级, 第二个参数flags作为保留字段备用,一般都直接填0)
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t queue2 = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"%s__%s", dispatch_queue_get_label(queue1), dispatch_queue_get_label(queue2));
}

// 主队列  主队列是特殊的串行队列. 特殊点在 主队列中的操作，都会放到主线程中执行
- (void)mainQueue {
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"__%s__", dispatch_queue_get_label(queue));
}


#pragma mark - dispatch_sync + dispatch_async
/**
 同步执行 和 异步执行的区别？
    本质区别是：是否创建新线程对象。
 */

// 同步执行
- (void)sync {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    // 任务
    dispatch_block_t block = ^ {
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", [NSThread currentThread]);
    };
    dispatch_sync(queue, block);
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 异步执行
- (void)async {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    //队列
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    //任务
    dispatch_block_t block = ^ {
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"%@", [NSThread currentThread]);
    };
    
    dispatch_async(queue, block);
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

#pragma mark - 队列与执行方式的组合
// 同步执行 ➕ 并发队列
// 总结: 不开启新线程，在当前线程中依次执行。
- (void)syncAndConcurrent {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 异步执行 ➕ 并发队列
// 总结: 开启若干新线程，任务并发执行。
- (void)asyncAndConcurrent {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    // 第一个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 同步执行 ➕ 串行队列
// 总结: 不开启新线程，在当前线程中依次执行。 == 同步执行 ➕ 并发队列
- (void)syncAndSerial {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_SERIAL);
    
    // 第一个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

//异步执行 ➕ 串行队列
//总结: 开启一个新线程，任务依次执行。
- (void)asyncAndSerial {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_SERIAL);
    
    // 第一个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}


// 同步执行 ➕ 主队列 （在主线程会死锁导致应用crash)
- (void)syncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 第一个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_sync(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 同步执行 ➕ 主队列（在子线程中正常执行）
- (void)othersyncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(concurrentQueue, ^{
        // 第一个任务
        dispatch_sync(queue, ^{
            
            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        });
        
        // 第二个任务
        dispatch_sync(queue, ^{
            
            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        });
        
        // 第三个任务
        dispatch_sync(queue, ^{
            
            //这里线程暂停2秒,模拟一般的任务的耗时操作
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
        });
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// 异步执行 ➕ 主队列
- (void)asyncAndMain {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 第一个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}



@end

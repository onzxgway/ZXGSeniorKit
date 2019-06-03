//
//  GCDAPIViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDAPIViewController.h"

@interface GCDAPIViewController ()

@end

//ignore selector unknown warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation GCDAPIViewController

- (IBAction)clicked:(UIButton *)sender {
    SEL selector = NSSelectorFromString(self.selectorStr);
    if([self respondsToSelector:selector]) {
        SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:nil]);
    }
}

#pragma mark - dispatch_after
// 延时执行
// 需要注意的是: dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务dispatch_after函数是很有效的。
- (void)dispatch_after {
    
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步追加任务到主队列等待执行
        NSLog(@"----执行延时任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

#pragma mark - dispatch_once_t
// 可以用来初始化一些全局的数据，它能够确保block代码在app的生命周期内仅被运行一次，而且还是线程安全的，不需要额外加锁

/**
 static修饰的 long 类型变量onceToken 初始化的时候为0，线程A 执行block前，先判断onceToken 是否等于0 ?
 1.是就执行Block,并且把变量onceToken的值修改为非0，此时线程B想要执行block的话，也去判断onceToken的值是否等于0 ？
 2.否的话，线程就执行不了block
 */
- (void)dispatchOnce {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);
    dispatch_once(&onceToken, ^{
        NSLog(@"----执行单例任务---当前线程%@",[NSThread currentThread]);
        NSLog(@"%ld", onceToken);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

#pragma mark - dispatch_suspend
// 场景：当追加大量处理到Dispatch Queue时，在追加处理的过程中，有时希望不执行已追加的处理。例如演算结果被Block截获时，一些处理会对这个演算结果造成影响。在这种情况下，只要挂起Dispatch Queue即可。当可以执行时再恢复。
// 总结:dispatch_suspend，dispatch_resume 提供了“挂起、恢复”队列的功能，简单来说，就是可以暂停、恢复队列上的任务。但是这里的“挂起”，并不能停止队列上正在运行的任务，也就是如果挂起之前已经有队列中的任务在进行中，那么该任务依然会被执行完毕
- (void)dispatch_suspend {
    
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });
    
    //此时发现意外情况，挂起队列
    NSLog(@"suspend");
    dispatch_suspend(queue);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //恢复队列
        NSLog(@"resume");
        dispatch_resume(queue);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
    
}

#pragma mark - 队列激活
- (void)dispatch_queue_inactive {
    dispatch_queue_t queue = dispatch_queue_create("com.app.inactive", DISPATCH_QUEUE_CONCURRENT_INACTIVE);
    dispatch_async(queue, ^{
        NSLog(@"start:%@", [NSThread currentThread]);
    });
    dispatch_activate(queue); // 必须要激活
}

#pragma mark - dispatch_async_f
- (void)dispatch_async_f {
    dispatch_queue_t queue = dispatch_queue_create("com.app.current", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async_f(queue, nil, testFunction);
}

void testFunction() {
    NSLog(@"testFunction::-->%@", [NSThread currentThread]);
}

@end

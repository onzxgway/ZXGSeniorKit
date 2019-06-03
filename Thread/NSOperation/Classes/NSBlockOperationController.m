//
//  NSBlockOperationController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSBlockOperationController.h"

@interface NSBlockOperationController ()
@property (nonatomic, strong) NSOperationQueue *queue; // 并发队列
@property (nonatomic, strong) NSBlockOperation *operation;
@property (nonatomic, copy) dispatch_block_t block;
@end

@implementation NSBlockOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _block = ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"---%@---", [NSThread currentThread]); // 打印当前线程
        }
    };
    
//    [self method1];
//    [self method2];
}

#pragma mark - 需求一：当viewDidLoad时，在当前线程调用_block, 使用NSBlockOperation实现？
- (void)method1 {
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:_block];
    [operation start];

}

#pragma mark - 需求二：NSBlockOperation添加多个操作，观察每个操作的执行情况。
/**
 结论：
   一般情况下，如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。如果添加的操作的个数大于等于两个，就会自动开启新线程。当然开启的线程数是由系统来决定的。
 
 */
- (void)method2 {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 2.添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"7---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"8---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.调用 start 方法开始执行操作
    [op start];
    
}


#pragma mark - 需求三：A + B + C操作执行完成之后，再执行D + E操作？
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self doIt1];
}
// 需求三： 方式一： NSBlockOperation封装A + B + C操作，kvo监听isFinished属性，YES的话再执行封装D + E操作的NSBlockOperation对象。
- (void)doIt {
    // 任务
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work A done.", [NSThread currentThread]);
    }];
    
    void(^task)(void) = ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work B done.", [NSThread currentThread]);
    };
    [blockOperation addExecutionBlock:task];
    
    [blockOperation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work C done.", [NSThread currentThread]);
    }];
    
    // 监听NSOperation状态
    [blockOperation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    
    // 队列
    [self.queue addOperation:blockOperation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isFinished"]) {
        [self performDMehtod];
    }
}

- (void)performDMehtod {
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work D done.", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work E done.", [NSThread currentThread]);
    }];
    [self.queue addOperation:blockOperation];
}

// 需求三： 方式二：使用操作依赖功能
- (void)doIt1 {
    // 任务
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work A done.", [NSThread currentThread]);
    }];
    
    void(^task)(void) = ^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work B done.", [NSThread currentThread]);
    };
    [blockOperation addExecutionBlock:task];
    
    [blockOperation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work C done.", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work D done.", [NSThread currentThread]);
    }];
    
    [blockOperation1 addExecutionBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work E done.", [NSThread currentThread]);
    }];
    
    // 通过操作依赖可以实现先后顺序
    [blockOperation1 addDependency:blockOperation];
    
    // 队列
    [self.queue addOperation:blockOperation];
    [self.queue addOperation:blockOperation1];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     手动开启任务有两种方式：
        1.start
        2.main
     
     区别：start没有重复开启，因为在start方法里面对NSOperation的finish状态进行判断，
     如果finish=YES，就不会执行了。
        main直接是掉用block,不进行状态判断。
     */
//    [self.operation start];
//    [self.operation main];
}



- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

@end

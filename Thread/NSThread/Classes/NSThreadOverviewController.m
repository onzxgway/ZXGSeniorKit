//
//  NSThreadOverviewController.m
//  NSThread
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSThreadOverviewController.h"

@interface NSThreadOverviewController () {
    NSThread *_threadTwo;
}

@end

@implementation NSThreadOverviewController

/**
 
 NSThread是pthread面向对象的封装。
 
 NSThread实例是线程对象,对应一个线程。
    当执行完之后，不能重新开启(不能调用两遍start方法).
    可以重复调用main方法。
 */
/**
 
 常用：  1.[NSThread currentThread]    获取当前线程对象
        2.[NSThread sleepForTimeInterval:]; 进入休眠状态
        3.[NSThread sleepUntilDate:]
 
        4.performSelectorOnMainThread:
          performSelector:onThread:
          performSelectorInBackground:
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"NSThread是pthread面向对象的封装。";

//    [self classMethod];
    [self instanceMethod];
    
}

// 类方法创建的线程 自动执行
- (void)classMethod {
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"%@ My name is T-Mac.", [NSThread currentThread]);
    }];
    
    [NSThread detachNewThreadSelector:@selector(printName:) toTarget:self
                           withObject:@"kobe"];
}

// 实例方法创建的线程 必须手动才能执行
- (void)instanceMethod {
    NSThread *threadOne = [[NSThread alloc] initWithBlock:^{
        NSLog(@"%@ My name is 库里.", [NSThread currentThread]);
    }];
    threadOne.name = @"threadOne";
    [threadOne start];
//    [threadOne main]; // main方法表示在主线程执行
    
    _threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(printCount:) object:@88];
    _threadTwo.name = @"threadTwo";
    [_threadTwo start];
    
}

- (void)printName:(NSString *)name {
    NSLog(@"%@ My name is %@.", [NSThread currentThread], name);
}

- (void)printCount:(NSNumber *)count {
    
    for (NSInteger i = 0; i < [count integerValue]; ++i) {
        
        // 可以起到线程被取消的假象作用。本质上是线程执行完毕了。
        if ([NSThread currentThread].isCancelled) {
            break;
        }
        
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"go go go %@ .", [@(i) stringValue]);
        
    }

}

/**
 当前正在执行任务的线程对象，取消不掉。
 
 cancel方法的作用是： 状态标识
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_threadTwo cancel];
}

// 需求：用NSThread实现三个线程任务A，B，C，然后三个任务结束之后，执行D任务
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self doIt];
}

- (void)doIt {
    
    NSThread *one = [[NSThread alloc] initWithBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work A done.", [NSThread currentThread]);
    }];
    NSThread *two = [[NSThread alloc] initWithBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work B done.", [NSThread currentThread]);
    }];
    NSThread *three = [[NSThread alloc] initWithBlock:^{
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"%@ work C done.", [NSThread currentThread]);
    }];
    
//    // 监听状态
//    [one addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
//    // 监听状态
//    [two addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
//    // 监听状态
//    [three addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    
    [one start];
    [two start];
    [three start];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    static int count = 0;
    if ([keyPath isEqualToString:@"isFinished"] && [change valueForKey:NSKeyValueChangeNewKey]) {
        count ++;
        [self performDMehtod];
        NSLog(@"%@ observeValueForKeyPath", [NSThread currentThread]);
    }
}

- (void)performDMehtod {
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"%@ work D done.", [NSThread currentThread]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

//
//  ttViewController.m
//  GCD
//
//  Created by 朱献国 on 2020/10/18.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ttViewController.h"

@interface ttViewController (){
    NSMutableArray *_safeAry;
    dispatch_queue_t _queue;
}

@end

@implementation ttViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _safeAry = [NSMutableArray array];
    [_safeAry addObject:@"0"];
    [_safeAry addObject:@"1"];
    [_safeAry addObject:@"2"];
    [_safeAry addObject:@"3"];
    _queue = dispatch_queue_create("com.barrier1.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    [self demo];
}

/**
 多线程来操作可变数组mutableAry，肯定会出错，因为集合都是线程不安全的。
 解决方案：使用dispatch_barrier_async。 只要涉及到写操作（要做保护）
  */
- (void) demo {
    
    dispatch_queue_t queue = dispatch_queue_create("com.barrier2.concurrent", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 20; i++) {
        // 写
        dispatch_async(queue, ^{
            [self addObject:[NSString stringWithFormat:@"%d", i + 4]];
        });

        // 读
        dispatch_async(queue, ^{
            NSLog(@"%d::%@", i, [self indexTo:i]);
        });
    }
}

// 写 保证只有一个在操作（避免了同时多个写操作导致的问题）
- (void)addObject:(NSString *)object {
    dispatch_barrier_async(_queue, ^{
        if (object != nil) {
            [_safeAry addObject:object];
        }
    });
}

// 主队列中的任务必须由主线程执行
// 注意同步，因为业务关系，必须马上数据
- (NSString *)indexTo:(NSInteger)index {
    __block NSString *result = nil;
    dispatch_sync(_queue, ^{
        if (index < _safeAry.count) {
            result = _safeAry[index];
        }
    });
    return result;
}

@end

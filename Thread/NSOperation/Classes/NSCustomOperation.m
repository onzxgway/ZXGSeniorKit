//
//  NSCustomOperation.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSCustomOperation.h"

@implementation NSCustomOperation

@synthesize finished = _finished;

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"---%@---", [NSThread currentThread]);
        }
    }
    _finished = YES;
}

- (void)start {
    // 异常处理
    if (self.isFinished) {
        return;
    }
    if (self.isExecuting) {
        return;
    }
    
    [self main];
}


// 如果 dealloc 没被执行，就是因为 _finished = NO
- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end

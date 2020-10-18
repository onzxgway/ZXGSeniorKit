//
//  OtherViewController.m
//  GCD
//
//  Created by 朱献国 on 2020/10/18.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"dispatch_after";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self after];
//    [self queueInactive];
    [self timeSource];
}

// 延后
- (void)after {
    
    dispatch_queue_t queue = dispatch_queue_create("com.timer.concurrent", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"start:%@", [NSThread currentThread]);
        dispatch_after(1, queue, ^{
            NSLog(@"dispatch_after:%@", [NSThread currentThread]);
        });
        NSLog(@"end");
    });
}

// 激活
- (void)queueInactive {
    dispatch_queue_t queue = dispatch_queue_create("com.active.concurrent", DISPATCH_QUEUE_CONCURRENT_INACTIVE);
    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    dispatch_activate(queue);
}

// 定时器  unix (pthread) GCD()
dispatch_source_t source;
- (void)timeSource {
    // 1 创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("com.source.serial", DISPATCH_QUEUE_SERIAL);
    // io source关联到队列
    source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 配置soure的时间
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 1, 1);
    // 配置source的处理事件
    dispatch_source_set_event_handler(source, ^{
        NSLog(@"soure_event:==%@", [NSThread currentThread]);
    });
    // 开启定时器
    dispatch_resume(source);
}

@end

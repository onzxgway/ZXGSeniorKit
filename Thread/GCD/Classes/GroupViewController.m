//
//  GroupViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

@end

static NSString * const URLPath = @"http://svr.tuliu.com/center/front/app/util/updateVersions";

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"dispatch_queue_t";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dispatch_group_one];
//    [self dispatch_group_two];
    [self dispatch_group_three];
}

#pragma mark - ================ 一个界面执行多个网络请求解决方案 ================
// 一个界面执行多个网络请求有三种方式
// 1. 单用队列组。  2. 单用信号量。(没试过)   3.队列组搭配信号量。
#pragma mark - ================ 一个界面执行多个网络请求解决方案 ================

// 应用场景：一个页面多个网络请求
// dispatch_group_t 使用方式一
- (void)dispatch_group_one {
    
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.abc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("com.abcd", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    };
    
    dispatch_block_t block2 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    };
    
    dispatch_block_t block3 = ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    };
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue1, block1);
    dispatch_group_async(group, queue2, block2);
    dispatch_group_async(group, queue3, block3);
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"----执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

// dispatch_group_t 使用方式二
/**
 dispatch_group_enter 标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1
 dispatch_group_leave 标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1。
 当 group中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到dispatch_group_notify中的任务。
 
 个人理解：和内存管理的引用计数类似，我们可以假设group也持有一个整形变量，当调用enter时计数加1，调用leave时计数减1，当计数为0时会调用dispatch_group_notify
 */
- (void)dispatch_group_two {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group); // 组内任务数加一
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
        dispatch_group_leave(group); // 组内任务数减一
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行最后的汇总任务---当前线程%@", [NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}

/**
 以上两种基本使用方式注意事项：
 添加在队列中的任务，必须是同步的，不能再开启新线程，否则group会失效。
 
 如果一定要开启新线程，就搭配信号量使用，如下方式：
 */
- (void)dispatch_group_three {
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group); // 组内任务数加一
    dispatch_async(queue, ^{
        [self netLoadSync];
        dispatch_group_leave(group); // 组内任务数减一
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [self netLoadSync];
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        [self netLoadSync];
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"----执行最后的汇总任务---当前线程%@", [NSThread currentThread]);
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
}


// network
- (void)netLoadSync {
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?versions_id=1&system_type=1", URLPath];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    // 信号量：异步变同步。
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *infoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@_%@",[NSThread currentThread], infoDict.class);
        dispatch_semaphore_signal(sema);
    }];
    [task resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end

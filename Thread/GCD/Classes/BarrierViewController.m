//
//  BarrierViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "BarrierViewController.h"
#import "Person.h"

@interface BarrierViewController () {
    NSMutableArray *_safeAry;
    dispatch_queue_t _queue;
}
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation BarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"dispatch_barrier_";
    
    _safeAry = [NSMutableArray array];
    [_safeAry addObject:@"0"];
    [_safeAry addObject:@"1"];
    [_safeAry addObject:@"2"];
    [_safeAry addObject:@"3"];
    _queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    [self barrier_one];
//    [self dispatch_barrier_async];
}

#pragma mark - ========== dispatch_barrier_async 应用场景一 ==========
/**
 多线程来操作可变数组mutableAry，肯定会出错，因为集合都是线程不安全的。
 解决方案：使用dispatch_barrier_async。 只要涉及到写操作（要做保护）
  */
- (void)barrier_one {
    
    dispatch_queue_t queue = dispatch_queue_create("com.barrier.concurrent", DISPATCH_QUEUE_CONCURRENT);
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

#pragma mark - ========== dispatch_barrier_async 应用场景二 ==========
/**
 多线程来操作可变数组mutableAry，肯定会出错，因为集合都是线程不安全的。
 解决方案：使用dispatch_barrier_async。 只要涉及到写操作（要做保护）
 */
- (void)barrier_two {
    Person *p = [[Person alloc] init];
    p.queue = dispatch_queue_create("abbb", DISPATCH_QUEUE_CONCURRENT);
    [self updateContact:p contacts:self.dict];
}

/**
dispatch_barrier_async 与 dispatch_barrier_sync

共同点：
1、等待在它前面插入队列的任务先执行完
2、等待他们自己的任务执行完再执行后面的任务
不同点：
1、dispatch_barrier_sync将自己的任务插入到队列的时候，需要等待自己的任务结束之后才会继续插入被写在它后面的任务，然后执行它们
2、dispatch_barrier_async将自己的任务插入到队列之后，不会等待自己的任务结束，它会继续把后面的任务插入到队列，然后等待自己的任务结束后才执行后面任务。

用途：
在多个异步操作完成之后，统一的对非线程安全的对象进行更新操作
*/
- (void)updateContact:(Person *)person contacts:(NSDictionary *)contacts {
    
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < contacts.allKeys.count; ++i) {
        NSString *key = [contacts.allKeys objectAtIndex:i];
        NSString *value = [contacts objectForKey:key];
        
        dispatch_group_async(group, _queue, ^{
            [person setProperty:key email:value];
        });
        
    }
    dispatch_group_notify(group, _queue, ^{
        NSLog(@"==> Final %@", person);
    });
}

- (NSMutableDictionary *)dict {
 if (!_dict) {
     _dict = [@{
         @"Goodguy" : @"crafttang@gmail.com",
         @"Leijun" : @"leijun@mi.com",
         @"Yuchengdong" : @"yuchengdong@huawei.com",
         @"Luoyonghao" : @"luoyonghao@smartisan.com",
         } mutableCopy];
     }
     return _dict;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self barrier_One];
//    [self barrier_two];
}

// 隔断方法：当前面的写入操作全部完成之后，再执行后面的读取任务。当然也可以用Dispatch Group和dispatch_set_target_queue,只是比较而言 dispatch_barrier_async 会更加顺滑
/**
 dispatch_barrier_async 相当于一个分界线，
 分界线前面任务先执行，分界线里面的任务再执行，分界线后面的任务最后执行。
 （栅栏内部队列，可以看成串行的，依序执行）
 */
- (void)dispatch_barrier_async {
    
    NSLog(@"__BEGIN:%@__", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        
        NSLog(@"----执行第一个写入任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"----执行第二个写入任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"----等待前面的任务完成 一阶段---当前线程%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"----等待前面的任务完成 二阶段---当前线程%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        // 第一个读取任务
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"----执行第一个读取任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        // 第二个读取任务
        [NSThread sleepForTimeInterval:3];
        
        NSLog(@"----执行第二个读取任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    NSLog(@"__END:%@__", [NSThread currentThread]);
    
}

// 栅栏
- (void)barrier_One {
    dispatch_queue_t queue = dispatch_queue_create("com.app.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskOne");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskTwo");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskThree");
    });
    
    dispatch_barrier_async(queue, ^{ // 分界线里面，queue可以看作是串行的，当前只能执行barrier里面的task
        NSLog(@"分界线里面的任务");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFour");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFive");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskSix");
    });
}

// 栅栏
- (void)barrier_Two {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskOne");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskTwo");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线前：taskThree");
    });
    
    dispatch_barrier_sync(queue, ^{ // 分界线里面，queue可以看作是串行的，当前只能执行barrier里面的task
        NSLog(@"分界线里面的任务");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFour");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskFive");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"分界线后：taskSix");
    });
}


@end

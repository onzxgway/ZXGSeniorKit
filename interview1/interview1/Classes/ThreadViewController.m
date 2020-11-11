//
//  ThreadViewController.m
//  interview1
//
//  Created by 朱献国 on 2020/11/10.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController () {
    NSMutableArray *_eocAry;
    dispatch_queue_t _queue;
}
@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorRandomColor;
    self.navigationItem.title = @"面试题线程部分专题";
    
    _eocAry = [NSMutableArray array];
    _queue = dispatch_queue_create("com.app.con2", DISPATCH_QUEUE_CONCURRENT);
}

#pragma mark - 1.下载一个很大的图片，需要分成多份进行下载，使用GCD该如何实现？使用什么队列？
/*
 答案：
 并发队列 + 异步
 
 假如分三次来进行下载，net1，net2，net3
 
 笨的方法，net1完成的时候，去判断net2，net3是否完成，
 当net2完成的时候，去判断net1，net3是否完成
 当net3完成的时候，去判断net1，net2是否完成
 当所有的任务完成的时候，去通知图片已经下载完了
 
 好的方法，使用CGD 的 队列组（dispatch_group_t）的技术点，伪代码如下。
 
 group是组的意思，可以看作当前任务计数，当任务数为0时，就执行dispatch_group_notify
 dispatch_group_enter 当前任务数+1
 dispatch_group_leave 当前任务数-1
 */
// 伪代码
- (void)groupGCD {
    
    dispatch_group_t group = dispatch_group_create();

    for (NSInteger i = 0; i < 3; i++) {
        dispatch_group_enter(group);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(random()%5); // 当作在下载网络数据
            NSLog(@"完成任务:%@", [NSString stringWithFormat:@"http://load_%ld.img", i]);
            // 完成网络操作 group leave
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有任务都完成, 合成图片");
    });
    
}

// 追问一：网络怎么来操作？（一个url地址，怎么设置分三次）设置网络的请求头参数 head（Range）
// 如果这个图片有15MB， Net1 head->range =（0-5MB）， Net2 head->range =（5-10MB),  Net3 head->range =（10-15MB)； 5MB = 1024*1024*5B。

// 追问二：沙盒存放位置（文件很大document（默认备份）（非备份backup处理，审核））

// 追问三：下载任务是否开的越多，下载得越快（网速只有1MB， 争夺资源反而会降低速度）（当前任务不止这个下载图片的任务，其他的业务也起开了其他下载开了7个网络任务， 3+7 = 10， 10 去抢1MB，）

// 追问四：图片data1 图片data2 图片ata3  [[图片data1 appendData:图片data2] appendData:图片data3]

#pragma mark - GCD如何实现数组、字典、集合的多线程安全读写?
/*
答案：
使用CGD 的 栅栏（dispatch_barrier_async）的技术点，代码如下。
 
 栅栏前面任务先执行，栅栏内部任务串行执行，栅栏后面任务最后执行。
*/
// 写操作
- (void)addObject:(NSString *)obj {
    
    // 当obj是mutable可变的对象， 防止在外部马上发生变化  本来要存@“11”， 刚好调用addObject方法的后，变成@“1123”  【cc addObject:@"11"】；
    // 串行队列，当前只有这个任务在执行
    
    obj = [obj copy]; //obj mutable 用copy 防止对象是mutable.再添加的过程中防止本身的可变操作
    dispatch_barrier_async(_queue, ^{
        if (obj != nil) {
            [_eocAry addObject:obj];
        }
    });
}

// 读操作
- (NSString *)objectForIndex:(NSInteger)index {
    //这里是同步的 读操作要把对象返回
    __block NSString *result = nil;
    dispatch_sync(_queue, ^{
        if (index < _eocAry.count) {
            result = _eocAry[index];
        }
    });
    return result;
}

//1 对写进行保护（当有一个线程在写时，其他线程即不能写，也不能读）。
//2 多线程可以一起读线程不安全的集合。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    dispatch_queue_t queue = dispatch_queue_create("com.app.con1", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 50; i++) {
        dispatch_async(queue, ^{
            [self addObject:[@(i) description]];
        });
        dispatch_async(queue, ^{
            NSLog(@"%d::%@", i ,[self objectForIndex:i]);
        });
    }
    
}

@end

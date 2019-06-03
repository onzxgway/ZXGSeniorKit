//
//  ViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "GCDBaseTableViewController.h"
#import "GCDBaseViewController.h"

@interface GCDBaseTableViewController ()

@end

@implementation GCDBaseTableViewController

/**
 3.队列组 (一个页面多个网络请求) + 信号量组合使用
 4.barrier
 5.重复
 6.延后
 7.激活
 8.dispatch_async_f
 9.定时器
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t queue = dispatch_queue_create("abc", DISPATCH_QUEUE_CONCURRENT);
    // 主队列里面的任务必须是主线程执行。
    // 但是主线程可以执行任意队列的任务。
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    NSLog(@"end ");
    
    self.arrs =  @[
                   @{
                       @"title"   : @"队列",
                       @"children": @[
                               @{@"title"   : @"串行队列",
                                 @"children": @"",
                                 @"selector": @"serialQueue"},
                               @{@"title"   : @"并发队列",
                                 @"children": @"",
                                 @"selector": @"concurrentQueue"},
                               @{@"title"   : @"主队列",
                                 @"children": @"",
                                 @"selector": @"mainQueue"}
                               ]
                       },
                   @{
                       @"title"   : @"任务添加到队列的方式",
                       @"children": @[
                               @{@"title"   : @"同步执行",
                                 @"children": @"",
                                 @"selector": @"sync"},
                               @{@"title"   : @"异步执行",
                                 @"children": @"",
                                 @"selector": @"async"}
                               ]
                       },
                   @{
                       @"title"   : @"队列与执行方式的组合",
                       @"children":@[
                               @{@"title"   : @"同步执行 ➕ 并发队列",
                                 @"children": @"",
                                 @"selector": @"syncAndConcurrent"},
                               @{@"title"   : @"异步执行 ➕ 并发队列",
                                 @"children": @"",
                                 @"selector": @"asyncAndConcurrent"},
                               @{@"title"   : @"同步执行 ➕ 串行队列",
                                 @"children": @"",
                                 @"selector": @"syncAndSerial"},
                               @{@"title"   : @"异步执行 ➕ 串行队列",
                                 @"children": @"",
                                 @"selector": @"asyncAndSerial"},
                               @{@"title"   : @"同步执行 ➕ 主队列（在主线程中）",
                                 @"children": @"",
                                 @"selector": @"syncAndMain"},
                               @{@"title"   : @"同步执行 ➕ 主队列 （在子线程中）",
                                 @"children": @"",
                                 @"selector": @"othersyncAndMain"},
                               @{@"title"   : @"异步执行 ➕ 主队列",
                                 @"children": @"",
                                 @"selector": @"asyncAndMain"}
                               ]
                       },
                   ];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.arrs[section] objectForKey:@"children"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"commonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *arr = [self.arrs[indexPath.section] objectForKey:@"children"];
    NSDictionary *dict =  arr[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.arrs[section] objectForKey:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GCDBaseViewController *vc = [[GCDBaseViewController alloc] init];
    NSArray *arr = [self.arrs[indexPath.section] objectForKey:@"children"];
    vc.selectorStr = [arr[indexPath.row] objectForKey:@"selector"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  NSCustomOperationController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSCustomOperationController.h"
#import "NSCustomOperation.h"

@interface NSCustomOperationController () {
    NSOperationQueue *_queue;
}

@end

@implementation NSCustomOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _queue = [[NSOperationQueue alloc] init]; // 0.并发队列
    
//    [_queue addOperation:operation];    // 2.自动执行
    [self method1];
}

- (void)method1 {
    NSCustomOperation *operation = [[NSCustomOperation alloc] init];
    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

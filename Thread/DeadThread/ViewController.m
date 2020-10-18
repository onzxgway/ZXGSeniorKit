//
//  ViewController.m
//  DeadThread
//
//  Created by 朱献国 on 2020/10/18.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSPort *_port;
    NSTimer *_timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSThread detachNewThreadSelector:@selector(ThreadTwo) toTarget:self withObject:nil];
}

- (void)ThreadOne {
    NSLog(@"start");
    
    [self performSelector:@selector(method_one) withObject:nil afterDelay:2];
    
    _port = [[NSPort alloc] init];
    [[NSRunLoop currentRunLoop] addPort:_port forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end");
}

- (void)method_one {
    [[NSRunLoop currentRunLoop] removePort:_port forMode:NSDefaultRunLoopMode];
    NSLog(@"%s", __func__);
}

- (void)ThreadTwo {
    
    NSLog(@"start");
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end");
}

- (void)stopTimer {
    
    NSLog(@"stopTimer");
    static int count = 0;
    count++;
    if (count > 5) {
        [_timer invalidate];
    }
    
}

@end

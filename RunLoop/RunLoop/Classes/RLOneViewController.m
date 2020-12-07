//
//  RLOneViewController.m
//  RunLoop
//
//  Created by 朱献国 on 2020/12/4.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "RLOneViewController.h"

@interface RLOneViewController ()

@end

@implementation RLOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self demo];
}

- (void)demo {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (activity == kCFRunLoopEntry) {
            NSLog(@"kCFRunLoopEntry");
        } else if (activity == kCFRunLoopBeforeTimers) {
            NSLog(@"kCFRunLoopBeforeTimers");
        } else if (activity == kCFRunLoopBeforeSources) {
            NSLog(@"kCFRunLoopBeforeSources");
        } else if (activity == kCFRunLoopBeforeWaiting) {
            NSLog(@"kCFRunLoopBeforeWaiting");
        } else if (activity == kCFRunLoopAfterWaiting) {
            NSLog(@"kCFRunLoopAfterWaiting");
        } else if (activity == kCFRunLoopExit) {
            NSLog(@"kCFRunLoopExit");
        }
    });
    // 监听主线程的RunLoop状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
}

@end

//
//  RLZeroViewController.m
//  RunLoop
//
//  Created by 朱献国 on 2020/12/4.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "RLZeroViewController.h"

@interface RLZeroViewController ()

@end

@implementation RLZeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo];
}

- (void)demo {
    CFRunLoopRun();
}


@end

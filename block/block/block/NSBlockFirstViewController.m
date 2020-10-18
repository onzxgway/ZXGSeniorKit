//
//  NSBlockFirstViewController.m
//  block
//
//  Created by 朱献国 on 2020/10/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "NSBlockFirstViewController.h"
#import <objc/runtime.h>

@interface NSBlockFirstViewController ()

@end

@implementation NSBlockFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self learn];
}

- (void)learn {
    // 一
    NSInteger i = 10;
    void(^blockOne)(void) = ^{
        NSLog(@"%zd", i);
    };
    NSLog(@"%s", object_getClassName(blockOne));
    
    // 二
    void(^blockTwo)(void) = ^{

    };
    NSLog(@"%s", object_getClassName(blockTwo));

    // 三
    void(^blockThree)(void) = [blockOne copy];
    NSLog(@"%s", object_getClassName(blockThree));
}

@end

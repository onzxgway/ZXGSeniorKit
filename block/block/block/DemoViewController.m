//
//  DemoViewController.m
//  block
//
//  Created by 朱献国 on 2020/10/11.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoViewController.h"

typedef void(^TestBlock)(void);

@interface DemoViewController ()

@property(nonatomic, strong)TestBlock strongBlock;
@property(nonatomic, copy)TestBlock copyBlock;
@property(nonatomic, weak)TestBlock weakBlock;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int tempV = 100;
    _strongBlock = ^{
        NSLog(@"_strongBlock %d", tempV);
    };
    _copyBlock = ^{
        NSLog(@"_copyBlock %d", tempV);
    };
    _weakBlock = ^{
        NSLog(@"_weakBlock %d", tempV);
    };
    
    NSLog(@"_strongBlock copy %s", object_getClassName([_strongBlock copy]));
    NSLog(@"_copyBlock copy %s", object_getClassName([_copyBlock copy]));
    NSLog(@"_weakBlock copy %s", object_getClassName([_weakBlock copy]));
}

@end

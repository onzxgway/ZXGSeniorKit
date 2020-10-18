//
//  BlockCycleRefrenceViewController.m
//  Block原理VIP
//
//  Created by 八点钟学院 on 2017/4/25.
//  Copyright © 2017年 八点钟学院. All rights reserved.
//

#import "BlockCycleRefrenceViewController.h"
#include <objc/runtime.h>

typedef void(^cycleBlock)();
@interface BlockCycleRefrenceViewController () {
    
    cycleBlock blk;
    NSObject *object;
    
}

@end

@implementation BlockCycleRefrenceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self weakCycleBlockFunctionThree];
    
}

- (void)weakCycleBlockFunction {
    
    NSObject *otherObject = [[NSObject alloc] init];
    NSLog(@"object %p &object %p", otherObject, &otherObject);
    
    blk = ^{
        
        NSLog(@"object %p &object %p", otherObject, &otherObject);
        
    };
    
    blk();
    otherObject = nil;
    blk();
    
}

- (void)weakCycleBlockFunctionTwo {
    
    NSObject *otherObject = [[NSObject alloc] init];
    NSLog(@"object %p &object %p", otherObject, &otherObject);
    
    __weak typeof(otherObject)weakObject = otherObject;
    blk = ^{
        __strong typeof(weakObject)strongObject = weakObject;
        NSLog(@"object %p &object %p", strongObject, &strongObject);
        
    };
    
    blk();
    otherObject = nil;
    blk();
    
}

- (void)weakCycleBlockFunctionThree {
    
    NSObject *otherObject = [[NSObject alloc] init];
    NSLog(@"object %p &object %p", otherObject, &otherObject);
    
    __weak typeof(otherObject)weakObject = otherObject;
        
    blk = ^{
        __strong typeof(weakObject)strongObject = weakObject;
        
        if (strongObject) {
            
            NSLog(@"object %p &object %p", strongObject, &strongObject);
            
            sleep(3);
            NSLog(@"object %p &object %p", strongObject, &strongObject);
            
        }
        
    };
    
    blk();
    otherObject = nil;
    sleep(5);
//    blk();
    
}

- (void)strongCycleBlockFunction {
    
    object = [[NSObject alloc] init];
    NSLog(@"object %p &object %p", object, &object);

    //对于成员变量，block是把self引用计数+1，不是对成员变量object本身来增加引用计数的
    blk = ^{
        
        NSLog(@"object %p &object %p", object, &object);
        
    };
    
    blk();
    object = nil;
    blk();
    
}

- (void)dealloc {
    
    NSLog(@"dealloc");
    
}

@end

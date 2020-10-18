//
//  DemoViewController.m
//  NSOperation
//
//  Created by 朱献国 on 2020/10/17.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (nonatomic, strong) NSInvocation *invocation;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self demo];
    
    [NSThread detachNewThreadWithBlock:^{
        NSString *rst = [self name:@"kobe" age:@"40" sex:@"man"];
        NSLog(@"%@", rst);
    }];
}

- (void)demo {
    // 方法签名 （方法的对象化，包括相关的结构信息：返回值，调用者，方法名，参数）
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(name:age:sex:)];
    
    // NSInvocation作用是把方法对象化
    self.invocation = [NSInvocation invocationWithMethodSignature:signature];
    /**
     <NSInvocation: 0x604000471ac0>
     return value: {@} 0x0
     target: {@} 0x0
     selector: {:} null
     argument 2: {@} 0x0
     argument 3: {@} 0x0
     argument 4: {@} 0x0
     */
    self.invocation.target = self;
    self.invocation.selector = @selector(name:age:sex:);
    // 和签名的seletor要对应起来
    // 配置参数
    NSString *name = @"kobe";
    NSString *age = @"40";
    NSString *sex = @"man";
    [self.invocation setArgument:&name atIndex:2];
    [self.invocation setArgument:&age atIndex:3];
    [self.invocation setArgument:&sex atIndex:4];
    //    [self.invocation invoke]; // 调用方法
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:self.invocation];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    [operation addObserver:self forKeyPath:@"finished" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSString *)name:(NSString *)name age:(NSString *)age sex:(NSString *)sex {
    NSLog(@"name: age: sex:%@", [NSThread currentThread]);
    return [NSString stringWithFormat:@"%@-%@-%@", name, age, sex];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"finished"] && [change valueForKey:NSKeyValueChangeNewKey]) {
        __unsafe_unretained NSString *returnValue;
        [self.invocation getReturnValue:&returnValue];
        NSLog(@"returnValue:%@", returnValue);
    }
}

@end

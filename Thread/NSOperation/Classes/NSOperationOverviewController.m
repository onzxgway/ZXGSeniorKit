//
//  NSOperationOverviewController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSOperationOverviewController.h"

@interface NSOperationOverviewController ()

@end

@implementation NSOperationOverviewController

/**
 NSOperation 是个抽象类。 用来约束公共的行为。 实际使用它的子类。
    系统提供了两个子类 NSBlockOperation 和 NSInvocationOperation 供使用。
    也可以自定义子类。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"NSOperation、NSOperationQueue是GCD面向对象的封装。";
    
    self.descLab.text = @"NSOperation 是个抽象类。 用来约束公共的行为。 实际使用它的子类。 \n 系统提供了两个子类 NSBlockOperation 和 NSInvocationOperation 供使用。 \n 也可以自定义子类。";
    
    self.detailLab.text = @""; // \n线程执行NSOperation实例，执行结束之后，它的_finished状态 = YES，然后NSOperation对象实例释放。
    
    [self overview];
}

// NSOperation、NSOperationQueue、NSOperationQueue + NSOperation 使用方式？
- (void)overview {
    
    // ***一：NSOperation + NSOperationQueue组合的基本使用方式：
        // 1.创建操作：一个NSOperation实例。
        // 2.创建队列：一个NSOperationQueue实例。
        // 3.将操作加入到队列中：将 NSOperation实例添加到 NSOperationQueue实例对象中。
    
    // ***二：NSOperation单独使用，调用start方法。
    //        在没有使用NSOperationQueue的前提下，NSOperation单独使用，调用start方法时是否开启新线程，取决于操作的个数。如果添加的操作的个数是一个的话，调用start方法时，任务在当前线程执行。如果添加的操作个数大于等于两个，就会自动开启新线程。
    
    // ***三：NSOperationQueue单独使用，调用[queue addOperationWithBlock:]。
    //     使用 addOperationWithBlock: 将操作加入到操作队列后能够开启新线程，进行并发执行。相当于直接往队列添加操作。
}

// NSOperationQueue的拓展功能？
- (void)additionalFunctionality {
    /**
     1. 最大并发操作数。maxConcurrentOperationCount
        自定义队列，可以通过控制最大并发操作数，来实现串行和并发的功能。
     2.
     */
    
}

// NSOperation的拓展功能？
- (void)additionalFunction {
    /**
     1. NSOperation 操作依赖。
     2. NSOperation 优先级。
     */
    
}

// NSBlockOperation 、 NSInvocationOperation 和 NSCustomOperation 的区别？
- (void)differenceBetweenOperation {
    /**
     共同点：
        NSInvocationOperation类只能封装一个操作，所以当调用start方法时，任务在当前线程执行。（没有使用新线程对象）
        NSBlockOperation是否开启新线程，取决于操作的个数。如果添加的操作的个数是一个的话，调用start方法时，任务在当前线程执行。如果添加的操作个数大于等于两个，就会自动开启新线程。
        NSCustomOperation调用start方法时，任务在当前线程执行。(没有开启新线程)
     
     区别：
        1. NSBlockOperation可以添加多个操作。NSInvocationOperation 和NSCustomOperation只能添加一个操作。
     */

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

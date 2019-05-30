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
    
    self.titleLab.text = @"NSOperation是GCD面向对象的封装。";
    
    self.descLab.text = @"NSOperation 是个抽象类。 用来约束公共的行为。 实际使用它的子类。 \n 系统提供了两个子类 NSBlockOperation 和 NSInvocationOperation 供使用。 \n 也可以自定义子类。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

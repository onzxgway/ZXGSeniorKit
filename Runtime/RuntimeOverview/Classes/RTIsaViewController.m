//
//  RTIsaViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/25.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RTIsaViewController.h"

@interface RTIsaViewController ()

@end

@implementation RTIsaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"Objective-C是一门面向对象的编程语言，每个对象都是一个类的实例。每个对象的内部都有一个名为isa的指针，指向该对象所属的类。";
    self.descLab.text = nil;
    self.detailLab.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

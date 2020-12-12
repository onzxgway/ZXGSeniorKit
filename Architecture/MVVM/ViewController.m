//
//  ViewController.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "MVVMViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 MVVM是Model-View-ViewModel的简写。
 
 MVVM在使用当中，通常还会利用双向绑定技术，使得Model变化时，ViewModel会自动更新，而 ViewModel变化时，View也会自动变化。所以，MVVM模式有些时候又被称作：Model-View-Binder模式。
 
 具体在iOS中，可以使用KVO或Notification技术达到这种效果。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MVVMViewController *viewController = [[MVVMViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end

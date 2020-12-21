//
//  ViewController.m
//  KVOAndKVC
//
//  Created by 朱献国 on 2020/12/6.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
#import "KVCViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Animal *animal = [[Animal alloc] init];
    animal.name = @"Panda";
    
    [animal addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [animal willChangeValueForKey:@"name"];
    [animal didChangeValueForKey:@"name"];
//    animal.name = @"Mouse";
    
    [animal removeObserver:self forKeyPath:@"name" context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"KVC" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(30, 120, 40, 20);
    [btn addTarget:self action:@selector(kvcEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

- (void)kvcEvent {
    KVCViewController *ctr = [KVCViewController new];
    [self.navigationController pushViewController:ctr animated:true];
}

@end

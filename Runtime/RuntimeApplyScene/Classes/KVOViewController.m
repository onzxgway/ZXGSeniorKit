//
//  KVOViewController.m
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/2.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"

@interface KVOViewController ()

@property (strong,nonatomic)Person *person;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifiNameBtn];
    [self.person zxg_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.person) {
        NSLog(@"%zd",self.person.age);
    }
}

// 修改Person的name属性的按钮
- (void)modifiNameBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 180, 56);
    [self.view addSubview:btn];
    [btn setTitle:@"修改Person的name属性" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(modifiNameValue) forControlEvents:UIControlEventTouchUpInside];
}

//修改Person的name属性的值
- (void)modifiNameValue {
    self.person.age = arc4random_uniform(100);//会随机返回一个0到上界之间（不含上界）的整数，以2为上界会得到0或1。
}

#pragma mark - lazy load
- (Person *)person {
    if (!_person) {
        _person = [[Person alloc] init];
    }
    return _person;
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age" context:nil]; // 一定不要忘了，移除观察者，谁添加谁移除
}

@end

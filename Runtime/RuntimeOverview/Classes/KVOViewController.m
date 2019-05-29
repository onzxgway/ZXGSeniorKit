//
//  KVOViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "KVOViewController.h"
#import "DemoClass.h"
#import "DemoClass+Test.h"

@interface KVOViewController ()
@property (nonatomic, strong) DemoClass *obj;
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
    [self modifiNameBtn];
    [self KVOBaseIMP];
}

// 需求：实现和系统KVO相同的功能。 监听 DemoClass 的name属性值的改变。
/**
 系统KVO实现原理：
 
 0,系统自动新建一个被监听类的子类，重写被监听属性的set方法
 1,修改被监听对象的isa指针的值，让它指向子类对象。
 */
/**
 使用KVO注意事项：
    根据底层实现原理可知，要想触发KVO，必须通过成员变量的setter方法，给成员变量赋值。
 */
- (void)KVOBaseIMP {
    [self.obj custom_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.obj && [keyPath isEqualToString:@"name"]) {
        NSLog(@"NewValue %@", self.obj.name);
    }
}

- (void)dealloc {
    [self.obj removeObserver:self forKeyPath:@"name" context:nil];// 一定不要忘了，移除观察者,谁添加谁移除
}

// 修改Person的name属性的按钮
- (void)modifiNameBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 180, 56);
    [self.view addSubview:btn];
    [btn setTitle:@"修改DemoClass的name属性" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(modifiNameValue) forControlEvents:UIControlEventTouchUpInside];
}

// 修改Person的name属性的值
- (void)modifiNameValue {
    self.obj.name = [NSString stringWithFormat:@"kobe_%ud", arc4random_uniform(100)];//会随机返回一个0到上界之间（不含上界）的整数，以2为上界会得到0或1。
}

- (DemoClass *)obj {
    if (!_obj) {
        _obj = [DemoClass new];
    }
    return _obj;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ForwardViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2020/12/12.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ForwardViewController.h"
#import "ForwardObject.h"

@interface ForwardViewController ()

@end

@implementation ForwardViewController

// 向一个对象发送一条错误的消息，并查看一下_objc_msgForward是如何进行转发的。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ForwardObject *obj = [[ForwardObject alloc] init];
    [obj performSelector:@selector(test)];
}



@end

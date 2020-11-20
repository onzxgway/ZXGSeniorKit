//
//  DataStructureViewController.m
//  Algorithm
//
//  Created by 朱献国 on 2020/11/17.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DataStructureViewController.h"

@interface DataStructureViewController ()

@end

@implementation DataStructureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)stack {
    // 栈：先进后出
    // 时间复杂度O(1)
    // 压栈push,出栈pop
    // 入栈顺序是唯一的，出栈顺序是多种的。
    // 例如：入栈序列为（1，2，3，4，5），出栈序列为（4，5，3，2，1），也可为（3，2，1，4，5）
    // 用两个栈实现一个队列。
    // 解决方式：栈一只入，栈二只出。
    
    // 最大值操作。
    // 再来一个栈，记录当时的最大值。
}

- (void)queue {
    // 队列：先进先出
    // 入队in，出队out
    // 用两个队列实现一个栈。
    // 例如：入栈序列为(3，4，5，2，7),出栈序列为(7，2，5，4，3)
    // 解决方式：队一只入(每次入之前都是空)，队二只出。
}

- (void)array {
    // 连续的空间。
    // 下标取，修改，时间复杂度O(1)，插入，删除，新增时间复杂度O(n)。
}

- (void)linkArray {
    // 单向链表、双向链表、环链表
    // 查找时间复杂度O(n)，删除，新增时间复杂度O(1)。
}

@end

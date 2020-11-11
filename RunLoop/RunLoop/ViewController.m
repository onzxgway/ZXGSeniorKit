//
//  ViewController.m
//  RunLoop
//
//  Created by 朱献国 on 2020/11/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "AMPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AMPerson *p1 = [[AMPerson alloc] init];
    AMPerson *p2 = [[AMPerson alloc] init];
    AMPerson *p3 = [[AMPerson alloc] init];

    NSArray *ps = @[p1, p2, p3];
    NSArray *psCopy = [[NSMutableArray alloc] initWithArray:ps copyItems:YES];//复制

    NSLog(@"p = %p, pCopy = %p", ps, psCopy);
    NSLog(@"p = %p, pCopy = %p", ps[0], psCopy[0]);
}

//

@end

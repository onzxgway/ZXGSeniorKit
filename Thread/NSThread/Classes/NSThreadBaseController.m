//
//  NSThreadBaseController.m
//  NSThread
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSThreadBaseController.h"

@interface NSThreadBaseController ()

@end

@implementation NSThreadBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self totalInit];
}

- (void)totalInit {
    self.navigationItem.title = @"NSThread";
    self.view.backgroundColor = UIColorRandomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

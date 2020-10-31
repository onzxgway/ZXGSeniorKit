//
//  RuntimeBaseController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/24.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RuntimeBaseViewController.h"

@interface RuntimeBaseViewController ()

@end

@implementation RuntimeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self totalInit];
}

- (void)totalInit {
    self.navigationItem.title = @"Runtime";
    self.view.backgroundColor = UIColorRandomColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

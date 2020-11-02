//
//  BaseViewController.m
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/2.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self totalInit];
}

- (void)totalInit {
    self.navigationItem.title = @"Runtime";
    self.view.backgroundColor = UIColorRandomColor;
}

@end

//
//  DemoViewController.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"

@interface DemoViewController ()

@end

/*
 1，界面的生命周期控制。
 2，业务间切换控制。
 */
@implementation DemoViewController {
    DemoView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refreshAction)];
    
    // 视图层
    _tableView = [[DemoView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}

- (void)refreshAction {
    [_tableView refreshData];
}

@end

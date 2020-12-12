//
//  MVVMViewController.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"

@interface MVVMViewController ()

@property (nonatomic) MVVMViewModel *viewModel;
@property (nonatomic) MVVMView *mView;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 视图层
    [self.view addSubview:self.mView];
    // 视图层 与 视图模型层 建立关系
    [self.viewModel configView:self.mView];
    [self.viewModel requestData:nil];
}

#pragma mark - lazy loading
- (MVVMViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MVVMViewModel alloc] init];
    }
    return _viewModel;
}

- (MVVMView *)mView {
    if (!_mView) {
        _mView = [[MVVMView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _mView;
}

@end

//
//  ApplyViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"应用场景 请查看RuntimeApplyScene.Target";
    self.descLab.text = @"";
    self.detailLab.text = @"";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 应用间跳转
    // 1.配置跳转目标App的 URL Schemes
    // 2.iOS 9及之后，配置当前App的info.plist文件，添加允许跳转白名单。
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"runtimebb://"]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"runtimebb://"] options:nil completionHandler:nil];
        } else {
    
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

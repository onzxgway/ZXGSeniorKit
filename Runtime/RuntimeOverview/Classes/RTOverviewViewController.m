//
//  RTOverviewViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/25.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RTOverviewViewController.h"
#import <objc/message.h>

@interface RTOverviewViewController ()

@end

@implementation RTOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSub];
    
    self.titleLab.text = @"Runtime(运行时)是一套底层的C语言的API,OC代码的底层都是基于它来实现的。比如：";
    self.descLab.text = @"// 发送消息 \n [objc message]; \n\n // 编译器转化为底层运行时：\n objc_msgSend(objc, @selector(message)); \n\n // 如果还有参数：\n [objc message:(id)arg...]; \n\n // 编译器转化为底层运行时：\n objc_msgSend(objc, @selector(message), arg1, arg2, ...)";
    self.detailLab.text = @"Objective-C是一门动态的语言，它会将一些工作放在代码运行时处理而非编译时，也就是说，有很多类和成员变量在我们编译时是不知道的，而在运行时，我们所编写的代码会转换成完整的确定的代码运行。\n因此，编译器是不够的，我们还需要一个Runtime(运行时系统)来处理编译后的代码。";
    
}

- (void)layoutSub {
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.descLab];
    [self.view addSubview:self.detailLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(24.f);
#pragma clang diagnostic pop
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_lessThanOrEqualTo(self.view.mas_bottom).mas_offset(-97.f);
        
        make.right.mas_lessThanOrEqualTo(self.view.mas_right).mas_offset(-18.f);
        make.left.mas_greaterThanOrEqualTo(self.view.mas_left).mas_offset(18.f);
    }];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(14.f);
        make.right.mas_equalTo(self.titleLab.mas_right);
        make.left.mas_equalTo(self.titleLab.mas_left);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLab.mas_bottom).mas_offset(14.f);
        make.right.mas_equalTo(self.titleLab.mas_right);
        make.left.mas_equalTo(self.titleLab.mas_left);
    }];
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = UIColorHex(#FFFFFF);
        lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        
        _titleLab = lab;
    }
    return _titleLab;
}

- (UILabel *)descLab {
    if (!_descLab) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = UIColorHex(#999999);
        lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.f];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        
        lab.backgroundColor = [UIColor blackColor];
        
        _descLab = lab;
    }
    return _descLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = UIColorHex(#FFFFFF);
        lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        
        _detailLab = lab;
    }
    return _detailLab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

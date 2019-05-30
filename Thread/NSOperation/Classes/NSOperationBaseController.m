//
//  NSOperationBaseController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "NSOperationBaseController.h"

@interface NSOperationBaseController ()

@end

@implementation NSOperationBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self totalInit];
    [self layoutSub];
}

- (void)totalInit {
    self.navigationItem.title = @"NSOperation";
    self.view.backgroundColor = UIColorRandomColor;
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

@end

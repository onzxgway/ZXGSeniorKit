//
//  MVVMView.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "MVVMView.h"

@implementation MVVMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [self addSubview:_tableView];
    }
    return self;
}

@end

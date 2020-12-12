//
//  MVVMViewModel.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "MVVMViewModel.h"
#import "MVVMView.h"
#import "MVVMModel.h"

@implementation MVVMViewModel {
    MVVMView *_mView;
    NSMutableArray<MVVMModel *> *_dataSource;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray arrayWithCapacity:6];
    }
    return self;
}

- (void)configView:(MVVMView *)view {
    _mView = view;
    _mView.tableView.delegate = self;
    _mView.tableView.dataSource = self;
}


- (void)requestData:(nullable dispatch_block_t)done {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (done) {
            done();
        }
        MVVMModel *one = [[MVVMModel alloc] init];
        one.name = @"Kobe";
        MVVMModel *two = [[MVVMModel alloc] init];
        two.name = @"James";
        MVVMModel *three = [[MVVMModel alloc] init];
        three.name = @"Iverson";
        MVVMModel *four = [[MVVMModel alloc] init];
        four.name = @"T-Mac";
        MVVMModel *five = [[MVVMModel alloc] init];
        five.name = @"Shake";
        MVVMModel *six = [[MVVMModel alloc] init];
        six.name = @"Yao";
        [self->_dataSource addObjectsFromArray:@[one, two, three, four, five, six]];
        [self->_mView.tableView reloadData];
    });
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RecommendCell"];
    }
    cell.textLabel.text = _dataSource[indexPath.row].name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end

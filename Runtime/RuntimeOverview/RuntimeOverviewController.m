//
//  ViewController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/24.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "RuntimeOverviewController.h"
#import "EMBaseTableViewCellModel.h"
#import "RTOverviewViewController.h"

@interface RuntimeOverviewController ()

@end

@implementation RuntimeOverviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [iv startAnimating];
    [iv setHidesWhenStopped:YES];
    self.navigationItem.titleView = iv;
    
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [iv stopAnimating];
        [self prepareData];
    });
}

- (void)prepareData {
    
    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i1 = [EMBaseTableViewCellModel new];
    i1.title = @"概述";
    i1.targetClass = RTOverviewViewController.class;
    m1.cellModelArray = @[i1].mutableCopy;
    
    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i2 = [EMBaseTableViewCellModel new];
    i2.rowHeight = 88.f;
    m2.cellModelArray = @[i2,i2,i2].mutableCopy;
    
    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i3 = [EMBaseTableViewCellModel new];
    m3.cellModelArray = @[i3,i3].mutableCopy;
    
    EMBaseTableViewSectionModel *m4 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i4 = [EMBaseTableViewCellModel new];
    m4.cellModelArray = @[i4].mutableCopy;
    
    [self.dataSource addObjectsFromArray:@[m1, m2, m3, m4]];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    EMBaseTableViewCellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    EMBaseTableViewCellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[cellModel.targetClass new] animated:YES];
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

@end

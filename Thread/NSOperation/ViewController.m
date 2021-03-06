//
//  ViewController.m
//  NSOperation
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "TestCellModel.h"
#import "NSOperationOverviewController.h"
#import "NSBlockOperationController.h"
#import "NSInvocationOperationController.h"
#import "NSCustomOperationController.h"
#import "NSOperationQueueController.h"
#import "NSOperationOtherController.h"
#import "NSDeadOperationController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"NSOperation";
    
    [self prepareData];
}

- (void)prepareData {
    
    
    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
    TestCellModel *i11 = [TestCellModel new];
    i11.title = @"概述";
    i11.targetClass = NSOperationOverviewController.class;
    
    m1.cellModelArray = @[i11].mutableCopy;
    
    
    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    TestCellModel *i21 = [TestCellModel new];
    i21.rowHeight = 44.f;
    i21.title = @"NSBlockOperation";
    i21.targetClass = NSBlockOperationController.class;
    TestCellModel *i23 = [TestCellModel new];
    i23.title = @"NSInvocationOperation";
    i23.targetClass = DemoViewController.class;
    TestCellModel *i22 = [TestCellModel new];
    i22.title = @"NSCustomOperation";
    i22.targetClass = NSCustomOperationController.class;
    m2.cellModelArray = @[i21, i23, i22].mutableCopy;
    
    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
    TestCellModel *i31 = [TestCellModel new];
    i31.rowHeight = 44.f;
    i31.title = @"NSOperationQueue";
    i31.targetClass = NSOperationQueueController.class;
    m3.cellModelArray = @[i31].mutableCopy;
    
    EMBaseTableViewSectionModel *m4 = [EMBaseTableViewSectionModel new];
    TestCellModel *i41 = [TestCellModel new];
    i41.title = @"线程间通信、安全";
    i41.targetClass = NSOperationOtherController.class;
    TestCellModel *i42 = [TestCellModel new];
    i42.title = @"僵尸线程";
    i42.targetClass = NSDeadOperationController.class;
    m4.cellModelArray = @[i41, i42].mutableCopy;
    
    [self.dataSource addObjectsFromArray:@[m1, m2, m3, m4]];
    [self.tableView reloadData];
}
- (IBAction)replay:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    TestCellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    TestCellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[cellModel.targetClass new] animated:YES];
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

@end

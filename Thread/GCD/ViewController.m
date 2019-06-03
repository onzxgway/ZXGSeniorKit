//
//  ViewController.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "TestCellModel.h"
#import "GCDBaseTableViewController.h"
#import "GCDAPITableViewController.h"
#import "GCDOverviewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"GCD";
    
    [self prepareData];
}

- (void)prepareData {
    
    
    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
    TestCellModel *i11 = [TestCellModel new];
    i11.title = @"概述";
    i11.targetClass = GCDOverviewController.class;
    
    m1.cellModelArray = @[i11].mutableCopy;
    
    
    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    TestCellModel *i21 = [TestCellModel new];
    i21.rowHeight = 44.f;
    i21.title = @"串并队列 + 同步异步";
    i21.targetClass = GCDBaseTableViewController.class;
//    TestCellModel *i23 = [TestCellModel new];
//    i23.title = @"NSInvocationOperation";
//    i23.targetClass = NSInvocationOperationController.class;
    TestCellModel *i22 = [TestCellModel new];
    i22.title = @"GCD常用API";
    i22.targetClass = GCDAPITableViewController.class;
    m2.cellModelArray = @[i21, i22].mutableCopy;
    
//    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
//    TestCellModel *i31 = [TestCellModel new];
//    i31.rowHeight = 44.f;
//    i31.title = @"NSOperationQueue";
//    i31.targetClass = NSOperationQueueController.class;
//    m3.cellModelArray = @[i31].mutableCopy;
    
    [self.dataSource addObjectsFromArray:@[m1, m2]];
    [self.tableView reloadData];
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
    if (cellModel.targetClass == GCDBaseTableViewController.class) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        GCDBaseTableViewController *ctrl = [story instantiateViewControllerWithIdentifier:@"TableViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    else {
        [self.navigationController pushViewController:[cellModel.targetClass new] animated:YES];
    }
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}


@end

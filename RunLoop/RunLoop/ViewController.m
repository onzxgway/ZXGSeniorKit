//
//  ViewController.m
//  RunLoop
//
//  Created by 朱献国 on 2020/11/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "TestCellModel.h"
#import "EMBaseTableViewSectionModel.h"
#import "RLOneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
}

- (void)prepareData {
    
    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
    TestCellModel *i11 = [TestCellModel new];
    i11.title = @"CFRunLoopRun()";
    i11.targetClass = RLOneViewController.class;
    
    TestCellModel *i12 = [TestCellModel new];
    i12.title = @"CFRunLoopRef状态";
    i12.targetClass = RLOneViewController.class;

//    TestCellModel *i13 = [TestCellModel new];
//    i13.title = @"Class";
//    i13.targetClass = RTClassViewController.class;
//
//    TestCellModel *i14 = [TestCellModel new];
//    i14.title = @"SEL IMP Method";
//    i14.targetClass = SELIMPMethodController.class;
    
    m1.cellModelArray = @[i11, i12].mutableCopy;
    
    
    
//    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
//    TestCellModel *i21 = [TestCellModel new];
//    i21.rowHeight = 44.f;
//    i21.title = @"方法调用(消息发送)流程";
//    i21.targetClass = NSThreadOverviewController.class;
//    TestCellModel *i23 = [TestCellModel new];
//    i23.title = @"方法交换";
//    i23.targetClass = ExChangeMethodController.class;
//    TestCellModel *i22 = [TestCellModel new];
//    i22.title = @"类添加成员";
//    i22.targetClass = AddMemberController.class;
//    m2.cellModelArray = @[i21].mutableCopy;
    
    [self.dataSource addObjectsFromArray:@[m1]];
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
    [self.navigationController pushViewController:[cellModel.targetClass new] animated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

@end

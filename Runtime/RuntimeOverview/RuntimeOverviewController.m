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
#import "RTIsaViewController.h"
#import "RTClassViewController.h"
#import "SELIMPMethodController.h"
#import "MethodCalledController.h"
#import "AddMemberController.h"
#import "ExChangeMethodController.h"

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
    EMBaseTableViewCellModel *i11 = [EMBaseTableViewCellModel new];
    i11.title = @"概述";
    i11.targetClass = RTOverviewViewController.class;
    
    EMBaseTableViewCellModel *i12 = [EMBaseTableViewCellModel new];
    i12.title = @"isa指针";
    i12.targetClass = RTIsaViewController.class;
    
    EMBaseTableViewCellModel *i13 = [EMBaseTableViewCellModel new];
    i13.title = @"Class";
    i13.targetClass = RTClassViewController.class;
    
    EMBaseTableViewCellModel *i14 = [EMBaseTableViewCellModel new];
    i14.title = @"SEL IMP Method";
    i14.targetClass = SELIMPMethodController.class;
    
    m1.cellModelArray = @[i11, i12, i13, i14].mutableCopy;
    
    
    
    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i21 = [EMBaseTableViewCellModel new];
    i21.rowHeight = 44.f;
    i21.title = @"方法调用(消息发送)流程";
    i21.targetClass = MethodCalledController.class;
    EMBaseTableViewCellModel *i23 = [EMBaseTableViewCellModel new];
    i23.title = @"方法交换";
    i23.targetClass = ExChangeMethodController.class;
    EMBaseTableViewCellModel *i22 = [EMBaseTableViewCellModel new];
    i22.title = @"类添加成员";
    i22.targetClass = AddMemberController.class;
    m2.cellModelArray = @[i21, i23, i22].mutableCopy;
    
    
    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i3 = [EMBaseTableViewCellModel new];
    i3.title = @"";
    i3.targetClass = SELIMPMethodController.class;
    m3.cellModelArray = @[i3].mutableCopy;
    
    
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

//
//  ViewController.m
//  Network
//
//  Created by 朱献国 on 2020/10/19.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "ViewController.h"
#import "DownloadController.h"
#import "CellModel.h"
#import "BreakDownloadController.h"
#import "UploadController.h"
#import "InputStreamUploadController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"原生网络";
        
    [self prepareData];
}

- (void)prepareData {

//    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
//    CellModel *i11 = [CellModel new];
//    i11.title = @"概述";
//    i11.targetClass = NSOperationOverviewController.class;
//
//    m1.cellModelArray = @[i11].mutableCopy;


    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    CellModel *i21 = [CellModel new];
    i21.rowHeight = 44.f;
    i21.title = @"Download Image";
    i21.targetClass = DownloadController.class;
//    CellModel *i23 = [CellModel new];
//    i23.title = @"NSInvocationOperation";
//    i23.targetClass = DemoViewController.class;
    CellModel *i22 = [CellModel new];
    i22.title = @"BreakDownload Image";
    i22.targetClass = BreakDownloadController.class;
    m2.cellModelArray = @[i21, i22].mutableCopy;

    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
    CellModel *i31 = [CellModel new];
    i31.rowHeight = 44.f;
    i31.title = @"Upload Image";
    i31.targetClass = UploadController.class;
    
    CellModel *i32 = [CellModel new];
    i32.rowHeight = 44.f;
    i32.title = @"InputStream Upload Image";
    i32.targetClass = InputStreamUploadController.class;
    m3.cellModelArray = @[i31, i32].mutableCopy;

//    EMBaseTableViewSectionModel *m4 = [EMBaseTableViewSectionModel new];
//    CellModel *i41 = [CellModel new];
//    i41.title = @"线程间通信、安全";
//    i41.targetClass = NSOperationOtherController.class;
//    CellModel *i42 = [CellModel new];
//    i42.title = @"僵尸线程";
//    i42.targetClass = NSDeadOperationController.class;
//    m4.cellModelArray = @[i41, i42].mutableCopy;

    [self.dataSource addObjectsFromArray:@[m2, m3]];
    [self.tableView reloadData];
}
- (IBAction)replay:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    CellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];

    cell.textLabel.text = cellModel.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    EMBaseTableViewSectionModel *secModel = [self.dataSource objectAtIndex:indexPath.section];
    CellModel *cellModel = [secModel.cellModelArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[cellModel.targetClass new] animated:YES];

}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}


@end

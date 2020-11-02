//
//  HomeViewController.m
//  RuntimeApplyScene
//
//  Created by 朱献国 on 2020/11/1.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "EMBaseTableViewCellModel.h"
#import "DictModelViewController.h"
#import "KVOViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
}

- (void)prepareData {
    
    EMBaseTableViewSectionModel *m1 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i11 = [EMBaseTableViewCellModel new];
    i11.title = @"消息机制";
    i11.targetClass = MessageViewController.class;
    
//    EMBaseTableViewCellModel *i12 = [EMBaseTableViewCellModel new];
//    i12.title = @"isa指针";
//    i12.targetClass = RTIsaViewController.class;
//
//    EMBaseTableViewCellModel *i13 = [EMBaseTableViewCellModel new];
//    i13.title = @"Class";
//    i13.targetClass = CTMClassViewController.class;
//
//    EMBaseTableViewCellModel *i14 = [EMBaseTableViewCellModel new];
//    i14.title = @"SEL IMP Method";
//    i14.targetClass = SELIMPMethodController.class;
//
    m1.cellModelArray = @[i11].mutableCopy;
    
    
    
    EMBaseTableViewSectionModel *m2 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i21 = [EMBaseTableViewCellModel new];
    i21.rowHeight = 44.f;
    i21.title = @"字典转模型";
    i21.targetClass = DictModelViewController.class;
//    EMBaseTableViewCellModel *i23 = [EMBaseTableViewCellModel new];
//    i23.title = @"方法交换";
//    i23.targetClass = ExChangeMethodController.class;
//    EMBaseTableViewCellModel *i22 = [EMBaseTableViewCellModel new];
//    i22.title = @"类添加成员";
//    i22.targetClass = AddMemberController.class;
    m2.cellModelArray = @[i21].mutableCopy;


    EMBaseTableViewSectionModel *m3 = [EMBaseTableViewSectionModel new];
    EMBaseTableViewCellModel *i3 = [EMBaseTableViewCellModel new];
    i3.title = @"KVO";
    i3.targetClass = KVOViewController.class;
    m3.cellModelArray = @[i3].mutableCopy;


//    EMBaseTableViewSectionModel *m4 = [EMBaseTableViewSectionModel new];
//    EMBaseTableViewCellModel *i4 = [EMBaseTableViewCellModel new];
//    i4.title = @"KVO底层实现";
//    i4.targetClass = KVOViewController.class;
//    m4.cellModelArray = @[i4].mutableCopy;
    
    [self.dataSource addObjectsFromArray:@[m1, m2, m3]];
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

- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}

@end

//
//  DemoView.m
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "DemoView.h"
#import "DemoViewModel.h"

@interface DemoView() <UITableViewDelegate, UITableViewDataSource, MAnimalViewModelDelegate>

@end

@implementation DemoView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        // 视图层 与 视图模型层 建立关系
        self.viewModel = [[DemoViewModel alloc] init];
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)refreshData {
    [self.viewModel reloadData];
}

#pragma mark -- MAnimalViewModel Delegate
- (void)viewModel:(DemoViewModel *)viewModel reloadRow:(NSInteger)row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadDataWithViewModel:(DemoViewModel *)viewModel {
    [self reloadData];
}

#pragma mark -- Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    MAnimalCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MAnimalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    MAnimalViewModel *viewModel = [self.viewModel animalEntityWitIndexPath:indexPath.row];
    
    cell.textLabel.text = viewModel.name;
    cell.detailTextLabel.text = viewModel.summary;
    [cell showImageWithData:viewModel.imageData];
    
    return cell;
}

#pragma mark -- UITableView Delegate
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"Delete"
                                                                          handler:^(UITableViewRowAction *action,
                                                                                    NSIndexPath *indexPath) {
                                                                              [self.viewModel deleteWithRow:indexPath.row];
                                                                              
                                                                              [tableView beginUpdates];
                                                                              [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                              [tableView endUpdates];
                                                                          }];
    return @[deleteAction];
}

@end


@implementation MAnimalCell

- (void)showImageWithData:(NSData *)data {
    if (data) {
        self.imageView.image = [UIImage imageWithData:data];
    }
}

@end

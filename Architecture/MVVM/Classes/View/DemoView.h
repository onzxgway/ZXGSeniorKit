//
//  DemoView.h
//  MVVM
//
//  Created by 朱献国 on 2020/12/9.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DemoViewModel;

NS_ASSUME_NONNULL_BEGIN

/*
 1，界面展示。
 2，用户交互。
*/
@interface DemoView : UITableView

@property (nonatomic, strong) DemoViewModel *viewModel;

- (void)refreshData;

@end

@interface MAnimalCell : UITableViewCell

- (void)showImageWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END

//
//  MVVMViewModel.h
//  MVVM
//
//  Created by 朱献国 on 2020/12/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MVVMView;

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)configView:(MVVMView *)view;

- (void)requestData:(nullable dispatch_block_t)done;

@end

NS_ASSUME_NONNULL_END

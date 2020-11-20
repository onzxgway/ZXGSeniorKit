//
//  TestCellModel.h
//  NSThread
//
//  Created by 朱献国 on 2019/5/30.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestCellModel : NSObject <EMBaseTableViewCellModelAble>

@property (nonatomic) Class cellClass;                  // cell类 cell重用标识符

@property (nonatomic) CGFloat rowHeight;                // cell行高

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) Class targetClass;

@end

//
//  CellModel.h
//  Network
//
//  Created by 朱献国 on 2020/10/19.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellModel : NSObject <EMBaseTableViewCellModelAble>

@property (nonatomic) Class cellClass;                  // cell类 cell重用标识符

@property (nonatomic) CGFloat rowHeight;                // cell行高

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) Class targetClass;

@end

NS_ASSUME_NONNULL_END

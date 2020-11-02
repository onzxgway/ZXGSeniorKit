//
//  EMBaseTableViewCellModel.h
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/24.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBaseTableViewCellModel : NSObject <EMBaseTableViewCellModelAble>

@property (nonatomic) Class cellClass;
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic, copy) NSString *title;
@property (nonatomic) Class targetClass;

@end

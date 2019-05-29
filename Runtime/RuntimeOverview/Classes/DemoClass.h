//
//  DemoClass.h
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/26.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 应用场景：
 
 方法交换：  1. 可变容器(字典、数组等)的空操作、下标越界的导致程序crash的问题。
           2. 检测类实例的内存释放 dealloc。
           3. UITableView 或 UICollectionView 的reloadData方法，添加缺省页面。
 类添加方法：
            1. 解决系统的兼容性的问题。 例如 NSString的 containsString: ios(8.0),
 */

@interface DemoClass : NSObject <NSObject> {
    NSNumber *_age;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong, readonly) NSNumber *height;

- (void)iCanDoIt;

+ (void)testMethod;

- (void)tryDoIt:(NSString *)things; // 该方法有声明，没实现

@end

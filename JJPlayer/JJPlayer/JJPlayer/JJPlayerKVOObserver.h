//
//  JJPlayerKVOObserver.h
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 需求：添加、移除(单个\全部)KVO，带缓存。
/**
 思路：
 1.内部基于原生KVO实现。
 2.缓存,就是数组。
 
 优点：安全、方便
    1.防止重复添加。
    2.防止移除不存在的监听。
    3.一次移除被观察对象全部监听。
 */

@interface JJPlayerKVOObserver : NSObject

- init __deprecated;

- (instancetype)initWithTarget:(id)target NS_DESIGNATED_INITIALIZER;

- (void)jj_addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(nullable void *)context;

- (void)jj_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

- (void)jj_removeAllObservers;

@end

NS_ASSUME_NONNULL_END

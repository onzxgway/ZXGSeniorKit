//
//  DemoClass+Test.h
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "DemoClass.h"

@interface DemoClass (Test)

- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

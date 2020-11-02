//
//  NSObject+KVO.h
//  Runtime
//
//  Created by san_xu on 2017/9/12.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void)zxg_addObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nonnull)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

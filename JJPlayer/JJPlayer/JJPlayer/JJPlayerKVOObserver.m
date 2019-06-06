//
//  JJPlayerKVOObserver.m
//  JJPlayer
//
//  Created by 朱献国 on 2019/6/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

#import "JJPlayerKVOObserver.h"

@interface JJKVOEntry : NSObject
@property (nonatomic, weak  ) id observer;
@property (nonatomic, strong) NSString *keyPath;
@end
@implementation JJKVOEntry
@end

@interface JJPlayerKVOObserver ()
@property (nonatomic, weak  ) id target; // 被观察的对象
@property (nonatomic, strong) NSMutableArray<JJKVOEntry *> *cacheAryM;
@end

@implementation JJPlayerKVOObserver

- (instancetype)init {
    return [self initWithTarget:[NSNull null]];
}

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}

- (void)jj_addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(nullable void *)context {
    
    if (!self.target) return;
    
    JJKVOEntry *res = [self checkCache:observer forKeyPath:keyPath];
    
    if (res) return;
    
    @try {
        [self.target addObserver:observer forKeyPath:keyPath options:options context:context];
        
        JJKVOEntry *entry = [[JJKVOEntry alloc] init];
        entry.observer = observer;
        entry.keyPath = keyPath;
        [self.cacheAryM addObject:entry];
    } @catch (NSException *exception) {
        NSLog(@"JJPlayerKVOObserver: failed to add observer for %@\n", keyPath);
    }
}

- (void)jj_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    if (!self.target) return;
    
    JJKVOEntry *res = [self checkCache:observer forKeyPath:keyPath];
    
    if (!res) return;
    
    @try {
        [self.target removeObserver:observer forKeyPath:keyPath];
        
        [self.cacheAryM removeObject:res];
    } @catch (NSException *exception) {
        NSLog(@"JJPlayerKVOObserver: failed to remove observer for %@\n", keyPath);
    }
    
}

- (void)jj_removeAllObservers {
    
    if (!self.target) return;
    
    [self.cacheAryM enumerateObjectsUsingBlock:^(JJKVOEntry *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj == nil) return;
        if (obj.observer == nil) return;
        
        @try {
            [self.target removeObserver:obj.observer forKeyPath:obj.keyPath];
            
        } @catch (NSException *exception) {
            NSLog(@"JJPlayerKVOObserver: failed to remove observer for %@\n", obj.keyPath);
        }
        
    }];
    
    [self.cacheAryM removeAllObjects];
    
}

- (JJKVOEntry *)checkCache:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    __block NSInteger index = -1;
    [self.cacheAryM enumerateObjectsUsingBlock:^(JJKVOEntry *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.keyPath isEqualToString:keyPath] && obj.observer == observer) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index > -1) {
        return [self.cacheAryM objectAtIndex:index];
    }

    return nil;
}

- (NSMutableArray *)cacheAryM {
    if (!_cacheAryM) {
        _cacheAryM = [NSMutableArray array];
    }
    return _cacheAryM;
}

@end

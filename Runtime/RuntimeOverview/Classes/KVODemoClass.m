//
//  KVODemoClass.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/29.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "KVODemoClass.h"
#import <objc/runtime.h>

@implementation KVODemoClass

- (void)setName:(NSString *)name {
    [super setName:name];
    
    //向监听对象发送消息
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"name");
    [observer observeValueForKeyPath:@"name" ofObject:self change:nil context:nil];
}

@end

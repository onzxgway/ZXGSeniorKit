//
//  Person.h
//  Runtime
//
//  Created by san_xu on 2017/9/12.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign)NSUInteger age;

- (NSString *)sayHello;

- (NSString *)howOldAreYou:(NSString *)name;

+ (NSString *)howOldAreYou:(NSString *)name;

- (void)sayHi:(NSString *)to;

+ (void)createClass;

@end

@interface Man : Person

@end

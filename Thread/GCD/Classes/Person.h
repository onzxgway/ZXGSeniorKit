//
//  Person.h
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy ) NSString *name;
@property (nonatomic, copy ) NSString *email;

@property (nonatomic, strong) dispatch_queue_t queue;

- (void)setProperty:(NSString *)name email:(NSString *)email;

@end

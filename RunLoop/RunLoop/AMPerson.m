//
//  AMPerson.m
//  RunLoop
//
//  Created by 朱献国 on 2020/11/8.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "AMPerson.h"

@implementation AMPerson

- (id)copyWithZone:(nullable NSZone *)zone {
    
    AMPerson *p = [[self.class allocWithZone:zone] init];
    p.name = [self.name copy];
    return p;
}

@end

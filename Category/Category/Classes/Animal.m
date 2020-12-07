//
//  Animal.m
//  Category
//
//  Created by 朱献国 on 2020/11/23.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "Animal.h"

@implementation Animal

+ (void)load {
    NSLog(@"Animal: load");
}

- (void)cry {
    NSLog(@"Animal: cry");
}

+ (void)initialize {
    NSLog(@"Animal: initialize");
}

@end


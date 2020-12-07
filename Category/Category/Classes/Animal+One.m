//
//  Animal+One.m
//  Category
//
//  Created by 朱献国 on 2020/11/23.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "Animal+One.h"

@implementation Animal (One)

- (void)jump {
    NSLog(@"Animal: jump");
}

+ (void)name {
    NSLog(@"My name is Animal");
}

- (void)setAge:(int)age {
    
}

- (int)age {
    return 10;
}

//+ (void)initialize {
//    NSLog(@"Animal(One): initialize");
//}

@end

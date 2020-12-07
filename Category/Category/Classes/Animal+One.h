//
//  Animal+One.h
//  Category
//
//  Created by 朱献国 on 2020/11/23.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Animal (One) <NSCopying>

- (void)jump;

+ (void)name;

@property (nonatomic, assign) int age;

@end

NS_ASSUME_NONNULL_END

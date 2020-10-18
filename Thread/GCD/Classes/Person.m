//
//  Person.m
//  GCD
//
//  Created by 朱献国 on 2019/6/3.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, strong) NSMutableArray *happies;

@property (nonatomic, strong) NSMutableDictionary *lalalala;

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _happies = [NSMutableArray array];
        _lalalala = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setProperty:(NSString *)name email:(NSString *)email {
    
    //    dispatch_barrier_async(_queue, ^{
    //        self.name = name;
    //    [self.happies addObject:email];
    [self.lalalala setObject:email forKey:name];
    [self randomDelay:0.5f];
    //        self.email = email;
    //    });
    
}

- (NSString *)description {
    
    //    __block NSString *res = nil;
    //    dispatch_sync(_queue, ^{
    //        res = [NSString stringWithFormat:@"%@ + %@", self.name, self.email];
    //    });
    //
    //    return [NSString stringWithFormat:@"%@ + %@", self.name, self.email];
    
    //    NSMutableString *totalS = [NSMutableString string];
    //    for (NSString *tempS in self.happies) {
    //        [totalS appendString:tempS];
    //        [totalS appendString:@"  "];
    //    }
    //    return totalS;
    
    return [self.lalalala description];
}

- (void)randomDelay:(double)maxDuration {
    NSTimeInterval randomWait = arc4random_uniform(maxDuration * USEC_PER_SEC);
    usleep(randomWait);
}

@end

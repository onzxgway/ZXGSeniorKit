//
//  DemoClass.h
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/26.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoClass : NSObject <NSObject> {
    NSNumber *_age;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong, readonly) NSNumber *height;

- (void)iCanDoIt;

+ (void)testMethod;

@end

//
//  Animal.h
//  KVOAndKVC
//
//  Created by 朱献国 on 2020/12/6.
//  Copyright © 2020 朱献国. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject {
    @public
    NSString *_name;
}

@property(nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END

//
//  NSObject+DictToModel.h
//  Runtime
//
//  Created by san_xu on 2017/9/13.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DictToModel)

+ (__kindof NSObject *)modelWithDict:(NSDictionary *)dict;

+ (__kindof NSObject *)deepModelWithDict:(NSDictionary *)dict;

+ (void)methodList;

@end

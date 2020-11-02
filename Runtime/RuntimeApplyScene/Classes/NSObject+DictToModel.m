//
//  NSObject+DictToModel.m
//  Runtime
//
//  Created by san_xu on 2017/9/13.
//  Copyright © 2017年 onzxgway. All rights reserved.
//

#import "NSObject+DictToModel.h"
#import <objc/message.h>
#import <CoreData/CoreData.h>

@implementation NSObject (DictToModel)

+ (__kindof NSObject *)modelWithDict:(NSDictionary *)dict {
    // 创建对应类的对象
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    //遍历当前类的所有成员属性
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; ++i) {
        //0.获取成员属性
        Ivar ivar = ivars[i];
        //1.获取成员属性 名称
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //2.使用正则截取字符串
        NSString *targetPropertyName = [propertyName substringFromIndex:1];
        if (dict[targetPropertyName]) {
            [objc setValue:dict[targetPropertyName] forKey:targetPropertyName];
        }
        
    }
    
    return objc;
}

+ (__kindof NSObject *)deepModelWithDict:(NSDictionary *)dict {
    // 创建对应类的对象
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    //遍历当前类的所有成员属性
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; ++i) {
        //0.获取成员属性
        Ivar ivar = ivars[i];
        //1.获取成员属性 名称
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //1.获取成员属性 类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //3.使用正则截取字符串
        NSString *targetPropertyName = [propertyName substringFromIndex:1];
        
        //4.判断是否是字典，如果是就二次转换
        id value = dict[targetPropertyName];
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSRange range = [propertyType rangeOfString:@"@\""];
            NSString *newStr = [propertyType substringFromIndex:range.length + range.location];
            NSString *targetStr = [newStr substringToIndex:newStr.length - 1];
            Class clazz = NSClassFromString(targetStr);
            if (clazz && ![self isClassFromFoundation:clazz]) {
                value = [clazz deepModelWithDict:value];
            }
        }
        if (value) {
            [objc setValue:value forKey:targetPropertyName];
        }
        
    }
    
    return objc;
}

+ (void)methodList {
    unsigned int count = 0;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; ++i) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSLog(@"%@",NSStringFromSelector(sel));
    }
}

//判断当前类c是否是Foundation框架中的模型类
+ (BOOL)isClassFromFoundation:(Class)c {
    if (c == [NSObject class] || c == [NSManagedObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class  _Nonnull clazz, BOOL * _Nonnull stop) {
        if ([c isSubclassOfClass:clazz]) {//isSubclassOfClass判断是否是相同的类对象，或者和子类对象相同。
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

static NSSet *foundationClasses_;

+ (NSSet *)foundationClasses {
    if (!foundationClasses_) {
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSData class],
                              [NSDate class],
                              [NSValue class],
                              [NSError class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

@end

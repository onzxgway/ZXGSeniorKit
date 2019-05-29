//
//  AddMemberController.m
//  RuntimeOverview
//
//  Created by 朱献国 on 2019/5/28.
//  Copyright © 2019年 朱献国. All rights reserved.
//

#import "AddMemberController.h"
#import <objc/runtime.h>
#import "DemoClass.h"
#import "DemoClass+Test.h"

@interface AddMemberController ()

@end

@implementation AddMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = @"";
    self.descLab.text = @"";
    self.detailLab.text = @"";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self addMethod]; // 给动态创建的类 添加成员
    [self addMember]; // 给类 添加成员
    
//    DemoClass *obj = [[DemoClass alloc] init];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored  "-Wundeclared-selector"
//    [obj performSelector:@selector(iCanDoIt) withObject:nil afterDelay:0];
//#pragma clang diagnostic pop
}

// 给类 添加成员
// 需求：给 DemoClass，添加成员、属性
- (void)addMember {
    Class clazz = DemoClass.class;
    
    const char * ivarName1 = "_sex";
    // 0.已经存在的类，不能再添加成员变量
    BOOL res = class_addIvar(clazz, ivarName1, sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    NSLog(@"%@", res ? @"ivar 添加成功": @"ivar 添加失败");
    
    // 1.为DemoClass类添加show成员方法
    Method exchangeM = class_getInstanceMethod([self class], @selector(eatWithPersonName:));
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    BOOL resM = class_addMethod(clazz, @selector(showSex), class_getMethodImplementation([self class], @selector(eatWithPersonName:)), method_getTypeEncoding(exchangeM));
#pragma clang diagnostic pop
    NSLog(@"%@", resM ? @"Method 添加成功": @"Method 添加失败");
    
    DemoClass *obj = [[DemoClass alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    [obj performSelector:@selector(showSex) withObject:@"kobe" afterDelay:0]; 
#pragma clang diagnostic pop
    
    // 2.为DemoClass类添加和已存在方法同名的方法  肯定添加失败
    Method preM = class_getInstanceMethod(self.class, @selector(highCopy));
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    BOOL resO = class_addMethod(clazz, @selector(iCanDoIt), class_getMethodImplementation([self class], @selector(highCopy)), method_getTypeEncoding(preM));
#pragma clang diagnostic pop
    NSLog(@"%@", resO ? @"同名Method 添加成功": @"同名Method 添加失败");
    
    // 3.为DemoClass类添加tryDoIt成员方法实现部分
    [obj tryDoIt:@"Learning"];
}

- (void)eatWithPersonName:(NSString *)name {
    NSLog(@"Person %@ start eat.",name);
}

- (void)highCopy {
    NSLog(@"highCopy iCanDoIt.");
}

// 给动态创建的类 添加成员
// 需求：动态创建一个NSObject的子类CustomObj，并且添加成员
- (void)addMethod {
    
    // 0.先判断目标类是否存在，不存在再创建
    if (NSClassFromString(@"CustomObj")) {
        return;
    }
    
    // 1.创建一个NSObject的子类CustomObj。
    Class cusV = objc_allocateClassPair(NSObject.class, "CustomObj", 0);
    
    // 2.1 为CustomObj类添加normalM成员方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    class_addMethod(cusV, @selector(normalM), (IMP)normalM, "v@:");
#pragma clang diagnostic pop
    
    // 2.2 为CustomObj类添加_name、_age成员变量
    /**
     类添加成员变量
     param 被操作类
     param 成员变量名称
     param 变量内存所占大小
     param 变量对齐方式
     param 变量类型编码
     */
    /*
     优点：动态添加的Ivar，能够通过遍历Ivars得到我们所添加的属性。
     缺点：已存在的class中不能添加Ivar，所有必须通过objc_allocateClassPair动态创建一个class，才能调用class_addIvar添加Ivar，最后通过objc_registerClassPair注册class。
     */
    NSString *iVarName1 = @"_name", *iVarName2 = @"_age";
    BOOL resOne = class_addIvar(cusV, [iVarName1 UTF8String], sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    BOOL resTwo = class_addIvar(cusV, [iVarName2 UTF8String], sizeof(NSNumber *), log2(sizeof(NSNumber *)), @encode(NSNumber *));
    
    // 2.3 为CustomObj类添加sex属性
    /*
     优点：能够在已有的类中添加property，且能够遍历到动态添加的属性。
     缺点：比较麻烦，getter和setter需要自己写，且值也需要自己存储，如上面的代码，我是把setter中的值存储到了_dictCustomerProperty里面，在getter中再从_dictCustomerProperty读出值。
     */
    NSString *propertyName = @"sex";
    
    // 先判断有没有这个属性，没有就添加，有就直接赋值
    Ivar ivar = class_getInstanceVariable(cusV, [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar == nil) {
        objc_property_attribute_t type = {"T", [[NSString stringWithFormat:@"@\"%@\"", NSStringFromClass([NSString class])] UTF8String]}; // type = NSString
        objc_property_attribute_t ownership0 = {"C", ""};  // C = copy
        objc_property_attribute_t ownership = {"N", ""};   // N = nonatomic
        objc_property_attribute_t backingivar  = {"V", [[NSString stringWithFormat:@"_%@", propertyName] UTF8String] };  // variable name
        // Type encoding must be first，Backing ivar must be last。
        objc_property_attribute_t attrs[] = {type, ownership0, ownership, backingivar};
        BOOL result = class_addProperty(cusV, [propertyName UTF8String], attrs, 4);
        if (result) {
            // 添加get和set方法
            class_addMethod(cusV, NSSelectorFromString(propertyName), (IMP)getter, "@@:");
            class_addMethod(cusV, NSSelectorFromString([NSString stringWithFormat:@"set%@:", [propertyName capitalizedString]]), (IMP)setter, "v@:@");
        }
        else {
            class_replaceProperty(cusV, [propertyName UTF8String], attrs, 4);
            // 添加get和set方法
            class_addMethod(cusV, NSSelectorFromString(propertyName), (IMP)getter, "@@:");
            class_addMethod(cusV, NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)setter, "v@:@");
        }

    }
    
    // 3. 注册该类  注册之后，不能再添加成员变量了
    objc_registerClassPair(cusV);
    
    
    // 创建CustomObj实例
    id obj = [[cusV alloc] init];
    if (resOne && resTwo) {
        [obj setValue:@"jack zhu" forKey:iVarName1];
        [obj setValue:@18 forKey:iVarName2];
    }
//    [obj setValue:@"man" forKey:propertyName]; // 这种给属性赋值会失败
//    [obj setSex:@"man"];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored  "-Wundeclared-selector"
    [obj performSelectorOnMainThread:@selector(normalM) withObject:nil waitUntilDone:YES];
#pragma clang diagnostic pop
    
    [self printProperty:cusV];
}

void normalM(id self, SEL _cmd) {
    // 2.2 获取CustomObj类的_name、_age成员变量的值
    Ivar ivarN = class_getInstanceVariable([self class], [@"_name" UTF8String]);
    Ivar ivarA = class_getInstanceVariable([self class], [@"_age" UTF8String]);
    if (ivarN) {
        id value = object_getIvar(self, ivarN);
        NSLog(@"_name:%@", value);
    }
    if (ivarA) {
        id value = object_getIvar(self, ivarA);
        NSLog(@"_age:%@", value);
    }
    
    // 2.3 获取CustomObj类的sex属性的值
    //先判断有没有这个属性，没有就添加，有就直接赋值
    Ivar ivar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@", @"sex"] UTF8String]);
    if (ivar) {
        NSLog(@"_sex:%@", object_getIvar(self, ivar));
    }
    
    ivar = class_getInstanceVariable([self class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dict = object_getIvar(self, ivar);
    if (dict && [dict objectForKey:@"sex"]) {
        NSLog(@"_sex:%@", [dict objectForKey:@"sex"]);
    } else {
        NSLog(@"_sex:nil");
    }
    
}

id getter(id self, SEL _cmd) {
    NSString *key = NSStringFromSelector(_cmd);
    Ivar ivar = class_getInstanceVariable([self class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self, ivar);
    return [dictCustomerProperty objectForKey:key];
}

void setter(id self, SEL _cmd, id newValue) {
    // 移除set
    NSString *key = [NSStringFromSelector(_cmd) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    // 首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    // 移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    
    Ivar ivar = class_getInstanceVariable([self class], "_dictCustomerProperty");  //basicsViewController里面有个_dictCustomerProperty属性
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self, ivar);
    if (!dictCustomerProperty) {
        dictCustomerProperty = [NSMutableDictionary dictionary];
        object_setIvar(self, ivar, dictCustomerProperty);
    }
    [dictCustomerProperty setObject:newValue forKey:key];
}

// 打印 属性列表
- (void)printProperty:(Class)clazz {
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "::: %s %s\n", property_getName(property), property_getAttributes(property));
    }
    
}


@end

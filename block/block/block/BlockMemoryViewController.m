/**
 1、当你的block没有使用外部变量的时候，通通都是global的，无论你怎么修饰、无论是否成员变量；
 2、全局变量、静态变量、静态局部变量在block中的存储，block都为globalBlock
 3、当在block里添加了外部变量，那么block的内存就会变成不一样: 当block赋值给strong变量、(非weak的)成员变量，block为mallocBlock；
 4、当block为自己的函数参数，block为stackBlock；
 5、static变量无法加__block符的
 
 
 block本身就是在栈区，arc，当你有外部变量，strong、copy，那么iOS系统会自动给它copy，就从栈区到了堆区；
 栈区：内存是由系统管理的，堆区是由程序员管理（怎么管理呢：通过这两个函数malloc release）；但是arc下，release系统给你加了，release也不需要了，malloc也是系统给你自动添加了。
 
 
 1、函数参数 栈区  weak变量修饰的时候 也是在栈区
 2、如果没有外部变量（外部变量如果是global、static）block都是在全局区
 3、如果有外部变量的情况下，当你被strong、copy修饰的时候，会从栈转移到堆区
 */

#import "BlockMemoryViewController.h"
#import <objc/runtime.h>

typedef void(^testBlock)(void);
typedef void(^testBlock1)(int);
@interface BlockMemoryViewController ()

@property(nonatomic, strong)testBlock strongBlock;
@property(nonatomic, copy)testBlock copyBlock;
@property(nonatomic, weak)testBlock weakBlock;

@property(nonatomic, strong)testBlock1 strongBlock1;
@property(nonatomic, copy)testBlock1 copyBlock1;
@property(nonatomic, weak)testBlock1 weakBlock1;

@end

@implementation BlockMemoryViewController

int globalV = 666;
static int staticV = 888;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    int tempV = 100;
    _strongBlock = ^{
//        NSLog(@"_strongBlock %d", globalValue1);
//        NSLog(@"_strongBlock %d", tempV);
    };
    _copyBlock = ^{
//        NSLog(@"_copyBlock %d", staticValue1);
        NSLog(@"_copyBlock %d", globalV);
    };
    _weakBlock = ^{
//        NSLog(@"_weakBlock %d", k);
        NSLog(@"_copyBlock %d", staticV);
    };
    
    NSLog(@"_strongBlock %s  _copyBlock %s  _weakBlock %s", object_getClassName(_strongBlock), object_getClassName(_copyBlock), object_getClassName(_weakBlock));
    
    _strongBlock1 = ^(int i){
//        NSLog(@"_strongBlock1 : i=%d", k);
    };
    _copyBlock1 = ^(int i){
//        NSLog(@"_copyBlock1 : i=%d", k);
    };
    _weakBlock1 = ^(int i){
//        NSLog(@"_weakBlock1 : i=%d", k);
    };
 
    NSLog(@"_strongBlock1 %s  _copyBlock1 %s  _weakBlock1 %s", object_getClassName(_strongBlock1), object_getClassName(_copyBlock1), object_getClassName(_weakBlock1));
 
    
//    [self testBlock:^{
//
//        NSLog(@"%d", k);
//
//    }];
//
//    testBlock block = [self block];
}

// 如果是你自定义的函数，有参数为block，那么block是在栈区的，但是系统的方法调用，它会是堆区的
- (void)testBlock:(testBlock)block {
    
    NSLog(@"%@", object_getClass(block));
    
}

- (testBlock)block {
    
    int i = 10;
    return ^{
        NSLog(@"%d", i);
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    _weakBlock1(10);
    _weakBlock();
    
}

@end

//
//  BlockStructureViewController.m
//  Block原理VIP
//
//  Created by 八点钟学院 on 2017/4/25.
//  Copyright © 2017年 八点钟学院. All rights reserved.
//

/**
 1、空的block
 2、包含简单类型（如int型）block
 3、包含临时的objc对象的block
 4、成员变量（objc）
 5、包含__block的变量
 6、global value
 7、全局static value
 8、局部static value
 */

#import "BlockStructureViewController.h"

typedef void(^eocblock)();

@interface BlockStructureViewController () {
    
    UILabel *label;
    eocblock instanceBlock;
}

@end

@implementation BlockStructureViewController
int globalValue = 10;
static int staticValue = 5;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self objcDataBlockFunction];
    
}

- (void)emptyBlockFunction {
    
    void (^emptyBlock)() = ^{
      
        NSLog(@"八点钟学院");
        
    };
    
    emptyBlock();
}

- (void)simpleDataBlockFunction {
    
    int i = 10;
    void (^simpleDataBlock)() = ^{
        
        NSLog(@"八点钟学院 %d", i);
        
    };
    
    simpleDataBlock();
}


- (void)objcDataBlockFunction {
    
    UILabel *tmpLabel = [[UILabel alloc] init];
    
    void (^objcDataBlock)() = ^{
        
        NSLog(@"八点钟学院, %@", tmpLabel);
        
    };
    
    objcDataBlock();
}

- (void)classDataBlockFunction {
    
    
    //self是一个结构体，你要访问结构体的变量，结构体指针->变量  或者结构体.变量
    void (^classDataBlock)() = ^{
        
        NSLog(@"八点钟学院 %@", label);
        
    };
    
    classDataBlock();
}


//__block 实质上会转化为一个结构体，结构体里有forwarding ，forwarding指向结构体自己
//block刚开始是在栈里面，通过block构造函数，我让block里面的结构体为上面结构体的地址（同一个东西)
//运行的时候，从栈拷贝到堆区，那么会新生成一个堆区的block ，这个堆区的block里面的结构体的forwarding指向堆区block；栈里面的结构体里的forwarding指向的是堆区block的forwarding；

- (void)blockDataBlockFunction {
    
    __block int a = 100;
    
    //我们的block本身是在栈区，当你赋值给strong的变量的时候，它会从栈到堆区
    
    void (^blockDataBlock)() = ^{
        
        a = 1000;
        NSLog(@"八点钟学院, %d", a);
        
    };
    
    blockDataBlock();
    NSLog(@"栈区a = %d", a);
}

- (void)globalDataBlockFunction {
    
    void (^globalDataBlock)() = ^{
        
        NSLog(@"八点钟学院 %d", globalValue);
        
    };
    
    globalDataBlock();
}

- (void)staticDataBlockFunction {
    
    void (^staticDataBlock)() = ^{
        
        NSLog(@"八点钟学院 %d", staticValue);
        
    };
    
    staticDataBlock();
}

- (void)tmpStaticDataBlockFunction {
    
    //下面这个静态变量，它的作用域是在这个函数内部，但是它的内存永远存在（只要app还在），因为它是存在静态变量区的
    //看这个局部静态变量，那么你可以对比下globalvalue，全局静态变量
    //通过传地址，让静态变量b的值可以一处修改，到处相同（达到globalVlue和全局静态变量的效果）；
    
    //为什么要传地址，你要知道把一个变量作为实参，变量是不能改变的；那么，你可以以变量的地址作为实参传过去，那么这个地址不能改变，但是你可以改变地址里面的内容。
    
    static int b = 11;
    
    instanceBlock = ^{
        
//        b = 110;
        NSLog(@"八点钟学院 %d", b);
        
    };
    
    b= 100;
//    tmpStaticDataBlock();
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    instanceBlock();
    
}

@end

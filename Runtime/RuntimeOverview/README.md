#  知识点总结

1. 约束不同类具备共同的属性或者方法的实现方案有哪些？
 *** 继承共同的父类  *** 实现相同的协议 
 
2. 类(对象)在runtime面前是透明的，通过runtime可以获取到所有信息, 并且可以添加 成员变量、成员函数、协议、属性等。
     注意：属性列表、成员变量列表、成员函数列表、协议列表 (不论是私有还是共有的都能获取到) 

3. Objective-C 是一门面向对象的编程语言，按照面向对象语言的设计原则，所有的事物都应该是对象。 在Objective-C语言中，每一个类实际上也是一个对象，每一个类都有一个isa的指针。每个类也可以接收消息，例如[NSObject alloc],就是向NSObject类发送名为 alloc 的消息。
    
    因为类也是一个对象，所以它必须是另一个类的实例，这个类就是元类。元类保存了类方法的列表。当一个类方法被调用时，元类会首先查找它本身是否有该类方法的实现，如果没有，则该元类会向它的父类查找该方法，这样就可以一直找到继承链的头。
    
    元类也是一个对象，那么它的isa指针又指向哪里呢？为了设计上的完整，所有的元类的isa指针都会指向一个根元类。根元类本身的isa指向自己，这样就形成了一个闭环。 Objective-C中万物皆对象，对象都有isa。
    详情查看（截图/one.png)
    
4.  去掉警告⚠️
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored  "警告类型"
    
    #pragma clang diagnostic pop
    
    
5. runtime给类添加成员、属性
    非动态创建的类， 可以添加成员方法、属性，不可以添加成员变量
    动态创建的类， 可以添加成员方法、成员变量、属性

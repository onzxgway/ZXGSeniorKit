//
//  PropertyController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/6.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    属性
        定义：将值与特定的类型关联。
        分类：
            1. 按照关联
                * 实例属性
                * 类型属性
            2. 按照功能
                * 存储属性
                * 计算属性
 */


// MARK: - 实例属性 -> 计算属性 与 存储属性
struct Person {
    
    /*
     一：存储属性
        定义：会将常量或变量存储为类型实例的一部分。（内存中实实在在开辟了物理的存储空间）
        适用范围：1.类
                2.结构体
        使用注意点:
                1. 由于结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
     */
    internal var name: String
    internal let eyes: Int
    
    /*
     存储属性延迟加载
        定义：当第一次被调用的时候才会计算其初始值的属性
     
     使用场景： 当属性的值依赖于一些外部因素且这些外部因素只有在构造过程结束之后才会知道的时候，延时加载属性就会很有用。或者当获得属性的值因为需要复杂或者大量的计算，而需要采用的时候再计算的方式，延时加载属性也会很有用。
     
     优点：减少内存压力。用到的时候再加载到内存中。
     缺点：懒加载的属性，不能手动赋值nil释放。（OC可以）
     
     懒加载注意点：
        1. 懒加载的属性，必须是变量var修饰，原因是：
            因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延时加载。
        2. 采用 {方法体}() 方式给属性赋值，相当于匿名方法。声明的时候，并不执行方法，之后首次用到的时刻再执行。
        3. 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
     */
    internal lazy var fullName: String = {
        return "zhu" + "xianguo"
    }()
}


struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    
    var origin = Point.init()
    var size = Size.init()
    /*
     二：计算属性
        定义：不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
     适用范围：   1.类
                2.结构体
                3.枚举
     使用场景：
        如下：一个 Rect 的中心点可以从 origin和 size算出，所以不需要将中心点以 Point类型的值来保存。Rect的计算属性center提供了自定义的getter 和setter来获取和设置矩形的中心点，就像它有一个存储属性一样。
     使用注意点:
        1.必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
        2.计算型属性，死循环问题。
     */
    var center: Point {
        set(newCenter) {
            origin.x = newCenter.x - size.width * 0.5
            origin.y = newCenter.y - size.height * 0.5
        }
        get {
            let x = origin.x + size.width * 0.5
            let y = origin.y + size.height * 0.5
            return Point.init(x: x, y: y)
        }
    }
    
    // set 和 get 简化版
    var centerr: Point {
        get {
            return Point.init(x: origin.x + size.width * 0.5,
                              y: origin.y + size.height * 0.5)
        }
        set {
            origin.x = newValue.x - size.width * 0.5
            origin.y = newValue.y - size.height * 0.5
        }
    }
    
    // 计算型属性，这种写法会导致死循环。
//    var age: Int {
//        set(newValue) {
//            age = newValue
//        }
//        get {
//            return age
//        }
//    }
    
}


// MARK: - 属性观察器
/*
 使用场景：
    你可以为除了延时加载存储属性之外的其他存储属性添加属性观察器，你也可以在子类中通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。你不必为非重写的计算属性添加属性观察器，因为你可以直接通过它的 setter 监控和响应值的变化。
 注意事项：
     * 在父类初始化方法调用之后，在子类构造器中给父类的属性赋值时，会调用父类属性的 willSet 和 didSet 观察器。而在父类初始化方法调用之前，给子类的属性赋值时不会调用子类属性的观察器。
     * 在构造方法内赋值 或者在 声明时候赋默认值，都是不调用willSet和didSet方法的。
     * 即使设置的值和原来值相同，willSet和didSet也会被调用。
 */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            
        }
        
        didSet {
            
        }
    }
}


// MARK: - 类型属性
/*
    类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性。
    类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量（就像 C 语言中的静态常量），或者所有实例都能访问的一个变量（就像 C 语言中的静态变量）。
 
    注意：
 1.跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    // 可以改用关键字 class 来支持子类对父类的实现进行重写。
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
                // didSet 属性观察器将 currentLevel 设置成了不同的值，但这不会造成属性观察器被再次调用。
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}


class PropertyController: SyntaxBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        stored properties
//        var p1 = Person.init(name: "kobe", eyes: 2, fullName: nil)
//        p1.name = "Jack"
//        let p2 = Person.init(name: "Jack", eyes: 2, fullName: nil)
////        p2.name = "hehe"
    
        
//        computed properties
        var square = Rect.init(origin: Point.init(x: 0.0, y: 0.0), size: Size.init(width: 10.0, height: 10.0))
//        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    }

}


// MARK: - 第一次总结
/*
    属性：将值与特定类型关联。
 
    分类：
        按关联类型标准：
            1.实例属性：将值与类型实例关联
            2.类型属性：将值与类型关联
        按功能：
            1.存储属性：属性作为实例的一部分。
            2.计算属性：提供set和get方法，操作其他属性或者变量使用的。
 
 */

/*
    存储属性：
        适用范围：类 和 结构体
 
        可懒加载
 
        使用注意点：
            1.常量、变量皆可
    计算属性：（节省内存）
        适用范围：类 、结构体 和 枚举
 
        不可懒加载
 
        使用注意点：
            1.只能是变量（因为计算属性的值是可变的）
 
    二者相同点：
        1，都可继承重写。
        2，从外部看都是属性，都可以通过点语法调用。
 */

/*
    属性观察器：
        1.懒加载之外的存储属性 + 继承的存储属性
        2.继承的计算属性
 */

/*
 类型属性：
    1.存储类型属性声明的时候一定要赋值，因为类型没有默认的初始化器。
    2.存储类型属性都是懒加载的。
 */


// MARK: - 第二次总结 20190828
/*
 
    属性：将值与特定类型关联。
            *实例属性：将值与特定类型实例关联。
            *类型属性：将值与特定类型本身关联。
 
    存储属性：实例的组成部分，内存有分配。
    计算属性：提供了setter或getter方法，通过方法去获取设置其他的属性或变量。
 
    分类： 1. 实例存储
          2. 实例计算
 
        3.类型存储
        4.类型计算

 */

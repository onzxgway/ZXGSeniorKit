//
//  HSecondThreeController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/8/4.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    Swift注释：
        1.单行 //
        2.多行 /*
                */
        3.文档 /**
                */
 */
class HSecondThreeController: HSecondViewController {
    
    // stored properties
    internal var age: Int? = 18
    internal var name: String? = "166"
    // computerd properties
    internal var full: String {
        return "haha"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var v3 = Vector3(x: 1, y: 2, z: 3)
        
        // 一般的访问形式是
        print("\(v3.x)    \(v3.y)    \(v3.z)")
        // 现在需要通过下标访问类型实例
        print("\(v3[0])   \(v3[1])   \(v3[2])")
        print("\(v3["x"]) \(v3["y"]) \(v3["Z"])")
        
        v3[0] = 100; print("\(v3[0])")
        
        
        var mx = Matrix.init(rows: 3, columns: 3)
        mx[2, 2] = 8.0
        
//        let liqude = Liqude.init()
        
//        let directionToHead = CompassPoint.east
//        print(directionToHead)
        
        six_switch()
    }
    
    // MARK: - Subscripts 下标 给类型实例添加像数组一样通过下标访问的能力。
    /**
     类、结构体和枚举都可以定义下标，下标是访问集合、列表或序列的成员元素的快捷方式。
     在Swift中的定义是：让类型实例具备像数组一样通过下标访问的能力。
     */
    subscript(index: Int) -> Int {
        // newValue的类型与下标的返回值相同
        set(newValue) {
            self.age = newValue
        }
        
        get {
            if index == 0 , let temp = self.age {
                return temp
            }
            else if let temp = self.name, index == 1 {
                return Int(temp)!
            }
            else {
                return 888
            }
        }
    }

    
    // 1.搭配switch语句使用
    func one_switch(_ index: Int) -> Void {
        
        var temp = CompassPoint.north
        if index == 0 {
            temp = CompassPoint.south
        }
        else {
            temp = CompassPoint.east
        }
        
        switch temp {
        case .east:
            print("east")
        case .south:
            print("south")
        case .west:
            print("west")
        case .north:
            print("north")
        }
    }
    
    // 2.遍历枚举
    func two_switch() -> Void {
        for temp in Planet.allCases {
            print(temp)
        }
    }
    
    // 3.关联值
    func three_switch() -> Void {
        let qrcode = Barcode.qrCode("QRCode", 10)
        
// 如果枚举的所有关联值都被提取为常量或者变量，则可以在前面放置单个var或let注释，以简洁起见
//        switch qrcode {
//        case .qrCode(let name, let num):
//            print("\(name) + \(num)")
//        case .upc(let length, let width, let height):
//            print("\(length) + \(width) + \(height)")
//        }
        
        switch qrcode {
        case let .qrCode(name, num):
            print("\(name) + \(num)")
        case let .upc(length, width, height):
            print("\(length) + \(width) + \(height)")
        }
    }
    
    // 4.原始值
    func four_switch() -> Void {
        print(Season.summer)
        print(Season.summer.rawValue)
    }
    
    // 5.使用原始值初始化枚举实例
    func five_switch() -> Void {
        if let season = Season.init(rawValue: 3) {
            switch season{
            case .spring:
                print("spring")
            case .summer:
                print("summer")
            case .autumn:
                print("autumn")
            case .winter:
                print("winter")
            }
        }
        else {
            print("凉凉")
        }
    }
    
    // 6.递归枚举
    func six_switch() -> Void {
        
        let five = ArithmeticExpression.number(5)
        print(evaluate(five))
        let four = ArithmeticExpression.number(4)
        print(evaluate(four))
        let sum = ArithmeticExpression.addition(five, four)
        print(evaluate(sum))
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        print(evaluate(product))
        
    }
    
    func evaluate(_ expression:ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(value1, value2):
            return evaluate(value1) + evaluate(value2)
        case let .multiplication(value1, value2):
            return evaluate(value1) - evaluate(value2)
        }
    }

    
}

// MARK: - Enumeration
/*
    定义：为一组关联值定义了一个公共类型，并使您能够在代码中以类型安全的方式使用这些值。
 
    性质：* 声明的枚举未分配默认整数值。
         * 和结构体一样属于值类型。
         * 枚举选项的类型必须相同
 
    使用场景：
        1.使用Switch语句匹配枚举值
        2.遍历枚举。待遍历的枚举类型必须实现 CaseIterable 协议
        3.关联值
        4.原始值，类型必须相同
            注意: 原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
        5.使用原始值初始化枚举实例 (返回值是枚举成员或nil)
        6.递归枚举
 */

enum CompassPoint {
    case east
    case south
    case west
    case north
}

enum Planet: CaseIterable {
    case earth, moon, sun
}

enum Barcode {
    case qrCode(String, Int)
    case upc(Int, Int, Int)
}

// 原始值
// Character 类型的枚举
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case ineFeed = "\n"
    case carriageReturn = "\r"
}

// 原始值的隐式赋值
// 当使用整数作为枚举成员的原始值时，隐式赋值的值依次递增1
enum Season: Int {
    case spring = 0
    case summer
    case autumn
    case winter
}

// 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
enum SSeason: String {
    case spring
    case summer
    case autumn
    case winter
}

// 递归枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}


// MARK: - Structures And Classes
/*
    相同点：  （概括为：属性、方法、扩展、协议）
         定义属性来存储值
         定义方法来提供功能
         定义下标以使用下标语法提供对其值的访问
         定义初始化器来设置它们的初始状态
         扩展以扩展其功能，使其超出默认实现
         遵守协议以提供某种标准功能
 
    不同点：
        类：
             引用类型 (定义：赋值或者传递的时候，是指针传递的形式。)
             继承，一个类能够继承另一个类的特征。
             类型转换使您能够在运行时检查和解释类实例的类型。
             析构方法，使类的实例能够释放它所分配的任何资源。
        结构体：
             值类型 (定义：赋值或者传递的时候，是拷贝的形式。)
 
 
    使用不同点：
        类：
            类没有自动生成的初始化器。
        结构体：
        所有结构体都有一个自动生成的成员初始化器，新实例属性的初始值可以通过名称传递给初始化器。
 
 */

protocol Test {
    
}

class Liqude: Test {
    // stored
    internal var address: String?
    internal var phoneNumber: String?
    
    // computed
    internal var message: String {
        set (newValue) {
            
        }
        get {
            return "welcome to suzhou!"
        }
    }
    
    internal func sum(_ a: Double, b: Double) -> Double {
        return a + b
    }
}

extension Liqude {
    
}

struct Vector3: Test {
    
    // stored perporties
    internal var x: Double = 0.0
    internal var y: Double = 0.0
    internal var z: Double = 0.0
    
    internal func sum(_ x: Double, y: Double, z: Double) -> Double {
        return x + y + z
    }
    
    // 类或结构可以根据需要提供尽可能多的下标实现，并且将根据在使用下标时包含在下标括号中的值的类型推断要使用的适当下标。这种对多个下标的定义称为下标重载。
    subscript(index: Int) -> Double {
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: fatalError("下标越界")
            }
        }
        set(newValue){  // set里面的newValue的类型和函数的返回值类型是一致的
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: fatalError("下标越界")
            }
        }
    }
    
    // 这个下标访问只读
    subscript(axis: String) -> Double {
        switch axis {
        case "x","X": return x
        case "y","Y": return y
        case "z","Z": return z
        default: fatalError("非法下标")
        }
    }
}

extension Vector3 {
    
}

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    // 虽然下标通常只接受一个参数，但是如果下标适合您的类型，您还可以定义一个包含多个参数的下标
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

extension Matrix : Test {
    
}

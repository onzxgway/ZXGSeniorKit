//
//  EnumerationController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class EnumerationController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Enumeration"
        
        six_switch()
    }
    
    // 1.使用Switch语句匹配枚举值
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
 
 性质：  * 声明的枚举未分配默认整数值。
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

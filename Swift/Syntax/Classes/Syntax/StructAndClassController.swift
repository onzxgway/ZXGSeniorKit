//
//  StructAndClassController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class StructAndClassController: SyntaxBaseController {

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
    }

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

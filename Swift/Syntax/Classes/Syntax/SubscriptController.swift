//
//  SubscriptController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit


// MARK: - Subscripts 下标 给类型实例添加像数组一样通过下标访问的能力。
/**
 类、结构体和枚举都可以定义下标，下标是访问集合、列表或序列的成员元素的快捷方式。
 在Swift中的定义是：让类型实例具备像数组一样通过下标访问的能力。
 
 使用注意事项：
    1.类或结构可以根据需要提供尽可能多的下标实现，并且将根据在使用下标时包含在下标括号中的值的类型推断要使用的适当下标。这种对多个下标的定义称为下标重载。
        
 */

class SubscriptController: SyntaxBaseController {
    
    // stored properties
    internal var age: Int? = 18
    internal var name: String? = "166"

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

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

}

struct LixCon: Test {
    
    // stored perporties
    internal var x: Double = 0.0
    internal var y: Double = 0.0
    internal var z: Double = 0.0
    
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
